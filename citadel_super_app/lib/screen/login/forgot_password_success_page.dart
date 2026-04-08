import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/universal/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ForgotPasswordSuccessPage extends HookWidget {
  const ForgotPasswordSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResultPage(
      imagePath: Assets.images.icons.documentCopy1.path,
      title: 'We have send a link to your email!',
      description: Text(
        'Please check your email to create a new password.',
        textAlign: TextAlign.center,
        style: AppTextStyle.bodyText,
      ),
      bottomButton: PrimaryButton(
        title: 'Back to home',
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
              context, CustomRouter.login, (route) => false);
        },
      ),
    );
  }
}
