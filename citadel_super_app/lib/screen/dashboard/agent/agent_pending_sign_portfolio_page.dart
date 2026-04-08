import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/fund/portfolio_status.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/screen/dashboard/agent/agent_pending_sign_portfolio_detail_page.dart';
import 'package:citadel_super_app/screen/fund/component/fund_status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentPendingSignPortfolioPage extends HookConsumerWidget {
  const AgentPendingSignPortfolioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentPendingAgreement =
        ref.watch(agentPendingAgreementPortfoliosFutureProvider);

    return agentPendingAgreement.maybeWhen(data: (data) {
      var productOrders = data.productOrders ?? [];
      var earlyRedemption = data.earlyRedemptions ?? [];

      return CitadelBackground(
          backgroundType: BackgroundType.blueToOrange2,
          child: Column(
            children: [
              const CitadelAppBar(
                title: 'Client Purchase',
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: AppInfoContainer(
                    height: 0.8.sh,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.separated(
                              itemCount: productOrders.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: AppColor.white.withOpacity(0.2),
                                );
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          CustomRouter
                                              .pendingSignPortfolioDetail,
                                          arguments:
                                              AgentPendingSignPortfolioDetailPage(
                                            referenceNumber:
                                                productOrders[index]
                                                        .orderReferenceNumber ??
                                                    '',
                                            clientId:
                                                productOrders[index].clientId ??
                                                    '',
                                          ));
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  productOrders[index]
                                                          .clientName ??
                                                      '',
                                                  style: AppTextStyle.header3),
                                              gapHeight8,
                                              Text(
                                                  productOrders[index]
                                                          .productName ??
                                                      '',
                                                  style: AppTextStyle.bodyText),
                                              gapHeight8,
                                              Text(
                                                'RM${(productOrders[index].purchasedAmount ?? 0.0).toInt().thousandSeparator()}',
                                                style: AppTextStyle.header3,
                                              ),
                                              gapHeight8,
                                              Text(
                                                  productOrders[index]
                                                      .productPurchaseDate
                                                      .toDDMMMYYYhhmm,
                                                  style: AppTextStyle.caption),
                                            ],
                                          )),
                                          gapWidth16,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              FundStatusIndicator(
                                                status: PortfolioStatus.active
                                                    .getStatus(
                                                        productOrders[index]
                                                                .status ??
                                                            ''),
                                              ),
                                              gapHeight8,
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    maxWidth: 120.w),
                                                child: Text(
                                                    productOrders[index]
                                                            .remark ??
                                                        '',
                                                    textAlign: TextAlign.end,
                                                    style:
                                                        AppTextStyle.caption),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ));
                              }),
                          ListView.separated(
                              itemCount: earlyRedemption.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: AppColor.white.withOpacity(0.2),
                                );
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context,
                                          CustomRouter
                                              .pendingSignPortfolioDetail,
                                          arguments:
                                              AgentPendingSignPortfolioDetailPage(
                                            referenceNumber:
                                                earlyRedemption[index]
                                                        .orderReferenceNumber ??
                                                    '',
                                            clientId: earlyRedemption[index]
                                                    .clientId ??
                                                '',
                                            newProductReferenceNumber:
                                                earlyRedemption[index]
                                                    .optionsVo
                                                    ?.newProductOrderReferenceNumber,
                                          ));
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  earlyRedemption[index]
                                                          .clientName ??
                                                      '',
                                                  style: AppTextStyle.header3),
                                              gapHeight8,
                                              Text(
                                                  earlyRedemption[index]
                                                          .productName ??
                                                      '',
                                                  style: AppTextStyle.bodyText),
                                              gapHeight8,
                                              Text(
                                                'RM${(earlyRedemption[index].purchasedAmount ?? 0.0).toInt().thousandSeparator()}',
                                                style: AppTextStyle.header3,
                                              ),
                                              gapHeight8,
                                              Text(
                                                  earlyRedemption[index]
                                                      .productPurchaseDate
                                                      .toDDMMMYYYhhmm,
                                                  style: AppTextStyle.caption),
                                            ],
                                          )),
                                          gapWidth16,
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              FundStatusIndicator(
                                                status: PortfolioStatus.active
                                                    .getStatus(
                                                        earlyRedemption[index]
                                                                .status ??
                                                            ''),
                                              ),
                                              gapHeight8,
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    maxWidth: 120.w),
                                                child: Text(
                                                    earlyRedemption[index]
                                                            .remark ??
                                                        '',
                                                    textAlign: TextAlign.end,
                                                    style:
                                                        AppTextStyle.caption),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ));
                              }),
                        ],
                      ),
                    ),
                  ))
            ],
          ));
    }, orElse: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
