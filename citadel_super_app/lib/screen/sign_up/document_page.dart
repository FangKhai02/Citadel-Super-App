import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/state/microblink_result_state.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/progress/signup_progress_bar.dart';
import 'package:citadel_super_app/service/document_capture_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DocumentPage extends HookConsumerWidget {
  final String? title;
  final String? desc;
  final Function() onConfirm;

  const DocumentPage(
      {super.key, this.title, this.desc, required this.onConfirm});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentCaptureService = DocumentCaptureService();

    // Animation controllers
    final headerAnimation = useAnimationController(
      duration: const Duration(milliseconds: 700),
    );
    final stepsAnimation = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );
    final cardAnimation = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    useEffect(() {
      headerAnimation.forward();
      Future.delayed(const Duration(milliseconds: 200), () {
        stepsAnimation.forward();
      });
      Future.delayed(const Duration(milliseconds: 400), () {
        cardAnimation.forward();
      });
      return () {
        headerAnimation.dispose();
        stepsAnimation.dispose();
        cardAnimation.dispose();
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
              onConfirm();
            },
            title: 'Continue',
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
                            Icons.badge_outlined,
                            size: 36.sp,
                            color: AppColor.brightBlue,
                          ),
                        ),
                      ),
                      gapHeight24,
                      Text(
                        title ?? 'Scan your ID',
                        style: AppTextStyle.header1.copyWith(
                          fontSize: 28.spMin,
                          height: 1.3,
                          letterSpacing: -0.5,
                        ),
                      ),
                      gapHeight12,
                      Text(
                        desc ??
                            'To verify your identity, we need to scan your identification document.',
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
                      title: 'Prepare Document',
                      description:
                          'Government-issued ID (MyKad, Passport, Army ID, iKad or MyPR)',
                      color: AppColor.brightBlue,
                      controller: stepsAnimation,
                      delay: 0,
                    ),
                    gapHeight12,
                    _StepCard(
                      number: '2',
                      icon: Assets.images.icons.clear.path,
                      title: 'Check Quality',
                      description: 'Ensure document is clear and not damaged',
                      color: AppColor.mint,
                      controller: stepsAnimation,
                      delay: 1,
                    ),
                    gapHeight12,
                    _StepCard(
                      number: '3',
                      icon: Assets.images.icons.faceScan.path,
                      title: 'Position & Capture',
                      description: 'Place ID within frame, all details visible',
                      color: AppColor.correctGreen,
                      controller: stepsAnimation,
                      delay: 2,
                    ),
                  ],
                ),
              ),
              gapHeight32,
              // Enhanced Tips Card
              _AnimatedFadeSlide(
                controller: cardAnimation,
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
                              color: AppColor.actionYellow.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.lightbulb_outline,
                                size: 20.sp,
                                color: AppColor.actionYellow,
                              ),
                            ),
                          ),
                          gapWidth12,
                          Text(
                            'Tips for best results',
                            style: AppTextStyle.header3.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      gapHeight16,
                      _TipItem(text: 'Use good lighting - avoid shadows'),
                      gapHeight8,
                      _TipItem(text: 'Keep the document flat'),
                      gapHeight8,
                      _TipItem(text: 'Ensure all corners are visible'),
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
            // Icon
            Image.asset(icon, width: 24.w),
            gapWidth16,
            // Text content
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
            // Arrow indicator
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

/// Document source selection bottom sheet
class _DocumentSourceBottomSheet extends StatelessWidget {
  const _DocumentSourceBottomSheet();

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
          Text(
            'Select Document Source',
            style: AppTextStyle.header2.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          gapHeight8,
          Text(
            'Choose how you want to capture your ID',
            style: AppTextStyle.bodyText.copyWith(
              color: Colors.white.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          gapHeight32,
          // Camera option
          _SourceOptionCard(
            icon: Icons.camera_alt_rounded,
            iconColor: const Color(0xFF2563EB),
            title: 'Take Photo',
            description: 'Use camera to capture your ID',
            onTap: () => Navigator.pop(context, 'camera'),
          ),
          gapHeight16,
          // Gallery option
          _SourceOptionCard(
            icon: Icons.photo_library_rounded,
            iconColor: const Color(0xFF8B5CF6),
            title: 'Choose from Gallery',
            description: 'Select existing photo of your ID',
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
          padding: EdgeInsets.all(20.w),
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
                width: 56.w,
                height: 56.h,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(icon, color: iconColor, size: 28.sp),
              ),
              gapWidth16,
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
                      ),
                    ),
                  ],
                ),
              ),
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
