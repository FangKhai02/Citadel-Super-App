import 'dart:async';
import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/data/repository/agent_repository.dart';
import 'package:citadel_super_app/data/repository/client_repository.dart';
import 'package:citadel_super_app/data/state/bottom_navigation_state.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';

class PinAttemptPage extends HookConsumerWidget {
  final String? appBarTitle;
  final String? pageTitle;
  final bool? showReturn;
  final Function(String? oldPin)? onConfirm;

  const PinAttemptPage({
    super.key,
    this.appBarTitle,
    this.pageTitle,
    this.showReturn,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final remainingAttempts = useState(3);
    // final isLocked = useState(false);
    // final timer = useState<Timer?>(null);
    final isLoading = useState(false);
    final hasError = useState(false);
    final formKey = GlobalKey<AppFormState>();
    // final userType = ref.watch(bottomNavigationProvider);

    // void lockUser() {
    //   isLocked.value = true;
    //   timer.value = Timer(const Duration(minutes: 1), () {
    //     isLocked.value = false;
    //     remainingAttempts.value = 3;
    //   });
    // }

    Future<void> checkPin(String pin) async {
      // if (isLocked.value) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Too many incorrect attempts. Please wait 1 minute.'),
      //       backgroundColor: AppColor.errorRed,
      //     ),
      //   );
      //   return;
      // }

      isLoading.value = true;
      try {
        await validatePin(context, ref, pin);
        // remainingAttempts.value -= 1;

        // if (remainingAttempts.value > 0) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(
        //         'Invalid PIN. Please try again. You have ${remainingAttempts.value} attempts left.',
        //       ),
        //       backgroundColor: AppColor.errorRed,
        //     ),
        //   );
        // } else {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //       content: Text(
        //         'Too many incorrect attempts. You are locked out for 1 minute.',
        //       ),
        //       backgroundColor: AppColor.errorRed,
        //     ),
        //   );
        //   // lockUser();
        // }
      } catch (e) {
        ScaffoldMessenger.of(getAppContext() ?? context)
            .showSnackBar(const SnackBar(
          backgroundColor: AppColor.errorRed,
          content: Text('An error occurred. Please try again later.'),
        ));
      } finally {
        isLoading.value = false;
      }
    }

    // useEffect(() {
    //   // Cleanup timer on widget dispose
    //   return () {
    //     timer.value?.cancel();
    //   };
    // }, []);

    return CitadelBackground(
      backgroundType: BackgroundType.pureBlack,
      appBar: CitadelAppBar(
        title: appBarTitle ?? 'Enter PIN',
        showLeading: showReturn ?? true,
      ),
      child: AppForm(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pageTitle ?? 'Enter your Security Pin',
                    style: AppTextStyle.header1,
                  ),
                  gapHeight64,
                  Builder(builder: (pinContext) {
                    return Row(
                      children: [
                        SizedBox(
                          width: 180.w,
                          child: PinCodeTextField(
                              obscureText: true,
                              appContext: context,
                              length: 4,
                              animationType: AnimationType.fade,
                              // enabled: !isLocked.value && !isLoading.value,
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
                                inactiveFillColor: Colors.transparent,
                              ),
                              textStyle: TextStyle(
                                  fontSize: 16.sp, color: AppColor.white),
                              cursorColor: AppColor.brightBlue,
                              enableActiveFill: false,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true),
                              onChanged: (value) {
                                formKey.currentState
                                    ?.formData[AppFormFieldKey.pinKey] = value;
                                formKey.currentState?.setError(
                                    fieldKey: AppFormFieldKey.pinKey,
                                    errorMsg: null);
                                if (value.length == 4) {
                                  checkPin(value);
                                }
                              }),
                        ),
                        if (isLoading.value)
                          const Center(
                            child: CircularProgressIndicator(
                              color: AppColor.brightBlue,
                            ),
                          ),
                      ],
                    );
                  }),
                  // if (isLocked.value)
                  //   Padding(
                  //     padding: const EdgeInsets.only(bottom: 16),
                  //     child: Text(
                  //       'You are locked out. Please wait 1 minute.',
                  //       style: AppTextStyle.bodyText
                  //           .copyWith(color: AppColor.errorRed),
                  //     ),
                  //   ),
                  Visibility(
                      visible: hasError.value,
                      child: Text(
                        'Invalid pin, please try again.',
                        style: AppTextStyle.description
                            .copyWith(color: AppColor.errorRed),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> validatePin(
      BuildContext context, WidgetRef ref, String pin) async {
    final userType = ref.watch(bottomNavigationProvider);

    if (userType.isLoginAsClient) {
      final repo = ClientRepository();
      final request = ParameterHelper().changePinParam(oldPin: pin);
      await repo.validatePin(request).baseThen(context,
          onResponseSuccess: (resp) {
        if (onConfirm != null) {
          onConfirm!(pin);
        } else {
          Navigator.pop(context);
        }
      }, onResponseError: (e, s) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Invalid PIN. Please try again.',
          ),
          backgroundColor: AppColor.errorRed,
        ));
      });
    } else if (userType.isLoginAsAgent) {
      final repo = AgentRepository();
      final request = ParameterHelper().changeAgentPinParam(oldPin: pin);
      await repo.validatePin(request).baseThen(context,
          onResponseSuccess: (resp) {
        if (onConfirm != null) {
          onConfirm!(pin);
        } else {
          Navigator.pop(context);
        }
      }, onResponseError: (e, s) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Invalid PIN. Please try again.',
          ),
          backgroundColor: AppColor.errorRed,
        ));
      });
    }
  }
}
