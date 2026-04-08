const path = require('path');

async function test() {
  try {
    console.log('Loading face-api...');
    
    const wasmBuildPath = path.resolve(__dirname, 'node_modules/@vladmandic/face-api/dist/face-api.node-wasm.js');
    const faceapi = require(wasmBuildPath);
    console.log('face-api loaded');
    
    // Initialize TensorFlow WASM backend FIRST
    console.log('Initializing TensorFlow WASM backend...');
    const tf = faceapi.tf;
    await tf.ready();
    console.log('TF backend:', tf.getBackend());
    
    // Now load models
    const modelsPath = path.join(__dirname, 'node_modules/@vladmandic/face-api/model');
    console.log('Loading models from:', modelsPath);
    
    console.log('Loading SSD MobileNet...');
    await faceapi.nets.ssdMobilenetv1.loadFromDisk(modelsPath);
    console.log('Loading FaceLandmark...');
    await faceapi.nets.faceLandmark68Net.loadFromDisk(modelsPath);
    console.log('Loading FaceRecognition...');
    await faceapi.nets.faceRecognitionNet.loadFromDisk(modelsPath);
    console.log('All models loaded!');
    
    // Monkey patch canvas
    const { createCanvas, Canvas, Image, ImageData } = require('@napi-rs/canvas');
    faceapi.env.monkeyPatch({ Canvas, Image, ImageData, createCanvasElement: () => createCanvas(1, 1) });
    
    const { loadImage } = require('@napi-rs/canvas');
    const TEST_IMAGES_DIR = 'C:/Users/FooFangKhai/Downloads/Super APP Migration/Testing Images';
    
    const docBuffer = require('fs').readFileSync(path.join(TEST_IMAGES_DIR, 'id_front_image.jpg'));
    const selfieBuffer = require('fs').readFileSync(path.join(TEST_IMAGES_DIR, 'face_image.jpg'));
    
    console.log('Loading images...');
    const docImage = await loadImage(docBuffer);
    const selfieImage = await loadImage(selfieBuffer);
    
    console.log('Detecting faces...');
    const options = new faceapi.SsdMobilenetv1Options({ minConfidence: 0.4 });
    
    const docDetection = await faceapi.detectSingleFace(docImage, options).withFaceLandmarks().withFaceDescriptor();
    const selfieDetection = await faceapi.detectSingleFace(selfieImage, options).withFaceLandmarks().withFaceDescriptor();
    
    console.log('Document detection:', !!docDetection);
    console.log('Selfie detection:', !!selfieDetection);
    
    if (docDetection && selfieDetection) {
      const distance = faceapi.euclideanDistance(docDetection.descriptor, selfieDetection.descriptor);
      console.log('\n=== RESULT ===');
      console.log('Distance:', distance);
      console.log('Threshold: 0.45');
      console.log('Verified:', distance <= 0.45);
    } else {
      if (!docDetection) console.log('ERROR: No face detected in ID document');
      if (!selfieDetection) console.log('ERROR: No face detected in selfie');
    }
    
  } catch (err) {
    console.error('Error:', err.message);
    console.error(err.stack);
  }
}

test();
