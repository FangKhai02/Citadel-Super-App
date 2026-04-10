import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/sign_up.dart';
import 'package:citadel_super_app/data/repository/app_repository.dart';
import 'package:citadel_super_app/data/request/face_compare_request_vo.dart';
import 'package:citadel_super_app/data/state/agent_signup_state.dart';
import 'package:citadel_super_app/data/state/client_signup_state.dart';
import 'package:citadel_super_app/data/state/microblink_result_state.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/service/document_capture_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FaceVerificationLoadingPage extends HookConsumerWidget {
  final String selfieImage;
  final String? documentImage;
  final String? documentNumber;
  final String? fullName;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? nationality;
  final DocumentType? documentType;
  final SignUpAs signUpType;

  const FaceVerificationLoadingPage({
    super.key,
    required this.selfieImage,
    this.documentImage,
    this.documentNumber,
    this.fullName,
    this.dateOfBirth,
    this.gender,
    this.nationality,
    this.documentType,
    required this.signUpType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 1200),
    );
    final scaleAnimation = useAnimationController(
      duration: const Duration(milliseconds: 800),
    );
    final resultAnimation = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );

    final isVerifiedNotifier = useState<bool?>(null);
    final isLoadingNotifier = useState<bool>(true);
    final errorMessageNotifier = useState<String?>(null);

    useEffect(() {
      animationController.repeat();
      scaleAnimation.forward();

      // Perform face verification
      _performVerification(
        context,
        isVerifiedNotifier,
        isLoadingNotifier,
        errorMessageNotifier,
      ).then((_) {
        resultAnimation.forward();
      });

      return () {
        animationController.dispose();
        scaleAnimation.dispose();
        resultAnimation.dispose();
      };
    }, []);

    return CitadelBackground(
      backgroundType: BackgroundType.pureBlack,
      appBar: const _LoadingAppBar(),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated verification icon
              _VerificationAnimation(
                animationController: animationController,
                scaleAnimation: scaleAnimation,
                resultAnimation: resultAnimation,
                isVerified: isVerifiedNotifier.value,
              ),
              gapHeight48,
              // Status text
              _StatusText(
                isVerified: isVerifiedNotifier.value,
                isLoading: isLoadingNotifier.value,
                errorMessage: errorMessageNotifier.value,
              ),
              gapHeight48,
              // Action button (shown after result)
              if (isVerifiedNotifier.value != null)
                _ResultActionButton(
                  isVerified: isVerifiedNotifier.value!,
                  resultAnimation: resultAnimation,
                  onContinue: () => _navigateToNext(context, ref),
                  onRetry: () => Navigator.pop(context),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _performVerification(
    BuildContext context,
    ValueNotifier<bool?> isVerifiedNotifier,
    ValueNotifier<bool> isLoadingNotifier,
    ValueNotifier<String?> errorMessageNotifier,
  ) async {
    // Build face compare request
    final faceCompareRequest = FaceCompareRequestVo(
      documentImage: documentImage,
      selfieImage: selfieImage,
      documentType: documentType?.value ??
          (documentNumber?.length == 12 ? 'MYKAD' : 'PASSPORT'),
      fullName: fullName ?? '',
      documentNumber: documentNumber ?? '',
      dateOfBirth: dateOfBirth != null
          ? '${dateOfBirth!.year}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}'
          : null,
      gender: gender?.toUpperCase() ?? 'MALE',
      nationality: nationality ?? 'Malaysian',
    );

    final appRepository = AppRepository();

    await appRepository.faceCompare(faceCompareRequest).baseThen(
      context,
      onResponseSuccess: (response) async {
        isLoadingNotifier.value = false;
        isVerifiedNotifier.value = response.verified ?? false;
      },
      onResponseError: (e, s) {
        isLoadingNotifier.value = false;
        isVerifiedNotifier.value = false;
        errorMessageNotifier.value = e.message;
      },
    );
  }

  void _navigateToNext(BuildContext context, WidgetRef ref) {
    // Update state with selfie
    ref.read(kycDocumentNotifierProvider.notifier).setSelfieImage(selfieImage);

    if (signUpType == SignUpAs.client) {
      ref.read(clientSignUpProvider.notifier).setSelfieImage(selfieImage);
      Navigator.pushReplacementNamed(context, CustomRouter.pepDeclaration);
    } else {
      ref.read(agentSignUpProvider.notifier).setSelfieImage(selfieImage);
      Navigator.pushReplacementNamed(context, CustomRouter.agencyDetails);
    }
  }
}

/// App bar for loading page with no back button during verification
class _LoadingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _LoadingAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        'Identity Verification',
        style: AppTextStyle.header2.copyWith(
          color: AppColor.white,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

/// Animated verification icon with states
class _VerificationAnimation extends StatelessWidget {
  final AnimationController animationController;
  final AnimationController scaleAnimation;
  final AnimationController resultAnimation;
  final bool? isVerified;

  const _VerificationAnimation({
    required this.animationController,
    required this.scaleAnimation,
    required this.resultAnimation,
    this.isVerified,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([animationController, scaleAnimation, resultAnimation]),
      builder: (context, child) {
        final scale = scaleAnimation.value;
        final result = resultAnimation.value;

        return Transform.scale(
          scale: 0.8 + (scale * 0.2),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Pulsing ring (shown during loading)
              if (isVerified == null)
                Transform.scale(
                  scale: 0.5 + (animationController.value * 0.3),
                  child: Container(
                    width: 160.w,
                    height: 160.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColor.brightBlue.withValues(
                          alpha: 1 - animationController.value,
                        ),
                        width: 4,
                      ),
                    ),
                  ),
                ),
              // Main circle
              Container(
                width: 120.w,
                height: 120.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _getBackgroundColor().withValues(alpha: 0.2),
                  border: Border.all(
                    color: _getBackgroundColor(),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _getBackgroundColor().withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: _buildIcon(),
                ),
              ),
              // Success checkmark animation
              if (isVerified == true)
                Opacity(
                  opacity: result,
                  child: Transform.scale(
                    scale: result,
                    child: Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.correctGreen,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                ),
              // Error X animation
              if (isVerified == false)
                Opacity(
                  opacity: result,
                  child: Transform.scale(
                    scale: result,
                    child: Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.errorRed,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Color _getBackgroundColor() {
    if (isVerified == null) return AppColor.brightBlue;
    if (isVerified == true) return AppColor.correctGreen;
    return AppColor.errorRed;
  }

  Widget _buildIcon() {
    if (isVerified == null) {
      return SizedBox(
        width: 50.w,
        height: 50.h,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColor.brightBlue,
          ),
        ),
      );
    }
    if (isVerified == true) {
      return Icon(
        Icons.verified_user_outlined,
        size: 56.sp,
        color: AppColor.correctGreen,
      );
    }
    return Icon(
      Icons.gpp_bad_outlined,
      size: 56.sp,
      color: AppColor.errorRed,
    );
  }
}

/// Status text showing loading, success, or error message
class _StatusText extends StatelessWidget {
  final bool? isVerified;
  final bool isLoading;
  final String? errorMessage;

  const _StatusText({
    this.isVerified,
    required this.isLoading,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    String title;
    String subtitle;
    Color textColor;

    if (isVerified == null) {
      title = 'Verifying your identity...';
      subtitle = 'Please wait while we compare your selfie with your ID document';
      textColor = AppColor.white;
    } else if (isVerified == true) {
      title = 'Verification Successful';
      subtitle = 'Your face matches your identity document';
      textColor = AppColor.correctGreen;
    } else {
      title = 'Verification Failed';
      subtitle = errorMessage ?? 'Your face does not match the document ID. Please try again.';
      textColor = AppColor.errorRed;
    }

    return Column(
      children: [
        Text(
          title,
          style: AppTextStyle.header1.copyWith(
            color: textColor,
            fontSize: 24.spMin,
          ),
          textAlign: TextAlign.center,
        ),
        gapHeight12,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text(
            subtitle,
            style: AppTextStyle.bodyText.copyWith(
              color: AppColor.white.withValues(alpha: 0.7),
              fontSize: 14.spMin,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

/// Result action button - Continue for success, Try Again for failure
class _ResultActionButton extends StatelessWidget {
  final bool isVerified;
  final AnimationController resultAnimation;
  final VoidCallback onContinue;
  final VoidCallback onRetry;

  const _ResultActionButton({
    required this.isVerified,
    required this.resultAnimation,
    required this.onContinue,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: resultAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: resultAnimation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - resultAnimation.value)),
            child: child,
          ),
        );
      },
      child: Column(
        children: [
          if (isVerified) ...[
            PrimaryButton(
              onTap: onContinue,
              title: 'Continue',
              width: double.infinity,
            ),
          ] else ...[
            PrimaryButton(
              onTap: onRetry,
              title: 'Try Again',
              width: double.infinity,
            ),
            gapHeight16,
            TextButton(
              onPressed: onRetry,
              child: Text(
                'Return to Previous Page',
                style: AppTextStyle.bodyText.copyWith(
                  color: AppColor.white.withValues(alpha: 0.6),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}