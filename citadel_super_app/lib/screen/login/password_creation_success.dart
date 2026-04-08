import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/universal/result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PasswordCreationSuccessPage extends HookWidget {
  const PasswordCreationSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResultPage(
      imagePath: Assets.images.icons.passwordSuccess.path,
      title: 'Your new password has been saved',
      description: Text.rich(
        TextSpan(children: [
          TextSpan(
            text: 'You can change your password in ',
            style: AppTextStyle.bodyText,
          ),
          TextSpan(
              text: 'Others > Change Password', style: AppTextStyle.header3)
        ]),
      ),
      bottomButton: PrimaryButton(
        title: 'Back to home',
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
              context, CustomRouter.dashboard, (route) => false);
        },
      ),
    );
  }
}
