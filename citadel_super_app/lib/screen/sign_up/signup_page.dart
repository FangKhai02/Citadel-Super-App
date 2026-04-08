import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/sign_up.dart';
import 'package:citadel_super_app/data/state/sign_up_state.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/project_widget/progress/signup_progress_bar.dart';
import 'package:citadel_super_app/screen/sign_up/document_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupPage extends HookConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ableToProceed = useState(false);
    final selectAgentType = useState(false);
    final selectedUserType = useState<int?>(null);
    final selectedAgentType = useState<int?>(null);
    final headerAnimation = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );
    final cardsAnimation = useAnimationController(
      duration: const Duration(milliseconds: 700),
    );
    final agentTypeAnimation = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );
    final scrollController = useRef(ScrollController());
    final agentTypeKey = useRef(GlobalKey());

    useEffect(() {
      headerAnimation.forward();
      Future.delayed(const Duration(milliseconds: 150), () {
        cardsAnimation.forward();
      });
      return () {
        headerAnimation.dispose();
        cardsAnimation.dispose();
        agentTypeAnimation.dispose();
        scrollController.value.dispose();
      };
    }, []);

    return CitadelBackground(
      backgroundType: BackgroundType.pureBlack,
      appBar: const CitadelAppBar(
        title: 'Sign Up',
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
        child: PrimaryButton(
          onTap: ableToProceed.value
              ? () async {
                  ref.read(signUpProvider.notifier).setSignUpType(
                      selectAgentType.value ? SignUpAs.agent : SignUpAs.client);

                  if (selectAgentType.value) {
                    await showDialog(
                        context: context,
                        builder: (ctx) {
                          return AppDialog(
                            title: 'Disclaimer',
                            message:
                                'By agreeing to use the Super App, you are hereby agreeable to consent to the migration of your personal information into the database managed by Super App. You are also agreeable to allowing Super App to control and manage your personal information.',
                            positiveText: 'Yes, I agree',
                            positiveOnTap: () {
                              Navigator.pushNamed(
                                  context, CustomRouter.document,
                                  arguments: DocumentPage(
                                onConfirm: () {
                                  Navigator.pushNamed(
                                    context,
                                    CustomRouter.agentIdDetails,
                                  );
                                },
                              ));
                            },
                            negativeText: 'No, I do not agree',
                            negativeOnTap: () {},
                            isRounded: true,
                          );
                        });
                  } else {
                    Navigator.pushNamed(
                        context, CustomRouter.bankruptcyDeclaration);
                  }
                }
              : null,
          title: 'Continue',
        ),
      ),
      child: SingleChildScrollView(
        controller: scrollController.value,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar
            const SignUpProgressBar(currentStep: 0),
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
                          Icons.person_add_outlined,
                          size: 40.sp,
                          color: AppColor.brightBlue,
                        ),
                      ),
                    ),
                    gapHeight24,
                    Text(
                      'Who are you\nsigning up as?',
                      style: AppTextStyle.header1.copyWith(
                        fontSize: 28.spMin,
                        height: 1.3,
                        letterSpacing: -0.5,
                      ),
                    ),
                    gapHeight12,
                    Text(
                      'Choose your account type to get started',
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
            // User Type Selection Cards - Animated
            FadeSlideTransition(
              controller: cardsAnimation,
              offset: const Offset(0, 0.2),
              child: Column(
                children: [
                  // Client Card
                  _UserTypeCard(
                    icon: Assets.images.icons.client,
                    title: "I'm a Client",
                    description: 'Access investment services and manage your portfolio',
                    isSelected: selectedUserType.value == 0,
                    onTap: () {
                      selectedUserType.value = 0;
                      selectAgentType.value = false;
                      selectedAgentType.value = null;
                      ableToProceed.value = true;
                      // Scroll to top after collapse animation fully completes
                      Future.delayed(const Duration(milliseconds: 600), () {
                        if (scrollController.value.hasClients) {
                          scrollController.value.jumpTo(0);
                        }
                      });
                    },
                  ),
                  gapHeight16,
                  // Agent Card
                  _UserTypeCard(
                    icon: Assets.images.icons.agent,
                    title: "I'm an Agent",
                    description: 'Manage clients and operate agency services',
                    isSelected: selectedUserType.value == 1,
                    onTap: () {
                      selectedUserType.value = 1;
                      selectAgentType.value = true;
                      selectedAgentType.value = null;
                      ableToProceed.value = false; // Must select agent type first
                      agentTypeAnimation.forward(from: 0);
                      // Auto scroll to show agent type options
                      Future.delayed(const Duration(milliseconds: 350), () {
                        if (agentTypeKey.value.currentContext != null) {
                          Scrollable.ensureVisible(
                            agentTypeKey.value.currentContext!,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOut,
                            alignment: 0.1,
                          );
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            gapHeight32,
            // Agent Type Selection - Animated with expansion
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Column(
                  key: agentTypeKey.value,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Enhanced section header with gradient accent
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColor.brightBlue.withValues(alpha: 0.15),
                            AppColor.brightBlue.withValues(alpha: 0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: AppColor.brightBlue.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 4.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              color: AppColor.brightBlue,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          ),
                          gapWidth12,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Select Agent Type',
                                  style: AppTextStyle.header3.copyWith(
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                gapHeight2,
                                Text(
                                  'Choose your agency classification',
                                  style: AppTextStyle.caption.copyWith(
                                    color: AppColor.white.withValues(alpha: 0.5),
                                    fontSize: 11.spMin,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    gapHeight16,
                    _AgentTypeCard(
                      icon: Assets.images.icons.cwpAgent,
                      title: 'CWP Agent',
                      description: 'Citadel Wealth Partner agent',
                      badge: 'Internal',
                      isSelected: selectedAgentType.value == 0,
                      onTap: () {
                        selectedAgentType.value = 0;
                        ableToProceed.value = true;
                      },
                    ),
                    gapHeight12,
                    _AgentTypeCard(
                      icon: Assets.images.icons.agent,
                      title: 'Other Agency',
                      description: 'Registered with external agency',
                      badge: 'External',
                      isSelected: selectedAgentType.value == 1,
                      onTap: () {
                        selectedAgentType.value = 1;
                        ableToProceed.value = true;
                      },
                    ),
                  ],
                ),
                crossFadeState: selectAgentType.value
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 400),
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

/// Card widget for user type selection (Client / Agent)
class _UserTypeCard extends StatelessWidget {
  final AssetGenImage icon;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const _UserTypeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 200),
      tween: Tween(begin: 1.0, end: isSelected ? 1.02 : 1.0),
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isSelected
                ? [
                    AppColor.brightBlue.withValues(alpha: 0.3),
                    AppColor.brightBlue.withValues(alpha: 0.1),
                  ]
                : [
                    AppColor.white.withValues(alpha: 0.05),
                    AppColor.white.withValues(alpha: 0.02),
                  ],
          ),
          border: Border.all(
            color: isSelected
                ? AppColor.brightBlue
                : AppColor.white.withValues(alpha: 0.1),
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColor.brightBlue.withValues(alpha: 0.25),
                blurRadius: 24,
                offset: const Offset(0, 8),
                spreadRadius: -2,
              ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20.r),
            splashColor: AppColor.brightBlue.withValues(alpha: 0.1),
            highlightColor: AppColor.brightBlue.withValues(alpha: 0.05),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  // Icon Container with animated background
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 64.w,
                    height: 64.h,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColor.brightBlue.withValues(alpha: 0.2)
                          : AppColor.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: isSelected
                            ? AppColor.brightBlue.withValues(alpha: 0.4)
                            : AppColor.white.withValues(alpha: 0.08),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        icon.path,
                        width: 32.w,
                        height: 32.h,
                        fit: BoxFit.contain,
                        color: isSelected
                            ? AppColor.brightBlue
                            : AppColor.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                  gapWidth16,
                  // Text Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyle.header3.copyWith(
                            color: AppColor.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.2,
                          ),
                        ),
                        gapHeight4,
                        Text(
                          description,
                          style: AppTextStyle.caption.copyWith(
                            color: AppColor.white.withValues(alpha: 0.5),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Selection Indicator with enhanced animation
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 28.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? AppColor.brightBlue
                          : Colors.transparent,
                      border: Border.all(
                        color: isSelected
                            ? AppColor.brightBlue
                            : AppColor.white.withValues(alpha: 0.25),
                        width: 2,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColor.brightBlue.withValues(alpha: 0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : [],
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            size: 16.sp,
                            color: AppColor.white,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Card widget for agent type selection (CWP Agent / Other Agency)
class _AgentTypeCard extends StatelessWidget {
  final AssetGenImage icon;
  final String title;
  final String description;
  final String badge;
  final bool isSelected;
  final VoidCallback onTap;

  const _AgentTypeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.badge,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: isSelected
            ? AppColor.brightBlue.withValues(alpha: 0.15)
            : AppColor.white.withValues(alpha: 0.03),
        border: Border.all(
          color: isSelected
              ? AppColor.brightBlue.withValues(alpha: 0.5)
              : AppColor.white.withValues(alpha: 0.08),
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Radio Selection Circle
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 22.w,
                  height: 22.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? AppColor.brightBlue
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? AppColor.brightBlue
                          : AppColor.white.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 8.w,
                            height: 8.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.white,
                            ),
                          ),
                        )
                      : null,
                ),
                gapWidth16,
                // Icon
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: AppColor.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Image.asset(
                      icon.path,
                      width: 24.w,
                      height: 24.h,
                      fit: BoxFit.contain,
                      color: AppColor.white.withValues(alpha: 0.7),
                    ),
                  ),
                ),
                gapWidth12,
                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: AppTextStyle.header3.copyWith(
                              color: AppColor.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          gapWidth8,
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColor.brightBlue.withValues(alpha: 0.2)
                                  : AppColor.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              badge,
                              style: AppTextStyle.caption.copyWith(
                                color: isSelected
                                    ? AppColor.brightBlue
                                    : AppColor.white.withValues(alpha: 0.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      gapHeight2,
                      Text(
                        description,
                        style: AppTextStyle.caption.copyWith(
                          color: AppColor.white.withValues(alpha: 0.5),
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
    );
  }
}
