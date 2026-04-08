import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppTextButton extends HookWidget {
  final String title;
  final TextStyle? textStyle;
  final Function onTap;

  const AppTextButton({
    super.key,
    required this.title,
    this.textStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          onTap.call();
        },
        child: Center(
          child: Text(title,
              textAlign: TextAlign.center,
              style: textStyle ??
                  AppTextStyle.action.copyWith(color: AppColor.brightBlue)),
        ));
  }
}
