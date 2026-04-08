import 'dart:math';

import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/vo/client_portfolio_vo.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/screen/fund/component/portfolio_container.dart';
import 'package:citadel_super_app/screen/fund/portfolio/portfolio_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClientPurchasedPortfolioWidget extends HookConsumerWidget {
  final List<ClientPortfolioVo> clientPortfolioList;
  final String? clientId;

  const ClientPurchasedPortfolioWidget(
      {super.key, required this.clientPortfolioList, this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget clientPurchasedList() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                'Product Purchased',
                style: AppTextStyle.header2,
              )),
              AppTextButton(
                  title: 'View More',
                  onTap: () {
                    Navigator.pushNamed(context, CustomRouter.portfolio,
                        arguments: PortfolioPage(
                          clientId: clientId,
                          isCorporate: (clientId ?? '').characters.last == "C",
                          portfolios: clientPortfolioList,
                          allowEdit: false,
                          pageTitle: 'Product Purchased',
                        ));
                  })
            ],
          ),
          gapHeight16,
          SizedBox(
            height: 162.h,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemCount: min(clientPortfolioList.length, 6),
                itemBuilder: (BuildContext context, int index) {
                  return PortfolioContainer(
                    clientId: clientId,
                    isCorporate: (clientId ?? '').characters.last == "C",
                    portfolio: clientPortfolioList[index],
                    allowEdit: false,
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
            'Product Purchased',
            style: AppTextStyle.header2,
          ),
          gapHeight16,
          AppInfoContainer(
            child: Text(
              'Help your client to start growing their wealth by purchasing a product.',
              style: AppTextStyle.description,
            ),
          )
        ],
      );
    }

    return clientPortfolioList.isEmpty ? getPortfolio() : clientPurchasedList();
  }
}
