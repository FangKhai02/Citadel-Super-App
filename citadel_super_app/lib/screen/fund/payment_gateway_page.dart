import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/fund/payment_result_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentGatewayPage extends HookWidget {
  const PaymentGatewayPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Bank selection might be handle by backend depends on the service provider used',
                style: AppTextStyle.header3.copyWith(color: AppColor.mainBlack),
              ),
              gapHeight32,
              Text(
                'FPX Payment',
                style:
                    AppTextStyle.bigNumber.copyWith(color: AppColor.mainBlack),
              ),
              gapHeight32,
              PrimaryButton(
                title: 'Success result',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, CustomRouter.paymentResult,
                      arguments: const PaymentResultPage(
                          type: PaymentResultType.onlineBankingSuccess));
                },
              ),
              gapHeight24,
              PrimaryButton(
                title: 'Failed result',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, CustomRouter.paymentResult,
                      arguments: const PaymentResultPage(
                          type: PaymentResultType.onlineBankingFail));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
