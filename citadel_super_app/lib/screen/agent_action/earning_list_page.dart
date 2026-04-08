import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/data/vo/agent_earning_vo.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/screen/agent_action/component/earning_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarningListPage extends HookConsumerWidget {
  List<AgentEarningVo> earningList;

  EarningListPage({required this.earningList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CitadelBackground(
        backgroundType: BackgroundType.blueToOrange2,
        child: Column(
          children: [
            const CitadelAppBar(
              title: 'Earning',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppInfoContainer(
                height: 0.8.sh,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                color: AppColor.cyan.withOpacity(0.2),
                child: ListView.separated(
                    itemCount: earningList.length,
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
                          EarningRecord(earning: earningList[index]),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ));
  }
}
