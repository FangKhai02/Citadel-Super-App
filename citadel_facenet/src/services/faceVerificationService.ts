/**
 * Face Verification Service
 *
 * Uses @vladmandic/face-api (FaceNet-based) to compare two face images and
 * determine whether they belong to the same person.
 *
 * Uses the WASM build of face-api with @tensorflow/tfjs (pure JS, no native
 * binaries required). Models ship with the npm package.
 * Path: node_modules/@vladmandic/face-api/model/
 *
 * If initialisation fails the service degrades gracefully and returns
 * { verified: false, score: -1, degraded: true }.
 */

import * as fs from 'fs';
import * as path from 'path';

// Models are bundled inside the npm package — no extra download step needed.
const BUNDLED_MODELS_DIR = path.join(
  __dirname,
  '../../node_modules/@vladmandic/face-api/model',
);
const LOCAL_MODELS_DIR = path.join(__dirname, '../../models');
const FACE_MATCH_THRESHOLD = 0.45; // euclidean distance; lower = more similar

// Lazily loaded face-api instance (avoids cold-start penalty at module load)
let faceapi: typeof import('@vladmandic/face-api') | null = null;
let modelsLoaded = false;
let initError: string | null = null;

async function ensureInitialized(): Promise<boolean> {
  if (modelsLoaded) return true;
  // Reset error on retry so a server restart always gets a fresh attempt
  initError = null;

  try {
    // Use the WASM build — works on Node.js without native bindings or
    // Visual Studio. The default 'node' entry requires @tensorflow/tfjs-node
    // which needs compiled C++ bindings unavailable on newer Node versions.
    // eslint-disable-next-line @typescript-eslint/no-require-imports
    const wasmBuildPath = path.resolve(
      __dirname,
      '../../node_modules/@vladmandic/face-api/dist/face-api.node-wasm.js',
    );
    // eslint-disable-next-line @typescript-eslint/no-var-requires
    faceapi = require(wasmBuildPath) as typeof import('@vladmandic/face-api');

    // face-api needs a canvas implementation in Node.
    // @napi-rs/canvas ships prebuilt binaries for Windows/Mac/Linux.
    //
    // IMPORTANT: face-api internally calls createCanvasElement() with NO
    // arguments (browser-style: create first, set dimensions later). But
    // @napi-rs/canvas requires dimensions in the constructor. We provide a
    // custom createCanvasElement that starts 1×1 — face-api then sets the
    // actual width/height via property setters before using it.
    const { createCanvas, Canvas, Image, ImageData } = await import('@napi-rs/canvas');
    (faceapi as any).env.monkeyPatch({
      Canvas,
      Image,
      ImageData,
      createCanvasElement: () => createCanvas(1, 1),
    } as any);

    // The node-wasm build of face-api bundles its own TF WASM backend.
    // Do NOT import @tensorflow/tfjs separately — doing so creates a second
    // conflicting TF registry that can abort the Node.js process on Windows.
    // Instead, call tf.ready() via the face-api internal reference.
    const tf = (faceapi as any).tf;
    if (tf && typeof tf.ready === 'function') {
      await tf.ready();
      console.log('[FaceVerification] TF backend ready:', tf.getBackend?.() ?? 'unknown');
    } else {
      console.log('[FaceVerification] TF reference not found via faceapi.tf — proceeding without explicit tf.ready()');
    }

    // Verify model files exist before attempting to load
    const requiredFiles = [
      'ssd_mobilenetv1_model-weights_manifest.json',
      'face_landmark_68_model-weights_manifest.json',
      'face_recognition_model-weights_manifest.json',
    ];

    // Try bundled npm package first, fall back to local directory
    let modelsPath: string | null = null;

    const bundledFilesPresent = requiredFiles.every((f) =>
      fs.existsSync(path.join(BUNDLED_MODELS_DIR, f)),
    );

    if (bundledFilesPresent) {
      modelsPath = BUNDLED_MODELS_DIR;
      console.log('[FaceVerification] Using bundled models from npm package');
    } else {
      console.warn('[FaceVerification] Bundled models not found, attempting local fallback');

      const localFilesPresent = requiredFiles.every((f) =>
        fs.existsSync(path.join(LOCAL_MODELS_DIR, f)),
      );

      if (localFilesPresent) {
        modelsPath = LOCAL_MODELS_DIR;
        console.log('[FaceVerification] Using models from local directory');
      }
    }

    if (!modelsPath) {
      initError = `Face model files not found. Checked: ${BUNDLED_MODELS_DIR} and ${LOCAL_MODELS_DIR}`;
      console.error(`[FaceVerification] ${initError}`);
      return false;
    }

    await faceapi.nets.ssdMobilenetv1.loadFromDisk(modelsPath);
    await faceapi.nets.faceLandmark68Net.loadFromDisk(modelsPath);
    await faceapi.nets.faceRecognitionNet.loadFromDisk(modelsPath);

    modelsLoaded = true;
    console.log('[FaceVerification] All models loaded successfully');
    return true;
  } catch (err) {
    initError = err instanceof Error ? err.message : 'Face-api init failed';
    console.error('[FaceVerification] Initialization error:', initError);
    return false;
  }
}

export interface FaceComparisonResult {
  /** true when the two faces likely belong to the same person */
  verified: boolean;
  /**
   * Euclidean distance between the 128-d FaceNet embeddings.
   * Range: 0.0 (identical) – ~2.0 (completely different).
   * Values below the threshold (0.45) are treated as a match.
   * Lower threshold = stricter matching = higher security.
   * Returns -1 when models are unavailable (degraded mode).
   */
  score: number;
  /** true when models could not be loaded and no real comparison was done */
  degraded: boolean;
}

/**
 * Compares two face images and returns a similarity result.
 *
 * @param documentImageBase64  Base64 string of the identity document image
 * @param selfieImageBase64    Base64 string of the selfie image
 */
export async function compareFaces(
  documentImageBase64: string,
  selfieImageBase64: string,
): Promise<FaceComparisonResult> {
  const ready = await ensureInitialized();

  if (!ready || !faceapi) {
    // Graceful degradation: models not available
    return { verified: false, score: -1, degraded: true };
  }

  // Convert base64 to Buffer
  const documentImageBuffer = Buffer.from(documentImageBase64, 'base64');
  const selfieImageBuffer = Buffer.from(selfieImageBase64, 'base64');

  // Pass Image objects directly — face-api reads .width/.height from them.
  // Wrapping in a Canvas first causes face-api to lose dimension metadata
  // (it calls new Canvas(undefined, undefined) internally and aborts).
  const { loadImage } = await import('@napi-rs/canvas');

  const [docImage, selfieImage] = await Promise.all([
    loadImage(documentImageBuffer),
    loadImage(selfieImageBuffer),
  ]);

  const detectionOptions = new faceapi.SsdMobilenetv1Options({
    minConfidence: 0.4,
  });

  const [docDetection, selfieDetection] = await Promise.all([
    faceapi
      .detectSingleFace(docImage as any, detectionOptions)
      .withFaceLandmarks()
      .withFaceDescriptor(),
    faceapi
      .detectSingleFace(selfieImage as any, detectionOptions)
      .withFaceLandmarks()
      .withFaceDescriptor(),
  ]);

  if (!docDetection) {
    throw new Error('No face detected in the identity document image. Please upload a clearer photo.');
  }
  if (!selfieDetection) {
    throw new Error('No face detected in the selfie. Please retake the photo in good lighting.');
  }

  const distance = faceapi.euclideanDistance(
    docDetection.descriptor,
    selfieDetection.descriptor,
  );

  return {
    verified: distance <= FACE_MATCH_THRESHOLD,
    score: parseFloat(distance.toFixed(4)),
    degraded: false,
  };
}
