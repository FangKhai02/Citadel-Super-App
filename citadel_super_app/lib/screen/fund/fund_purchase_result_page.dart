import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/universal/result_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FundPurchaseResultPage extends HookWidget {
  const FundPurchaseResultPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ResultPage(
      imagePath: Assets.images.icons.fundPurchaseSuccess.path,
      title: 'Fund purchase successful',
      description: Text(
        'Congratulations, the trust fund has been added to your account.',
        textAlign: TextAlign.center,
        style: AppTextStyle.bodyText,
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
