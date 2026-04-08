import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/button/rounded_border_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDialog extends HookWidget {
  final String? image;
  final String title;
  final String? message;
  final String? positiveText;
  final Function? positiveOnTap;
  final bool? showPositiveButton;
  final String? negativeText;
  final Function? negativeOnTap;
  final bool? showNegativeButton;
  final bool isRounded;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextAlign? textAlign;

  const AppDialog({
    super.key,
    this.image,
    required this.title,
    this.message,
    this.positiveText,
    this.positiveOnTap,
    this.showPositiveButton,
    this.negativeText,
    this.negativeOnTap,
    this.showNegativeButton,
    this.isRounded = false,
    this.crossAxisAlignment,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (image != null) ...[
                Image.asset(
                  image!,
                  width: 96.w,
                  height: 96.h,
                ),
                gapHeight16,
              ],
              Text(title,
                  textAlign: textAlign,
                  style:
                      AppTextStyle.header1.copyWith(color: AppColor.mainBlack)),
              gapHeight16,
              message != null
                  ? Text(message!,
                      textAlign: textAlign,
                      style: AppTextStyle.description
                          .copyWith(color: AppColor.popupGray))
                  : const SizedBox(),
              gapHeight32,
              Visibility(
                visible: showPositiveButton ?? true,
                child: PrimaryButton(
                    height: 48.h,
                    title: positiveText ?? 'Confirm',
                    onTap: () async {
                      await positiveOnTap?.call();
                    }),
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
