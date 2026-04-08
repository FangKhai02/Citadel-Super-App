import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/response/product_early_redemption_response_vo.dart';
import 'package:citadel_super_app/data/vo/client_portfolio_vo.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/button/rounded_border_button.dart';
import 'package:citadel_super_app/screen/fund/component/otp_dialog.dart';
import 'package:citadel_super_app/screen/fund/withdraw_fund/withdrawal_request_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showWithdrawFundConfirmationDialog(BuildContext context,
    {required ClientPortfolioVo portfolio,
    required ProductEarlyRedemptionResponseVo redeemInfo}) {
  showDialog(
    context: context,
    builder: (_) => WithdrawFundConfirmationDialog(
        portfolio: portfolio, redeemInfo: redeemInfo),
  );
}

class WithdrawFundConfirmationDialog extends StatelessWidget {
  final ClientPortfolioVo portfolio;
  final ProductEarlyRedemptionResponseVo redeemInfo;

  const WithdrawFundConfirmationDialog(
      {super.key, required this.portfolio, required this.redeemInfo});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Are you sure you want to withdraw this trust product?',
                style:
                    AppTextStyle.header1.copyWith(color: AppColor.mainBlack)),
            gapHeight16,
            RichText(
              text: TextSpan(
                style:
                    AppTextStyle.bodyText.copyWith(color: AppColor.mainBlack),
                text: 'There will be a ',
                children: [
                  TextSpan(
                    text: '${redeemInfo.penaltyPercentage}% penalty',
                    style: AppTextStyle.header3
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text:
                        ' incurred to this trust product for early redemption. The return will be ',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text:
                        'RM${redeemInfo.redemptionAmount?.toInt().thousandSeparator()}',
                    style: AppTextStyle.header3
                        .copyWith(color: AppColor.mainBlack),
                  ),
                ],
              ),
            ),
            gapHeight32,
            PrimaryButton(
                height: 48.h,
                title: 'No',
                onTap: () {
                  Navigator.pop(context);
                }),
            gapHeight16,
            RoundedBorderButton(
                title: 'Yes, withdraw',
                onTap: () async {
                  Navigator.pop(context);

                  final result = await showOTPDialog(context);
                  if (result) {
                    Navigator.pushNamed(getAppContext() ?? context,
                        CustomRouter.withdrawalRequest,
                        arguments: WithdrawalRequestPage(portfolio: portfolio));
                  }
                })
          ],
        ),
      ),
    );
  }
}
