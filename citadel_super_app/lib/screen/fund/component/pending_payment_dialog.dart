import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/vo/client_portfolio_vo.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showPendingPaymentDialog(BuildContext context,
    {required ClientPortfolioVo portfolio}) {
  showDialog(
    context: context,
    builder: (_) => PendingPaymentDialog(portfolio: portfolio),
  );
}

class PendingPaymentDialog extends StatelessWidget {
  final ClientPortfolioVo portfolio;

  const PendingPaymentDialog({super.key, required this.portfolio});
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
            Text('Your action is required!',
                style:
                    AppTextStyle.header1.copyWith(color: AppColor.mainBlack)),
            gapHeight16,
            RichText(
              text: TextSpan(
                style:
                    AppTextStyle.bodyText.copyWith(color: AppColor.mainBlack),
                text: 'Your agent has placed a trust product ',
                children: [
                  TextSpan(
                    text: portfolio.productName ?? '',
                    style: AppTextStyle.header3
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: ' for you. Proceed to pay now.',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.mainBlack),
                  ),
                ],
              ),
            ),
            gapHeight32,
            PrimaryButton(
                height: 48.h,
                title: 'Pay Now',
                onTap: () {
                  // Navigator.pop(context);
                  // Navigator.pushNamed(context, CustomRouter.portfolioDetail,
                  //     arguments:
                  //         PortfolioDetailPage(subscribedFund: subscribedFund));
                }),
          ],
        ),
      ),
    );
  }
}
