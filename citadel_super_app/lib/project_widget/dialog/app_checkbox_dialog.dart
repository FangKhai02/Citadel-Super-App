import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/button/rounded_border_button.dart';
import 'package:citadel_super_app/project_widget/selection/app_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCheckOutDialog extends HookWidget {
  final String title;
  final String? message;
  final bool isChecked;
  final String checkBoxText;
  final bool checkBoxCompulsory;
  final String? positiveText;
  final Function? positiveOnTap;
  final bool? showPositiveButton;
  final String? negativeText;
  final Function? negativeOnTap;
  final bool? showNegativeButton;
  final bool isRounded;

  const AppCheckOutDialog({
    super.key,
    required this.title,
    this.message,
    this.isChecked = false,
    required this.checkBoxText,
    this.checkBoxCompulsory = true,
    this.positiveText,
    this.positiveOnTap,
    this.showPositiveButton,
    this.negativeText,
    this.negativeOnTap,
    this.showNegativeButton,
    this.isRounded = false,
  });

  @override
  Widget build(BuildContext context) {
    final checked = useState(isChecked);

    return Dialog(
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                  style:
                      AppTextStyle.header1.copyWith(color: AppColor.mainBlack)),
              gapHeight16,
              message != null
                  ? Text(message!,
                      style: AppTextStyle.bodyText
                          .copyWith(color: AppColor.popupGray))
                  : const SizedBox(),
              gapHeight16,
              AppCheckbox(
                  label: checkBoxText,
                  textStyle:
                      AppTextStyle.bodyText.copyWith(color: AppColor.popupGray),
                  fieldKey: AppFormFieldKey.remarkKey,
                  onCheck: (value) {
                    checked.value = value;
                  },
                  isTick: checked.value),
              gapHeight32,
              Visibility(
                visible: showPositiveButton ?? true,
                child: PrimaryButton(
                    height: 48.h,
                    title: positiveText ?? 'Confirm',
                    onTap: checkBoxCompulsory && checked.value
                        ? () async {
                            await positiveOnTap?.call();
                          }
                        : null),
              ),
              gapHeight8,
              Visibility(
                visible: showNegativeButton ?? true,
                child: isRounded
                    ? RoundedBorderButton(
                        title: negativeText ?? 'Decline',
                        onTap: () {
                          negativeOnTap?.call() ?? Navigator.pop(context);
                        },
                      )
                    : AppTextButton(
                        title: negativeText ?? 'Decline',
                        textStyle: AppTextStyle.action
                            .copyWith(color: AppColor.errorRed),
                        onTap: () {
                          negativeOnTap?.call() ?? Navigator.pop(context);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
