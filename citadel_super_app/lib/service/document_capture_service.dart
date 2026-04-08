import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:citadel_super_app/screen/universal/simple_document_capture_screen.dart';

enum DocumentType {
  myKad,
  passport,
  iKad,
  myTentera,
  myPR,
  myKid,
}

extension DocumentTypeExtension on DocumentType {
  String get displayName {
    switch (this) {
      case DocumentType.myKad:
        return 'MyKad';
      case DocumentType.passport:
        return 'Passport';
      case DocumentType.iKad:
        return 'iKad';
      case DocumentType.myTentera:
        return 'MyTentera';
      case DocumentType.myPR:
        return 'MyPR';
      case DocumentType.myKid:
        return 'MyKid';
    }
  }

  String get value {
    switch (this) {
      case DocumentType.myKad:
        return 'MYKAD';
      case DocumentType.passport:
        return 'PASSPORT';
      case DocumentType.iKad:
        return 'IKAD';
      case DocumentType.myTentera:
        return 'MYTENTERA';
      case DocumentType.myPR:
        return 'MYPR';
      case DocumentType.myKid:
        return 'MYKID';
    }
  }
}

class DocumentCaptureService {
  final ImagePicker _picker = ImagePicker();

  /// Capture document image from camera with simple bounding box guide
  Future<String?> captureFromCamera({
    required BuildContext context,
    bool isBackSide = false,
  }) async {
    try {
      // Navigate to simple capture screen with bounding box
      final String? base64Image = await Navigator.of(context).push<String?>(
        MaterialPageRoute(
          builder: (context) => SimpleDocumentCaptureScreen(
            isBackSide: isBackSide,
          ),
        ),
      );

      return base64Image;
    } catch (e) {
      return null;
    }
  }

  /// Pick document image from gallery
  Future<String?> pickFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1600,
        maxHeight: 900,
      );

      if (image == null) return null;

      return await _processImage(image);
    } catch (e) {
      return null;
    }
  }

  /// Process image to base64
  Future<String?> _processImage(XFile image) async {
    try {
      final File file = File(image.path);
      final Uint8List bytes = await file.readAsBytes();

      // Convert to base64
      return base64Encode(bytes);
    } catch (e) {
      return null;
    }
  }

  /// Capture selfie image from camera
  Future<String?> captureSelfie() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1280,
        maxHeight: 720,
        preferredCameraDevice: CameraDevice.front,
      );

      if (image == null) return null;

      return await _processImage(image);
    } catch (e) {
      return null;
    }
  }

  /// Pick selfie image from gallery
  Future<String?> pickSelfieFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1280,
        maxHeight: 720,
      );

      if (image == null) return null;

      return await _processImage(image);
    } catch (e) {
      return null;
    }
  }
}
