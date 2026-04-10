import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/sign_up.dart';
import 'package:citadel_super_app/data/state/agent_signup_state.dart';
import 'package:citadel_super_app/data/state/client_signup_state.dart';
import 'package:citadel_super_app/data/state/microblink_result_state.dart';
import 'package:citadel_super_app/data/state/sign_up_state.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/project_widget/progress/signup_progress_bar.dart';
import 'package:citadel_super_app/screen/sign_up/face_verification_loading_page.dart';
import 'package:citadel_super_app/service/document_capture_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelfiePage extends HookConsumerWidget {
  const SelfiePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentCaptureService = DocumentCaptureService();

    // Animation controllers for enhanced UX
    final headerAnimation = useAnimationController(
      duration: const Duration(milliseconds: 700),
    );
    final stepsAnimation = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );
    final previewAnimation = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    useEffect(() {
      headerAnimation.forward();
      Future.delayed(const Duration(milliseconds: 200), () {
        stepsAnimation.forward();
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        previewAnimation.forward();
      });
      return () {
        headerAnimation.dispose();
        stepsAnimation.dispose();
        previewAnimation.dispose();
      };
    }, []);

    return CitadelBackground(
        backgroundType: BackgroundType.pureBlack,
        appBar: const CitadelAppBar(
          title: 'Identity Verification',
        ),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
          child: PrimaryButton(
            onTap: () async {
              // Show enhanced options bottom sheet
              final source = await showModalBottomSheet<String>(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (ctx) => const _SelfieSourceBottomSheet(),
              );

              if (source == null) return;

              // Capture selfie
              String? selfieImageBase64;
              if (source == 'camera') {
                selfieImageBase64 =
                    await documentCaptureService.captureSelfie();
              } else {
                selfieImageBase64 =
                    await documentCaptureService.pickSelfieFromGallery();
              }

              if (selfieImageBase64 == null) return;

              // Non-null selfie for use in callbacks
              final selfieImage = selfieImageBase64;

              // Get document details from state
              final kycState = ref.read(kycDocumentNotifierProvider);
              final signUpType = ref.read(signUpProvider).getSignUpType;

              // Get document image from legacy state or new state
              String? documentImage;
              String? documentNumber;
              String? fullName;
              DateTime? dateOfBirth;
              String? gender;
              String? nationality;
              DocumentType? documentType;

              if (signUpType == SignUpAs.client) {
                final clientState = ref.read(clientSignUpProvider);
                documentImage =
                    clientState.clientIdentityDetailsRequestVo?.identityCardFrontImage;
                documentNumber =
                    clientState.clientIdentityDetailsRequestVo?.identityCardNumber;
                fullName = clientState.clientIdentityDetailsRequestVo?.fullName;
                dateOfBirth = clientState.clientIdentityDetailsRequestVo?.dob != null
                    ? DateTime.fromMillisecondsSinceEpoch(
                        clientState.clientIdentityDetailsRequestVo!.dob!)
                    : null;
                gender = clientState.clientIdentityDetailsRequestVo?.gender;
                nationality =
                    clientState.clientIdentityDetailsRequestVo?.nationality;
              } else {
                final agentState = ref.read(agentSignUpProvider);
                documentImage =
                    agentState.signUpBaseIdentityDetailsVo?.identityCardFrontImage;
                documentNumber =
                    agentState.signUpBaseIdentityDetailsVo?.identityCardNumber;
                fullName = agentState.signUpBaseIdentityDetailsVo?.fullName;
                dateOfBirth = agentState.signUpBaseIdentityDetailsVo?.dob != null
                    ? DateTime.fromMillisecondsSinceEpoch(
                        agentState.signUpBaseIdentityDetailsVo!.dob!)
                    : null;
              }

              // Use new state if available
              if (kycState.documentImage != null) {
                documentImage = kycState.documentImage;
              }
              if (kycState.documentType != null) {
                documentType = kycState.documentType;
              }
              if (kycState.fullName != null) fullName = kycState.fullName;
              if (kycState.documentNumber != null) {
                documentNumber = kycState.documentNumber;
              }
              if (kycState.dateOfBirth != null) {
                dateOfBirth = kycState.dateOfBirth;
              }
              if (kycState.gender != null) gender = kycState.gender;
              if (kycState.nationality != null) {
                nationality = kycState.nationality;
              }

              if (documentImage == null) {
                showDialog(
                  context: context,
                  builder: (ctx) => AppDialog(
                    title: 'Error',
                    message: 'Document image is null. Please capture your ID first.',
                    isRounded: true,
                    positiveOnTap: () => Navigator.pop(context),
                    showNegativeButton: false,
                  ),
                );
                return;
              }

              // Navigate to face verification loading page
              Navigator.pushNamed(
                context,
                CustomRouter.faceVerificationLoading,
                arguments: FaceVerificationLoadingPage(
                  selfieImage: selfieImage,
                  documentImage: documentImage,
                  documentNumber: documentNumber,
                  fullName: fullName,
                  dateOfBirth: dateOfBirth,
                  gender: gender,
                  nationality: nationality,
                  documentType: documentType,
                  signUpType: signUpType,
                ),
              );
            },
            title: 'Start Verification',
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar
              SignUpProgressBar(currentStep: 3),
              gapHeight4,
              // Enhanced Header Section
              _AnimatedFadeSlide(
                controller: headerAnimation,
                offset: const Offset(0, -0.15),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColor.brightBlue.withValues(alpha: 0.15),
                        AppColor.brightBlue.withValues(alpha: 0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppColor.brightBlue.withValues(alpha: 0.25),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.brightBlue.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Decorative icon with glow effect
                      Container(
                        width: 72.w,
                        height: 72.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColor.brightBlue.withValues(alpha: 0.3),
                              AppColor.brightBlue.withValues(alpha: 0.1),
                            ],
                          ),
                          border: Border.all(
                            color: AppColor.brightBlue.withValues(alpha: 0.4),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.brightBlue.withValues(alpha: 0.2),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.face_retouching_natural,
                            size: 36.sp,
                            color: AppColor.brightBlue,
                          ),
                        ),
                      ),
                      gapHeight24,
                      Text(
                        'Take a Selfie',
                        style: AppTextStyle.header1.copyWith(
                          fontSize: 28.spMin,
                          height: 1.3,
                          letterSpacing: -0.5,
                        ),
                      ),
                      gapHeight12,
                      Text(
                        'To continue with your registration, we need to verify your identity through a quick face scan.',
                        style: AppTextStyle.bodyText.copyWith(
                          color: AppColor.brightBlue.withValues(alpha: 0.9),
                          fontSize: 14.spMin,
                          height: 1.5,
                        ),
                      ),
                      gapHeight16,
                    ],
                  ),
                ),
              ),
              gapHeight24,
              // Enhanced Steps Section
              _AnimatedFadeSlide(
                controller: stepsAnimation,
                offset: const Offset(0, 0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How it works',
                      style: AppTextStyle.header3.copyWith(
                        color: AppColor.white.withValues(alpha: 0.9),
                      ),
                    ),
                    gapHeight16,
                    _StepCard(
                      number: '1',
                      icon: Assets.images.icons.issuedId.path,
                      title: 'Well-Lit Area',
                      description: "Ensure you're in a well-lit area",
                      color: AppColor.brightBlue,
                      controller: stepsAnimation,
                      delay: 0,
                    ),
                    gapHeight12,
                    _StepCard(
                      number: '2',
                      icon: Assets.images.icons.clear.path,
                      title: 'Position Face',
                      description: 'Position your face within the frame',
                      color: AppColor.mint,
                      controller: stepsAnimation,
                      delay: 1,
                    ),
                    gapHeight12,
                    _StepCard(
                      number: '3',
                      icon: Assets.images.icons.faceScan.path,
                      title: 'Follow Prompts',
                      description: 'Follow on-screen prompts for smooth verification',
                      color: AppColor.correctGreen,
                      controller: stepsAnimation,
                      delay: 2,
                    ),
                  ],
                ),
              ),
              gapHeight32,
              // Enhanced Preview Card
              _AnimatedFadeSlide(
                controller: previewAnimation,
                offset: const Offset(0, 0.15),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: AppColor.white.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: AppColor.white.withValues(alpha: 0.08),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: AppColor.correctGreen.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.privacy_tip_outlined,
                                size: 20.sp,
                                color: AppColor.correctGreen,
                              ),
                            ),
                          ),
                          gapWidth12,
                          Text(
                            'Your privacy matters',
                            style: AppTextStyle.header3.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      gapHeight16,
                      _TipItem(text: 'Selfie is processed securely and never stored'),
                      gapHeight8,
                      _TipItem(text: 'Face matching uses encrypted comparison'),
                      gapHeight8,
                      _TipItem(text: 'Your data is protected at all times'),
                    ],
                  ),
                ),
              ),
              gapHeight48,
            ],
          ),
        ));
  }
}

class _InfoBadge extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoBadge({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColor.brightBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColor.brightBlue.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: AppColor.brightBlue),
          gapWidth8,
          Text(
            text,
            style: AppTextStyle.caption.copyWith(
              color: AppColor.brightBlue.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final String number;
  final String icon;
  final String title;
  final String description;
  final Color color;
  final AnimationController controller;
  final int delay;

  const _StepCard({
    required this.number,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.controller,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    final animation = CurvedAnimation(
      parent: controller,
      curve: Interval(
        delay * 0.3,
        0.6 + delay * 0.2,
        curve: Curves.easeOutCubic,
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - animation.value)),
            child: child,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColor.white.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: AppColor.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Step number indicator
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withValues(alpha: 0.25),
                    color.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  number,
                  style: AppTextStyle.header2.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            gapWidth16,
            Image.asset(icon, width: 24.w),
            gapWidth16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.header3.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  gapHeight4,
                  Text(
                    description,
                    style: AppTextStyle.bodyText.copyWith(
                      color: AppColor.white.withValues(alpha: 0.6),
                      fontSize: 13.spMin,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.check_circle_outline,
              size: 20.sp,
              color: color.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  final String text;

  const _TipItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6.w,
          height: 6.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.correctGreen.withValues(alpha: 0.7),
          ),
        ),
        gapWidth12,
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.bodyText.copyWith(
              color: AppColor.white.withValues(alpha: 0.6),
              fontSize: 14.spMin,
            ),
          ),
        ),
      ],
    );
  }
}

/// Helper animation widget for fade + slide transitions
class _AnimatedFadeSlide extends StatelessWidget {
  final AnimationController controller;
  final Offset offset;
  final Widget child;

  const _AnimatedFadeSlide({
    required this.controller,
    required this.offset,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final fade = CurvedAnimation(
          parent: controller,
          curve: Curves.easeOut,
        ).value;
        final slide = CurvedAnimation(
          parent: controller,
          curve: Curves.easeOutCubic,
        ).value;
        return Opacity(
          opacity: fade.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(
              offset.dx * (1 - slide) * 100,
              offset.dy * (1 - slide) * 100,
            ),
            child: child,
          ),
        );
      },
    );
  }
}

/// Enhanced selfie source selection bottom sheet with modern UI
class _SelfieSourceBottomSheet extends StatelessWidget {
  const _SelfieSourceBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1628),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withValues(alpha: 0.2),
            blurRadius: 32,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          gapHeight24,
          // Title
          Text(
            'Select Selfie Source',
            style: AppTextStyle.header2.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          gapHeight8,
          Text(
            'Choose how you want to take your selfie',
            style: AppTextStyle.bodyText.copyWith(
              color: Colors.white.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          gapHeight32,
          // Camera option - Primary
          _SelfieSourceOptionCard(
            icon: Icons.camera_alt_rounded,
            iconColor: const Color(0xFF2563EB),
            title: 'Take Photo',
            description: 'Use front camera to capture your selfie',
            isPrimary: true,
            onTap: () => Navigator.pop(context, 'camera'),
          ),
          gapHeight16,
          // Gallery option - Secondary
          _SelfieSourceOptionCard(
            icon: Icons.photo_library_rounded,
            iconColor: const Color(0xFF8B5CF6),
            title: 'Choose from Gallery',
            description: 'Select an existing selfie photo',
            isPrimary: false,
            onTap: () => Navigator.pop(context, 'gallery'),
          ),
          gapHeight24,
          // Info note
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFF2563EB).withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: const Color(0xFF2563EB).withValues(alpha: 0.8),
                  size: 20.sp,
                ),
                gapWidth12,
                Expanded(
                  child: Text(
                    'For best results, ensure good lighting and your face is clearly visible.',
                    style: AppTextStyle.caption.copyWith(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
          gapHeight16,
        ],
      ),
    );
  }
}

/// Individual selfie source option card with modern styling
class _SelfieSourceOptionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final bool isPrimary;
  final VoidCallback onTap;

  const _SelfieSourceOptionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.isPrimary,
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
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: isPrimary
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      iconColor.withValues(alpha: 0.2),
                      iconColor.withValues(alpha: 0.1),
                    ],
                  )
                : null,
            color: isPrimary
                ? null
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isPrimary
                  ? iconColor.withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.1),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              // Icon container
              Container(
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 28.sp,
                ),
              ),
              gapWidth16,
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.header3.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    gapHeight4,
                    Text(
                      description,
                      style: AppTextStyle.bodyText.copyWith(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 13.spMin,
                      ),
                    ),
                  ],
                ),
              ),
              // Arrow indicator
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white.withValues(alpha: 0.3),
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
