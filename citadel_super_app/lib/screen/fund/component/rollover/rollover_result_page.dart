import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/universal/result_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RolloverResultPage extends HookWidget {
  final String selectedMethod;

  const RolloverResultPage({super.key, required this.selectedMethod});

  String useCase(String selectedMethod) {
    if (selectedMethod == 'Fully Redeem') {
      return 'redemption';
    } else if (selectedMethod == 'Rollover') {
      return 'rollover';
    } else if (selectedMethod == 'Reallocation') {
      return 'reallocation';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    String method = useCase(selectedMethod);
    String title = 'We have received your $method request';
    String description =
        'Your trust product $method request will be reviewed within 3 days. You may check the progress in ';

    return ResultPage(
      imagePath: Assets.images.icons.loan.path,
      title: title,
      description: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTextStyle.bodyText,
          text: description,
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
