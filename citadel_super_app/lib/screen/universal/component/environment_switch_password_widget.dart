import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

Future<bool> showPasswordDialog(BuildContext context) async {
  final value = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const EnvironmentSwitchPasswordWidget(),
  );
  return value;
}

class EnvironmentSwitchPasswordWidget extends StatefulHookConsumerWidget {
  const EnvironmentSwitchPasswordWidget({super.key});

  @override
  OTPDialogState createState() => OTPDialogState();
}

class OTPDialogState extends ConsumerState<EnvironmentSwitchPasswordWidget> {
  @override
  Widget build(BuildContext context) {
    final wrongPassword = useState(false);
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                          'Please enter 4-digit password for environment switch',
                          style: AppTextStyle.bodyText
                              .copyWith(color: AppColor.mainBlack)),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Icon(Icons.close,
                            color: AppColor.mainBlack, size: 24.sp)),
                  ],
                ),
                gapHeight32,
                Row(
                  children: [
                    SizedBox(
                      width: 180.w,
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        autoFocus: true,
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
                        keyboardType:
                            const TextInputType.numberWithOptions(signed: true),
                        onChanged: (value) {
                          if (value.length == 4) {
                            if (value == '3124') {
                              Navigator.of(context).pop(true);
                            } else {
                              wrongPassword.value = true;
                            }
                          } else if (value.isEmpty) {
                            wrongPassword.value = false;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: wrongPassword.value,
                  child: Text('Wrong password.',
                      style: AppTextStyle.bodyText
                          .copyWith(color: AppColor.errorRed)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
