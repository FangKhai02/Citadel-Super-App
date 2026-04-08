import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/fund/portfolio_status.dart';
import 'package:citadel_super_app/data/vo/client_portfolio_vo.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/screen/fund/component/fund_status_indicator.dart';
import 'package:citadel_super_app/screen/fund/portfolio/corporate_portfolio_detail_page.dart';
import 'package:citadel_super_app/screen/fund/portfolio/portfolio_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PortfolioRecord extends HookWidget {
  final ClientPortfolioVo portfolio;
  final bool isCorporate;
  final String? clientId;
  final bool allowEdit;

  const PortfolioRecord(
      {super.key,
      required this.portfolio,
      this.isCorporate = false,
      this.clientId,
      this.allowEdit = true});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (isCorporate) {
            Navigator.pushNamed(context, CustomRouter.corporatePortfolioDetail,
                arguments: CorporatePortfolioDetailPage(
                    referenceNumber: portfolio.orderReferenceNumber ?? '',
                    corporateClientId: portfolio.clientId ?? '',
                    allowEdit: allowEdit));
          } else {
            Navigator.pushNamed(context, CustomRouter.portfolioDetail,
                arguments: PortfolioDetailPage(
                  clientId: clientId,
                  referenceNumber: portfolio.orderReferenceNumber ?? '',
                ));
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(portfolio.productName ?? '',
                      style: AppTextStyle.bodyText),
                  gapHeight8,
                  Text(
                    'RM${(portfolio.purchasedAmount ?? 0.0).toInt().thousandSeparator()}',
                    style: AppTextStyle.header3,
                  ),
                  gapHeight8,
                  Text(portfolio.productPurchaseDate.toDDMMMYYYhhmm,
                      style: AppTextStyle.caption),
                ],
              )),
              gapHeight16,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FundStatusIndicator(
                    status: PortfolioStatus.active
                        .getStatus(portfolio.status ?? ''),
                  ),
                  gapHeight8,
                  ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 120.w),
                      child: Text(
                        portfolio.remark ?? '',
                        style: AppTextStyle.caption,
                        textAlign: TextAlign.end,
                      )),
                ],
              ),
            ],
          ),
        ));
  }
}
