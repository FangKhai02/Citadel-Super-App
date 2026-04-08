import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  void showSnackBar(String title, Color backgroundColor) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Text(
            title,
            //todo add text style
            // style: labelMedium?.copyWith(
            //   fontWeight: FontWeight.w500,
            //   color: textColor,
            // ),
          ),
          backgroundColor: backgroundColor,
        ),
      );

  void showSuccessSnackBar(String title) => showSnackBar(title, Colors.green);

  void showErrorSnackBar(String title) => showSnackBar(title, Colors.red);

  void showWarningSnackBar(String title) => showSnackBar(title, Colors.orange);
}
