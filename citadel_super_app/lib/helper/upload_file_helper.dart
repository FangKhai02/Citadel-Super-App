import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:citadel_super_app/service/log_service.dart';
import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

import 'package:http/http.dart' as http;

class UploadFileHelper {
  Future<File?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    return File(image.path);
  }

  Future<File?> takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    if (image == null) return null;

    return File(image.path);
  }

  Future<File?> pickDocumentFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpeg', 'jpg', 'pdf', 'heic'],
    );

    if (result == null) {
      return null;
    }
    File file = File(result.files.single.path!);
    return file;
  }

  Future<String> getImageBase64(String? filePath) async {
    if (filePath == null) return '';
    File image = File(filePath);
    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }

  Image getImageFromBase64({required String imageBase64}) {
    return Image.memory(base64Decode(imageBase64));
  }

  String getFileBase64(File file) {
    return base64Encode(file.readAsBytesSync());
  }

  Future<File> resizeImage(File file, int targetWidth, int targetHeight) async {
    final imageBytes = file.readAsBytesSync();
    final originalImage = img.decodeImage(imageBytes);

    if (originalImage == null) {
      throw Exception("Failed to decode image");
    }

    // Resize the image
    final resizedImage = img.copyResize(
      originalImage,
      width: targetWidth,
      height: targetHeight,
    );

    // Save the resized image to a new file
    final resizedImageFile = File(file.path)
      ..writeAsBytesSync(img.encodeJpg(resizedImage));

    return resizedImageFile;
  }

  String resizeBase64Image(String base64Image, int width, int height) {
    if (base64Image.isEmpty) {
      return '';
    }
    // Decode the Base64 string into bytes
    Uint8List decodedBytes = base64Decode(base64Image);

    // Decode the bytes into an image
    img.Image? image = img.decodeImage(decodedBytes);
    if (image == null) {
      throw Exception("Failed to decode the image");
    }

    // Resize the image
    img.Image resizedImage =
        img.copyResize(image, width: width, height: height);

    // Encode the resized image back to bytes
    Uint8List resizedBytes = Uint8List.fromList(img.encodeJpg(resizedImage));

    // Convert resized bytes to Base64
    return base64Encode(resizedBytes);
  }

  Future<Uint8List> getImageAsUint8List(String imageUrl) async {
    try {
      if (imageUrl.isEmpty) {
        return Uint8List(0);
      }

      // Fetch the image from the URL
      final http.Response response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Convert the response to raw bytes (Uint8List)
        return response.bodyBytes;
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching image: $e');
    }
  }

  Future<File?> cropImage({required File imageFile}) async {
    try {
      CroppedFile? croppedImg = await ImageCropper().cropImage(
          sourcePath: imageFile.path,
          compressQuality: 100,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            AndroidUiSettings(hideBottomControls: true, lockAspectRatio: true),
            IOSUiSettings(
                rotateClockwiseButtonHidden: true,
                rotateButtonsHidden: true,
                hidesNavigationBar: true,
                aspectRatioLockEnabled: true,
                resetButtonHidden: true,
                resetAspectRatioEnabled: false)
          ]);
      if (croppedImg == null) {
        return File(imageFile.path);
      } else {
        return File(croppedImg.path);
      }
    } catch (e) {
      appDebugPrint(e);
    }
    return File(imageFile.path);
  }
}
