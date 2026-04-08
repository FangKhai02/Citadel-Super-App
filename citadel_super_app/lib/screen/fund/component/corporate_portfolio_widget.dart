import 'dart:math';

import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/corporate_dashboard_state.dart';
import 'package:citadel_super_app/data/vo/client_portfolio_vo.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/screen/fund/component/portfolio_container.dart';
import 'package:citadel_super_app/screen/fund/portfolio/portfolio_page.dart';
import 'package:citadel_super_app/screen/fund/trust_fund_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CorporatePortfolioWidget extends HookConsumerWidget {
  final String corporateClientId;
  const CorporatePortfolioWidget({super.key, required this.corporateClientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolio =
        ref.watch(corporatePortfolioFutureProvider(corporateClientId));

    Widget portfolioList({required List<ClientPortfolioVo> portfolios}) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                'My Portfolio',
                style: AppTextStyle.header2,
              )),
              AppTextButton(
                  title: 'View More',
                  onTap: () {
                    Navigator.pushNamed(context, CustomRouter.portfolio,
                        arguments: PortfolioPage(
                            isCorporate: true, portfolios: portfolios));
                  })
            ],
          ),
          gapHeight16,
          SizedBox(
            height: 140.h,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: min(portfolios.length, 6),
                itemBuilder: (BuildContext context, int index) {
                  return PortfolioContainer(
                    portfolio: portfolios[index],
                    isCorporate: true,
                  );
                }),
          )
        ],
      );
    }

    Widget getPortfolio() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Portfolio',
            style: AppTextStyle.header2,
          ),
          gapHeight16,
          AppInfoContainer(
            child: Column(
              children: [
                Text(
                  'Start your first placement with us now and see your money grow',
                  style: AppTextStyle.description,
                ),
                gapHeight16,
                PrimaryButton(
                  height: 32.h,
                  onTap: () {
                    Navigator.pushNamed(context, CustomRouter.trustFund,
                        arguments: const TrustFundPage());
                  },
                  title: 'Get Now',
                  icon: Image.asset(
                    Assets.images.icons.plus.path,
                    width: 16.w,
                  ),
                )
              ],
            ),
          )
        ],
      );
    }

    Widget portfolioComingSoon() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Portfolio',
            style: AppTextStyle.header2,
          ),
          gapHeight16,
          AppInfoContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Placement feature will be available soon.',
                  style: AppTextStyle.description,
                ),
              ],
            ),
          )
        ],
      );
    }

    return portfolio.when(data: (data) {
      return data.isEmpty
          // ? portfolioComingSoon()
          ? getPortfolio()
          : portfolioList(portfolios: data);
    }, error: (error, stackTrace) {
      // return portfolioComingSoon();
      return getPortfolio();
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
