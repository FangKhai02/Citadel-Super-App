import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedBorderButton extends HookWidget {
  final String title;
  final TextStyle? textStyle;
  final Function onTap;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final EdgeInsets? padding;
  final Image? image;

  const RoundedBorderButton({
    super.key,
    required this.title,
    this.textStyle,
    required this.onTap,
    this.backgroundColor = Colors.white,
    this.borderColor = AppColor.mainBlack,
    this.textColor = AppColor.mainBlack,
    this.padding,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onTap.call();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: AppColor.disabledBlack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: BorderSide(color: borderColor),
          ),
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 20.r, vertical: 18.r),
          minimumSize: const Size(0, 0),
          // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Center(
          child: image != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    image!,
                    gapWidth8,
                    Text(title,
                        textAlign: TextAlign.center,
                        style: textStyle ??
                            AppTextStyle.action.copyWith(color: textColor)),
                  ],
                )
              : Text(title,
                  textAlign: TextAlign.center,
                  style: textStyle ??
                      AppTextStyle.action.copyWith(color: textColor)),
        ));
  }
}
