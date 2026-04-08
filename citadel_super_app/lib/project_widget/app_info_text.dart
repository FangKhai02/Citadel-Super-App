import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:flutter/material.dart';

class AppInfoText extends StatelessWidget {
  final String title;
  final String value;

  const AppInfoText(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.label,
        ),
        gapHeight8,
        Text(
          value.defaultDisplay,
          style: AppTextStyle.bodyText,
        ),
      ],
    );
  }
}
