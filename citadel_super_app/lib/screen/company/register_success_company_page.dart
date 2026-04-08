import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/universal/result_page.dart';
import 'package:flutter/material.dart';

class RegisterSuccessCompanyPage extends StatelessWidget {
  const RegisterSuccessCompanyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ResultPage(
      imagePath: Assets.images.icons.documentSubmit.path,
      title: "You're all set!",
      description: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text:
              'Your company registration will be reviewed within 3 days. You may check the details in ',
          style: AppTextStyle.bodyText,
          children: [
            TextSpan(
              text: 'Menu > Corporate Trustee',
              style: AppTextStyle.header3,
            ),
          ],
        ),
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
