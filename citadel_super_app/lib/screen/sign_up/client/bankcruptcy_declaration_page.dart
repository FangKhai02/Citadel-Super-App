import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/existing_client_state.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/project_widget/progress/signup_progress_bar.dart';
import 'package:citadel_super_app/project_widget/selection/app_checkbox.dart';
import 'package:citadel_super_app/screen/sign_up/client/client_id_details_page.dart';
import 'package:citadel_super_app/screen/sign_up/document_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BankcruptcyDeclarationPage extends HookConsumerWidget {
  const BankcruptcyDeclarationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = useState(false);
    final headerAnimation = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );
    final contentAnimation = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    useEffect(() {
      headerAnimation.forward();
      Future.delayed(const Duration(milliseconds: 150), () {
        contentAnimation.forward();
      });
      return () {
        headerAnimation.dispose();
        contentAnimation.dispose();
      };
    }, []);

    return CitadelBackground(
      backgroundType: BackgroundType.pureBlack,
      appBar: const CitadelAppBar(
        title: 'Declaration',
      ),
      bottomNavigationBar: Visibility(
        visible: isChecked.value,
        maintainState: true,
        maintainAnimation: true,
        maintainSize: false,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
          child: PrimaryButton(
            title: 'Continue',
            onTap: () async {
              Navigator.pushNamed(context, CustomRouter.disclaimer);
            },
          ),
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar
            SignUpProgressBar(currentStep: 1),
            gapHeight4,
            // Animated Header Section
            FadeSlideTransition(
              controller: headerAnimation,
              offset: const Offset(0, -0.2),
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
                    // Warning Icon with animated pulse
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 1.0, end: 1.1),
                      duration: const Duration(milliseconds: 800),
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: isChecked.value ? 1.0 : scale,
                          child: child,
                        );
                      },
                      child: Container(
                        width: 72.w,
                        height: 72.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.brightBlue.withOpacity(0.15),
                          border: Border.all(
                            color: AppColor.brightBlue.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.shield_outlined,
                            size: 36.sp,
                            color: AppColor.brightBlue,
                          ),
                        ),
                      ),
                    ),
                    gapHeight24,
                    Text(
                      'Bankruptcy\nDeclaration',
                      style: AppTextStyle.header1.copyWith(
                        fontSize: 28.spMin,
                        height: 1.3,
                        letterSpacing: -0.5,
                      ),
                    ),
                    gapHeight12,
                    Text(
                      'Please confirm your status to proceed',
                      style: AppTextStyle.bodyText.copyWith(
                        color: AppColor.brightBlue.withValues(alpha: 0.9),
                        fontSize: 14.spMin,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            gapHeight32,

            // Interactive Checkbox Card - Animated
            FadeSlideTransition(
              controller: contentAnimation,
              offset: const Offset(0, 0.2),
              child: GestureDetector(
                onTap: () {
                  isChecked.value = !isChecked.value;
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: isChecked.value
                        ? AppColor.green.withOpacity(0.1)
                        : AppColor.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isChecked.value
                          ? AppColor.green.withOpacity(0.5)
                          : AppColor.white.withOpacity(0.1),
                      width: isChecked.value ? 2.0 : 1.0,
                    ),
                    boxShadow: isChecked.value
                        ? [
                            BoxShadow(
                              color: AppColor.green.withOpacity(0.15),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ]
                        : [],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Custom Animated Checkbox
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 28.w,
                        height: 28.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isChecked.value
                              ? AppColor.green
                              : Colors.transparent,
                          border: Border.all(
                            color: isChecked.value
                                ? AppColor.green
                                : AppColor.white.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: isChecked.value
                            ? Icon(
                                Icons.check,
                                size: 16.sp,
                                color: AppColor.white,
                              )
                            : null,
                      ),
                      gapWidth16,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'I declare that I am',
                              style: AppTextStyle.bodyText.copyWith(
                                color: AppColor.white.withOpacity(0.7),
                                fontSize: 15.spMin,
                              ),
                            ),
                            gapHeight4,
                            Text(
                              'NOT currently bankrupt',
                              style: AppTextStyle.header3.copyWith(
                                color: isChecked.value
                                    ? AppColor.green
                                    : AppColor.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.spMin,
                              ),
                            ),
                            gapHeight4,
                            Text(
                              'and legally eligible to sign up.',
                              style: AppTextStyle.bodyText.copyWith(
                                color: AppColor.white.withOpacity(0.7),
                                fontSize: 15.spMin,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            gapHeight24,

            // Warning Note Card - Animated
            FadeSlideTransition(
              controller: contentAnimation,
              offset: const Offset(0, 0.25),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColor.errorRed.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColor.errorRed.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.errorRed.withOpacity(0.15),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.info_outline,
                          size: 20.sp,
                          color: AppColor.errorRed,
                        ),
                      ),
                    ),
                    gapWidth12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Important Notice',
                            style: AppTextStyle.header3.copyWith(
                              color: AppColor.errorRed,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.spMin,
                            ),
                          ),
                          gapHeight4,
                          Text(
                            'If you are currently declared bankrupt, you are not eligible to sign up for this service.',
                            style: AppTextStyle.caption.copyWith(
                              color: AppColor.white.withOpacity(0.7),
                              height: 1.5,
                            ),
                          ),
                          gapHeight8,
                          Text(
                            'Please contact customer support for further assistance.',
                            style: AppTextStyle.caption.copyWith(
                              color: AppColor.white.withOpacity(0.5),
                              fontSize: 12.spMin,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            gapHeight48,
          ],
        ),
      ),
    );
  }
}

/// Helper animation widget for fade + slide transitions
class FadeSlideTransition extends StatelessWidget {
  final AnimationController controller;
  final Offset offset;
  final Widget child;

  const FadeSlideTransition({
    super.key,
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
