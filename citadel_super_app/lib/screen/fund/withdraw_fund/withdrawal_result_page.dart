import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/universal/result_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class WithdrawalResultPage extends HookWidget {
  const WithdrawalResultPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ResultPage(
      imagePath: Assets.images.icons.fundPurchaseSuccess.path,
      title: 'We have received your redemption request',
      description: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTextStyle.bodyText,
          text:
              'Your trust product redemption request will be reviewed within 3 days. You may check the progress in ',
          children: [
            TextSpan(text: 'Home > My Portfolio.', style: AppTextStyle.header3),
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
