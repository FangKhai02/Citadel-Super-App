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
export declare function compareFaces(documentImageBase64: string, selfieImageBase64: string): Promise<FaceComparisonResult>;
//# sourceMappingURL=faceVerificationService.d.ts.map