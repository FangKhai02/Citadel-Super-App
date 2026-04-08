const http = require('http');
const fs = require('fs');
const { createCanvas, loadImage } = require('@napi-rs/canvas');
const path = require('path');

// Resize image to smaller dimensions
async function resizeImage(imagePath, maxSize = 800) {
  const img = await loadImage(fs.readFileSync(imagePath));
  const canvas = createCanvas(maxSize, maxSize);
  const ctx = canvas.getContext('2d');

  // Calculate dimensions to fit within maxSize while preserving aspect ratio
  let width = img.width;
  let height = img.height;

  if (width > height) {
    if (width > maxSize) {
      height = (height * maxSize) / width;
      width = maxSize;
    }
  } else {
    if (height > maxSize) {
      width = (width * maxSize) / height;
      height = maxSize;
    }
  }

  canvas.width = width;
  canvas.height = height;
  ctx.drawImage(img, 0, 0, width, height);

  return canvas.toBuffer('image/jpeg', { quality: 0.8 });
}

async function test() {
  console.log('Loading and resizing images...');

  const faceImage = await resizeImage('face_image.jpg');
  const idImage = await resizeImage('id_front_image.jpg');

  const faceBase64 = faceImage.toString('base64');
  const idBase64 = idImage.toString('base64');

  console.log('Resized face image:', faceBase64.length, 'chars');
  console.log('Resized ID image:', idBase64.length, 'chars');

  const postData = JSON.stringify({
    documentImage: idBase64,
    selfieImage: faceBase64
  });

  const options = {
    hostname: 'localhost',
    port: 3001,
    path: '/api/face/compare',
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Content-Length': Buffer.byteLength(postData)
    }
  };

  console.log('Sending request to FaceNet...');

  return new Promise((resolve, reject) => {
    const req = http.request(options, (res) => {
      let data = '';
      res.on('data', (chunk) => data += chunk);
      res.on('end', () => {
        console.log('Status:', res.statusCode);
        console.log('Response:', data);
        resolve(data);
      });
    });

    req.on('error', (e) => {
      console.error('Error:', e.message);
      reject(e);
    });

    req.write(postData);
    req.end();
  });
}

test().catch(console.error);
