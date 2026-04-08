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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PortfolioContainer extends HookConsumerWidget {
  final ClientPortfolioVo portfolio;
  final bool isCorporate;
  final String? clientId;
  final bool allowEdit;

  const PortfolioContainer(
      {super.key,
      required this.portfolio,
      this.isCorporate = false,
      this.allowEdit = true,
      this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (isCorporate) {
          Navigator.pushNamed(context, CustomRouter.corporatePortfolioDetail,
              arguments: CorporatePortfolioDetailPage(
                referenceNumber: portfolio.orderReferenceNumber ?? '',
                corporateClientId: portfolio.clientId ?? '',
                allowEdit: allowEdit,
              ));
        } else {
          Navigator.pushNamed(context, CustomRouter.portfolioDetail,
              arguments: PortfolioDetailPage(
                clientId: clientId,
                referenceNumber: portfolio.orderReferenceNumber ?? '',
              ));
        }
      },
      child: Container(
        width: 216.w,
        padding: EdgeInsets.all(16.r),
        margin: EdgeInsets.only(right: 16.r),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              portfolio.productName ?? '',
              style: AppTextStyle.header3,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            gapHeight16,
            Text(
              'RM ${(portfolio.purchasedAmount ?? 0.0).toInt().thousandSeparator()}',
              style: AppTextStyle.number,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            gapHeight16,
            FundStatusIndicator(
                status:
                    PortfolioStatus.active.getStatus(portfolio.status ?? '')),
          ],
        ),
      ),
    );
  }
}
