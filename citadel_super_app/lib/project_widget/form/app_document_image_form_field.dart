import 'dart:convert';
import 'dart:typed_data';

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/state/microblink_result_state.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/service/document_capture_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum DocumentType {
  myKad,
  passport,
}

class AppDocumentImageFormField extends StatefulHookConsumerWidget {
  /// Provide formKey for auto-validate all filled with button
  final String documentType;
  Uint8List? frontImage;
  Uint8List? backImage;
  String fieldKey;
  final bool enabled;
  final Function(BlinkIdMultiSideRecognizerResult)? onRescanComplete;

  AppDocumentImageFormField({
    super.key,
    required this.documentType,
    this.frontImage,
    this.backImage,
    this.onRescanComplete,
    this.enabled = true,
    this.fieldKey = AppFormFieldKey.documentImageKey,
  });

  @override
  ConsumerState<AppDocumentImageFormField> createState() =>
      AppDocumentImageFormFieldState();
}

class AppDocumentImageFormFieldState
    extends ConsumerState<AppDocumentImageFormField> {
  bool hasError = false;
  bool isCapturingFront = false;
  bool isCapturingBack = false;

  bool validateImage() {
    final isPassport = widget.documentType.equalsIgnoreCase('Passport');
    setState(() {
      if (isPassport) {
        hasError = widget.frontImage == null;
      } else {
        hasError = widget.frontImage == null || widget.backImage == null;
      }
    });
    if (isPassport) {
      return widget.frontImage != null;
    }
    return widget.frontImage != null && widget.backImage != null;
  }

  bool onlyFrontImageScanning() {
    return widget.documentType.equalsIgnoreCase('Passport');
  }

  void setError(bool error) {
    setState(() {
      hasError = true;
    });
  }

  ({String? frontImage, String? backImage}) onSaved() {
    return (
      frontImage: widget.frontImage != null ? base64Encode(widget.frontImage!.toList()) : null,
      backImage: widget.backImage != null ? base64Encode(widget.backImage!.toList()) : null
    );
  }

  /// Capture document from camera or gallery
  Future<void> _captureDocument({required bool isFront}) async {
    final documentCaptureService = DocumentCaptureService();

    // Show source selection bottom sheet
    final source = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => _CaptureSourceBottomSheet(
        title: isFront ? 'Capture Front of Document' : 'Capture Back of Document',
        description: isFront
            ? 'Position the front of your ID in the frame'
            : 'Position the back of your ID in the frame',
      ),
    );

    if (source == null) return;

    setState(() {
      if (isFront) {
        isCapturingFront = true;
      } else {
        isCapturingBack = true;
      }
    });

    try {
      String? imageBase64;
      if (source == 'camera') {
        imageBase64 = await documentCaptureService.captureFromCamera();
      } else {
        imageBase64 = await documentCaptureService.pickFromGallery();
      }

      if (imageBase64 == null) return;

      // Create legacy result for backward compatibility
      final legacyResult = BlinkIdMultiSideRecognizerResult(
        fullDocumentFrontImage: isFront ? imageBase64 : widget.frontImage != null ? base64Encode(widget.frontImage!) : null,
        fullDocumentBackImage: !isFront ? imageBase64 : widget.backImage != null ? base64Encode(widget.backImage!) : null,
      );

      setState(() {
        if (isFront) {
          widget.frontImage = Uint8List.fromList(base64Decode(imageBase64!));
          isCapturingFront = false;
        } else {
          widget.backImage = Uint8List.fromList(base64Decode(imageBase64!));
          isCapturingBack = false;
        }
        ref.invalidate(microblinkResultProvider);
        ref.watch(microblinkResultProvider.notifier).setMicroblinkResult(legacyResult);
        widget.onRescanComplete?.call(legacyResult);
        validateImage();
      });

      // Show success feedback
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(isFront ? 'Front captured' : 'Back captured'),
              ],
            ),
            backgroundColor: AppColor.brightBlue,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      setState(() {
        if (isFront) {
          isCapturingFront = false;
        } else {
          isCapturingBack = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPassport = widget.documentType.equalsIgnoreCase('Passport');
    final needsBackImage = !isPassport;

    return Container(
      constraints: BoxConstraints(minWidth: 1.sh),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColor.mainBlack,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: hasError ? AppColor.errorRed : Colors.transparent,
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Front Image Section
          _DocumentImageCard(
            label: '${widget.documentType} (Front)',
            image: widget.frontImage,
            isLoading: isCapturingFront,
            onCapture: widget.enabled ? () => _captureDocument(isFront: true) : null,
            onClear: widget.enabled ? () {
              setState(() {
                widget.frontImage = null;
                validateImage();
              });
            } : null,
          ),
          if (needsBackImage) ...[
            gapHeight16,
            // Back Image Section
            _DocumentImageCard(
              label: '${widget.documentType} (Back)',
              image: widget.backImage,
              isLoading: isCapturingBack,
              onCapture: widget.enabled ? () => _captureDocument(isFront: false) : null,
              onClear: widget.enabled ? () {
                setState(() {
                  widget.backImage = null;
                  validateImage();
                });
              } : null,
              isBackCard: true,
            ),
          ],
          gapHeight16,
          // Error message if missing images
          if (hasError) ...[
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColor.errorRed.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: AppColor.errorRed, size: 18.sp),
                  gapWidth8,
                  Expanded(
                    child: Text(
                      needsBackImage
                          ? 'Please capture both front and back of your ID'
                          : 'Please capture the front of your ID',
                      style: AppTextStyle.caption.copyWith(color: AppColor.errorRed),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Individual document image card with capture functionality
class _DocumentImageCard extends StatelessWidget {
  final String label;
  final Uint8List? image;
  final bool isLoading;
  final VoidCallback? onCapture;
  final VoidCallback? onClear;
  final bool isBackCard;

  const _DocumentImageCard({
    required this.label,
    required this.image,
    required this.isLoading,
    required this.onCapture,
    required this.onClear,
    this.isBackCard = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              isBackCard ? Icons.flip_to_back : Icons.flip_to_front,
              size: 16.sp,
              color: AppColor.brightBlue,
            ),
            gapWidth8,
            Text(
              label,
              style: AppTextStyle.label.copyWith(
                color: AppColor.white.withValues(alpha: 0.8),
              ),
            ),
            if (image != null) ...[
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColor.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, size: 12.sp, color: AppColor.green),
                    gapWidth4,
                    Text(
                      'Captured',
                      style: AppTextStyle.caption.copyWith(
                        color: AppColor.green,
                        fontSize: 10.spMin,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        gapHeight8,
        // Image preview or placeholder
        GestureDetector(
          onTap: onCapture,
          child: Container(
            width: double.infinity,
            height: 160.h,
            decoration: BoxDecoration(
              color: AppColor.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: image != null
                    ? AppColor.green.withValues(alpha: 0.3)
                    : AppColor.white.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: isLoading
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 24.w,
                          height: 24.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColor.brightBlue,
                          ),
                        ),
                        gapHeight8,
                        Text(
                          'Processing...',
                          style: AppTextStyle.caption.copyWith(
                            color: AppColor.white.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  )
                : image != null
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(11.r),
                            child: Image.memory(
                              image!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Overlay with actions
                          Positioned(
                            top: 8.h,
                            right: 8.w,
                            child: Row(
                              children: [
                                _ActionButton(
                                  icon: Icons.camera_alt,
                                  onTap: onCapture,
                                  tooltip: 'Retake',
                                ),
                                if (onClear != null) ...[
                                  gapWidth8,
                                  _ActionButton(
                                    icon: Icons.close,
                                    onTap: onClear,
                                    tooltip: 'Remove',
                                    isDestructive: true,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: AppColor.brightBlue.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isBackCard ? Icons.flip_to_back : Icons.add_a_photo,
                              color: AppColor.brightBlue,
                              size: 24.sp,
                            ),
                          ),
                          gapHeight12,
                          Text(
                            'Tap to capture',
                            style: AppTextStyle.bodyText.copyWith(
                              color: AppColor.white.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
          ),
        ),
      ],
    );
  }
}

/// Small action button for image overlay
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final String tooltip;
  final bool isDestructive;

  const _ActionButton({
    required this.icon,
    required this.onTap,
    required this.tooltip,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: tooltip,
        child: Container(
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: isDestructive
                ? AppColor.errorRed.withValues(alpha: 0.8)
                : AppColor.mainBlack.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16.sp,
          ),
        ),
      ),
    );
  }
}

/// Bottom sheet for selecting capture source
class _CaptureSourceBottomSheet extends StatelessWidget {
  final String title;
  final String description;

  const _CaptureSourceBottomSheet({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColor.mainBlack,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColor.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          gapHeight24,
          Text(
            title,
            style: AppTextStyle.header2.copyWith(
              color: AppColor.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          gapHeight8,
          Text(
            description,
            style: AppTextStyle.bodyText.copyWith(
              color: AppColor.white.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          gapHeight32,
          // Camera option
          _SourceOptionCard(
            icon: Icons.camera_alt_rounded,
            iconColor: AppColor.brightBlue,
            title: 'Take Photo',
            description: 'Use camera to capture',
            onTap: () => Navigator.pop(context, 'camera'),
          ),
          gapHeight16,
          // Gallery option
          _SourceOptionCard(
            icon: Icons.photo_library_rounded,
            iconColor: const Color(0xFF8B5CF6),
            title: 'Choose from Gallery',
            description: 'Select existing photo',
            onTap: () => Navigator.pop(context, 'gallery'),
          ),
          gapHeight24,
        ],
      ),
    );
  }
}

/// Source option card
class _SourceOptionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _SourceOptionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: iconColor.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: iconColor, size: 24.sp),
              ),
              gapWidth16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.header3.copyWith(
                        color: AppColor.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      description,
                      style: AppTextStyle.caption.copyWith(
                        color: AppColor.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColor.white.withValues(alpha: 0.3),
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
