import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/universal/result_page.dart';
import 'package:flutter/material.dart';

class RegisterSuccessPage extends StatelessWidget {
  const RegisterSuccessPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ResultPage(
        imagePath: Assets.images.icons.documentSubmit.path,
        title: "You're all set!",
        description: Text(
          'Congratulations, your account has been successfully created.',
          style: AppTextStyle.bodyText,
          textAlign: TextAlign.center,
        ),
        bottomButton: PrimaryButton(
          onTap: () {
            // globalRef.invalidate(microblinkResultProvider);
            // globalRef.invalidate(signUpProvider);
            // globalRef.invalidate(clientSignUpProvider);
            Navigator.pushNamedAndRemoveUntil(
                context, CustomRouter.login, (route) => false);
          },
          title: 'Back to home',
        ));
  }
}
