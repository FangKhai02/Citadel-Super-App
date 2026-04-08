import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:citadel_super_app/app_folder/app_color.dart';

class SimpleDocumentCaptureScreen extends StatefulWidget {
  final bool isBackSide;

  const SimpleDocumentCaptureScreen({
    super.key,
    this.isBackSide = false,
  });

  @override
  State<SimpleDocumentCaptureScreen> createState() =>
      _SimpleDocumentCaptureScreenState();
}

class _SimpleDocumentCaptureScreenState extends State<SimpleDocumentCaptureScreen> {
  late CameraController _cameraController;
  List<CameraDescription>? cameras;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras!.isNotEmpty) {
        _cameraController = CameraController(
          cameras![0],
          ResolutionPreset.high,
        );

        await _cameraController.initialize();

        if (!mounted) return;

        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      // Silently handle error
    }
  }

  Future<void> _captureDocument() async {
    try {
      final XFile picture = await _cameraController.takePicture();

      final File file = File(picture.path);
      final Uint8List bytes = await file.readAsBytes();
      final String base64Image = base64Encode(bytes);

      if (!mounted) return;

      Navigator.of(context).pop(base64Image);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error capturing image'),
            backgroundColor: AppColor.errorRed,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        backgroundColor: AppColor.mainBlack,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColor.brightBlue,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColor.mainBlack,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Camera preview
          CameraPreview(_cameraController),

          // Bounding box overlay
          CustomPaint(
            painter: BoundingBoxPainter(),
          ),

          // Top controls
          Positioned(
            top: 16.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 44.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: AppColor.mainBlack.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppColor.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColor.mainBlack.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: const Text(
                    'Document Capture',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom capture button
          Positioned(
            bottom: 32.h,
            left: 16.w,
            right: 16.w,
            child: GestureDetector(
              onTap: _captureDocument,
              child: Container(
                width: double.infinity,
                height: 56.h,
                decoration: BoxDecoration(
                  color: AppColor.brightBlue,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Center(
                  child: Text(
                    'Capture',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for bounding box overlay
class BoundingBoxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Bounding box size - larger to fit passport and other ID sizes
    // Using A7 passport size ratio approximately (125mm x 88mm = 1.42:1)
    final boxWidth = size.width * 0.85;
    final boxHeight = boxWidth / 1.42;

    final boxRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: boxWidth,
      height: boxHeight,
    );

    // Draw subtle corner markers
    final paint = Paint()
      ..color = AppColor.white.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final cornerLength = boxWidth * 0.12;

    // Top-left corner
    canvas.drawLine(
      Offset(boxRect.left, boxRect.top),
      Offset(boxRect.left + cornerLength, boxRect.top),
      paint,
    );
    canvas.drawLine(
      Offset(boxRect.left, boxRect.top),
      Offset(boxRect.left, boxRect.top + cornerLength),
      paint,
    );

    // Top-right corner
    canvas.drawLine(
      Offset(boxRect.right, boxRect.top),
      Offset(boxRect.right - cornerLength, boxRect.top),
      paint,
    );
    canvas.drawLine(
      Offset(boxRect.right, boxRect.top),
      Offset(boxRect.right, boxRect.top + cornerLength),
      paint,
    );

    // Bottom-left corner
    canvas.drawLine(
      Offset(boxRect.left, boxRect.bottom),
      Offset(boxRect.left + cornerLength, boxRect.bottom),
      paint,
    );
    canvas.drawLine(
      Offset(boxRect.left, boxRect.bottom),
      Offset(boxRect.left, boxRect.bottom - cornerLength),
      paint,
    );

    // Bottom-right corner
    canvas.drawLine(
      Offset(boxRect.right, boxRect.bottom),
      Offset(boxRect.right - cornerLength, boxRect.bottom),
      paint,
    );
    canvas.drawLine(
      Offset(boxRect.right, boxRect.bottom),
      Offset(boxRect.right, boxRect.bottom - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(BoundingBoxPainter oldDelegate) => false;
}
