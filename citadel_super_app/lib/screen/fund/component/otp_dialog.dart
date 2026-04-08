import 'dart:async';
import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/data/repository/otp_repository.dart';
import 'package:citadel_super_app/data/request/otp_verification_request.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/extension/context_extension.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

Future<bool> showOTPDialog(BuildContext context) async {
  final value = await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => const OTPDialog(),
  );
  return value;
}

class OTPDialog extends StatefulHookConsumerWidget {
  const OTPDialog({super.key});

  @override
  OTPDialogState createState() => OTPDialogState();
}

class OTPDialogState extends ConsumerState<OTPDialog> {
  int countdown = 60;
  bool showResendButton = false;
  bool isVerifying = false;
  bool wrongCode = false;
  late Timer timer;

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileProvider(null));

    void startTimer() {
      setState(() {
        countdown = 60;
        showResendButton = false;
      });
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (countdown > 0) {
          setState(() {
            countdown--;
          });

          return;
        }

        timer.cancel();
        setState(() {
          showResendButton = true;
        });
      });
    }

    void wrongCodeEntered() {
      setState(() {
        isVerifying = false;
        wrongCode = true;
        countdown = 0;
        if (timer.isActive) timer.cancel();
      });
    }

    void correctCodeEntered() {
      Navigator.pop(context, true);
    }

    void verifyOTP(String otp) async {
      setState(() {
        isVerifying = true;

        Future.delayed(const Duration(seconds: 1), () async {
          OtpRepository repo = OtpRepository();
          await repo.verifyOtp(OtpVerificationRequest(otp: otp)).baseThen(
            getAppContext() ?? context,
            onResponseSuccess: (_) {
              correctCodeEntered();
            },
            onResponseError: (e, s) {
              wrongCodeEntered();
            },
          );
        });
      });
      startTimer();
    }

    void resendOtp() async {
      OtpRepository repo = OtpRepository();
      await repo.sendOtp().baseThen(context, onResponseSuccess: (_) async {
        startTimer();
      });
    }

    Widget instructionText() {
      return isVerifying
          ? Text(
              'Verifying code...',
              style: AppTextStyle.caption.copyWith(color: AppColor.mainBlack),
            )
          : RichText(
              text: TextSpan(
                style: AppTextStyle.caption.copyWith(
                    color: wrongCode ? AppColor.errorRed : AppColor.mainBlack),
                text: wrongCode
                    ? 'Invalid code. Please try again. '
                    : 'Having trouble? ',
                children: [
                  countdown == 0
                      ? TextSpan(
                          text: 'Resend code',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => resendOtp(),
                          style: AppTextStyle.label.copyWith(
                              color: AppColor.brightBlue,
                              decoration: TextDecoration.underline))
                      : TextSpan(
                          text:
                              'Request a new code in ${countdown.formatCountdown()}',
                          style: AppTextStyle.caption
                              .copyWith(color: AppColor.mainBlack),
                        ),
                ],
              ),
            );
    }

    useEffect(() {
      Future.microtask(() async {
        OtpRepository repo = OtpRepository();
        await repo.sendOtp().baseThen(getAppContext() ?? context,
            onResponseSuccess: (_) async {
          startTimer();
        });
      });
      return;
    }, []);

    return Dialog(
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            profile.when(
              data: (value) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Enter OTP',
                        style: AppTextStyle.header1
                            .copyWith(color: AppColor.mainBlack)),
                    gapHeight16,
                    RichText(
                      text: TextSpan(
                        style: AppTextStyle.bodyText
                            .copyWith(color: AppColor.mainBlack),
                        text: 'Please enter a 4-digit OTP sent to ',
                        children: [
                          TextSpan(
                            text:
                                '${value.personalDetails.mobileCountryCodeDisplay}${value.personalDetails?.mobileNumber}',
                            style: AppTextStyle.header3
                                .copyWith(color: AppColor.mainBlack),
                          ),
                          TextSpan(
                            text:
                                ' as a verification before we proceed with your request ',
                            style: AppTextStyle.bodyText
                                .copyWith(color: AppColor.mainBlack),
                          ),
                        ],
                      ),
                    ),
                    gapHeight32,
                    Row(
                      children: [
                        SizedBox(
                          width: 180.w,
                          child: PinCodeTextField(
                            appContext: context,
                            length: 4,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                                fieldOuterPadding: EdgeInsets.only(right: 16.w),
                                shape: PinCodeFieldShape.underline,
                                fieldHeight: 39.h,
                                fieldWidth: 24.w,
                                selectedColor: AppColor.brightBlue,
                                selectedFillColor: Colors.transparent,
                                activeColor: AppColor.lineGray,
                                activeFillColor: Colors.transparent,
                                inactiveColor: AppColor.lineGray,
                                inactiveFillColor: Colors.transparent),
                            textStyle: AppTextStyle.bigNumber
                                .copyWith(color: AppColor.mainBlack),
                            cursorColor: AppColor.brightBlue,
                            enableActiveFill: false,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true),
                            onChanged: (value) {
                              if (value.length == 4) {
                                verifyOTP(value);
                              }
                            },
                          ),
                        ),
                        gapWidth24,
                        if (isVerifying)
                          SizedBox(
                              width: 24.w,
                              height: 24.w,
                              child: const CircularProgressIndicator())
                      ],
                    ),
                    gapHeight16,
                    instructionText(),
                  ],
                );
              },
              error: (error, stackTrace) {
                //TODO: handle error
                context.showErrorSnackBar(error.toString());
                return const SizedBox();
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      ),
    );
  }
}
