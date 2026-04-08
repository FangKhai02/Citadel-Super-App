import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/beneficiary_distribution_state.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/universal/result_page.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum PaymentResultType {
  onlineBankingSuccess,
  onlineBankingFail,
  manualTransferUpload
}

class PaymentResultPage extends HookConsumerWidget {
  final PaymentResultType type;
  final bool popOnly;

  const PaymentResultPage(
      {super.key, required this.type, this.popOnly = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (type) {
      case PaymentResultType.onlineBankingSuccess:
        return ResultPage(
            imagePath: Assets.images.icons.paymentSuccess.path,
            title: 'Payment Successful',
            description: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text:
                      'Your fund purchase will be reviewed within 3 days. You may check the progress in\n',
                  style: AppTextStyle.bodyText,
                  children: [
                    TextSpan(
                        text: 'Home > My Portfolio.',
                        style: AppTextStyle.action)
                  ]),
            ),
            bottomButton: PrimaryButton(
              title: 'Back to Home',
              onTap: () {
                ref.invalidate(beneficiaryDistributionProvider);
                if (popOnly) {
                  Navigator.pop(context);
                } else {
                  Navigator.pushNamedAndRemoveUntil(context,
                      CustomRouter.dashboard, (route) => route.isFirst);
                }
              },
            ));
      case PaymentResultType.onlineBankingFail:
        return ResultPage(
            imagePath: Assets.images.icons.paymentFail.path,
            title: 'Payment Failed',
            description: Text(
                'We were unable to process your payment. Please try again.',
                textAlign: TextAlign.center,
                style: AppTextStyle.bodyText),
            bottomButton: PrimaryButton(
              title: 'Retry',
              onTap: () {
                Navigator.pop(context);
              },
            ));
      case PaymentResultType.manualTransferUpload:
        return ResultPage(
            imagePath: Assets.images.icons.manualSubmitSuccess.path,
            title: 'Payment receipt has been uploaded successfully',
            description: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text:
                      'Your fund purchase will be reviewed within 3 days. You may check the progress in\n',
                  style: AppTextStyle.bodyText,
                  children: [
                    TextSpan(
                        text: 'Home > My Portfolio.',
                        style: AppTextStyle.action)
                  ]),
            ),
            bottomButton: PrimaryButton(
              title: 'Back to Home',
              onTap: () {
                ref.invalidate(beneficiaryDistributionProvider);
                Navigator.pushNamedAndRemoveUntil(
                    context, CustomRouter.dashboard, (route) => route.isFirst);
              },
            ));
    }
  }
}
