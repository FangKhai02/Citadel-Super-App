import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/data/vo/client_portfolio_vo.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/screen/fund/component/portfolio_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PortfolioPage extends HookConsumerWidget {
  final List<ClientPortfolioVo> portfolios;
  final bool isCorporate;
  final String? clientId;
  final bool allowEdit;
  final String pageTitle;
  const PortfolioPage(
      {super.key,
      required this.portfolios,
      required this.isCorporate,
      this.clientId,
      this.allowEdit = true,
      this.pageTitle = 'My Funds'});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CitadelBackground(
        backgroundType: BackgroundType.blueToOrange2,
        child: Column(
          children: [
            CitadelAppBar(
              title: pageTitle,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: AppInfoContainer(
                  height: 0.8.sh,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ListView.separated(
                      itemCount: portfolios.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: AppColor.white.withOpacity(0.2),
                        );
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            PortfolioRecord(
                              portfolio: portfolios[index],
                              isCorporate: isCorporate,
                              clientId: clientId,
                              allowEdit: allowEdit,
                            ),
                          ],
                        );
                      }),
                ))
          ],
        ));
  }
}
