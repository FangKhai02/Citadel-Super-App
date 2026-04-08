import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/existing_client_state.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/progress/signup_progress_bar.dart';
import 'package:citadel_super_app/screen/sign_up/client/client_id_details_page.dart';
import 'package:citadel_super_app/screen/sign_up/document_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DisclaimerPage extends HookConsumerWidget {
  const DisclaimerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        title: 'Disclaimer',
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
        child: PrimaryButton(
          title: 'Yes, I agree',
          onTap: () {
            Navigator.pushNamed(context, CustomRouter.document,
                arguments: DocumentPage(
                  onConfirm: () {
                    ref.invalidate(existingClientProvider);
                    Navigator.pushNamed(context, CustomRouter.clientIdDetails,
                        arguments: ClientIdDetailsPage());
                  },
                ));
          },
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar
            SignUpProgressBar(currentStep: 2),
            gapHeight4,
            // Animated Header Section with glassmorphic container
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
                    // Decorative icon
                    Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColor.brightBlue.withValues(alpha: 0.2),
                            AppColor.brightBlue.withValues(alpha: 0.05),
                          ],
                        ),
                        border: Border.all(
                          color: AppColor.brightBlue.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.description_outlined,
                          size: 40.sp,
                          color: AppColor.brightBlue,
                        ),
                      ),
                    ),
                    gapHeight24,
                    Text(
                      'Terms &\nConditions',
                      style: AppTextStyle.header1.copyWith(
                        fontSize: 28.spMin,
                        height: 1.3,
                        letterSpacing: -0.5,
                      ),
                    ),
                    gapHeight12,
                    Text(
                      'Please read and accept to continue',
                      style: AppTextStyle.bodyText.copyWith(
                        color: AppColor.brightBlue.withValues(alpha: 0.9),
                        fontSize: 14.spMin,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            gapHeight24,
            // Content Cards
            FadeSlideTransition(
              controller: contentAnimation,
              offset: const Offset(0, 0.2),
              child: Column(
                children: [
                  // Card 1 - Data Consent
                  Container(
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
                              width: 44.w,
                              height: 44.h,
                              decoration: BoxDecoration(
                                color: AppColor.brightBlue.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.storage_outlined,
                                  size: 22.sp,
                                  color: AppColor.brightBlue,
                                ),
                              ),
                            ),
                            gapWidth12,
                            Expanded(
                              child: Text(
                                'Data Consent',
                                style: AppTextStyle.header3.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        gapHeight12,
                        Text(
                          'By agreeing to use the Super App, you are hereby agreeable to consent to the migration of your personal information into the database managed by Super App.',
                          style: AppTextStyle.bodyText.copyWith(
                            color: AppColor.white.withValues(alpha: 0.7),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  gapHeight16,
                  // Card 2 - Data Management
                  Container(
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
                              width: 44.w,
                              height: 44.h,
                              decoration: BoxDecoration(
                                color: AppColor.brightBlue.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.security_outlined,
                                  size: 22.sp,
                                  color: AppColor.brightBlue,
                                ),
                              ),
                            ),
                            gapWidth12,
                            Expanded(
                              child: Text(
                                'Data Management',
                                style: AppTextStyle.header3.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        gapHeight12,
                        Text(
                          'You are also agreeable to allowing Super App to control and manage your personal information.',
                          style: AppTextStyle.bodyText.copyWith(
                            color: AppColor.white.withValues(alpha: 0.7),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  gapHeight16,
                  // Card 3 - Client Responsibility
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: AppColor.errorRed.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColor.errorRed.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 44.w,
                              height: 44.h,
                              decoration: BoxDecoration(
                                color: AppColor.errorRed.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.warning_amber_outlined,
                                  size: 22.sp,
                                  color: AppColor.errorRed,
                                ),
                              ),
                            ),
                            gapWidth12,
                            Expanded(
                              child: Text(
                                'Client Responsibility',
                                style: AppTextStyle.header3.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.errorRed,
                                ),
                              ),
                            ),
                          ],
                        ),
                        gapHeight12,
                        Text(
                          'You as the Client are solely responsible to ensuring that all personal data and information provided are true, complete and up-to-date. The Client must verify all details before proceeding with any transaction or engagement.',
                          style: AppTextStyle.bodyText.copyWith(
                            color: AppColor.white.withValues(alpha: 0.7),
                            height: 1.5,
                          ),
                        ),
                        gapHeight8,
                        Text(
                          'The Company shall not be liable for any loss, delay, or issue arising from the Client\'s failure to provide accurate or complete information.',
                          style: AppTextStyle.caption.copyWith(
                            color: AppColor.white.withValues(alpha: 0.5),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
