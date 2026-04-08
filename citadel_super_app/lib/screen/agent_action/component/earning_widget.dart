import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/screen/agent_action/component/earning_record.dart';
import 'package:citadel_super_app/screen/agent_action/earning_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarningWidget extends HookConsumerWidget {
  const EarningWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentEarning = ref.watch(agentEarningFutureProvider);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              'Earning',
              style: AppTextStyle.header2,
            )),
            agentEarning.maybeWhen(data: (data) {
              return (data.earningDetails ?? []).isNotEmpty
                  ? AppTextButton(
                      title: 'View More',
                      onTap: () {
                        Navigator.pushNamed(
                            context, CustomRouter.agentEarningList,
                            arguments: EarningListPage(
                                earningList: data.earningDetails ?? []));
                      })
                  : const SizedBox.shrink();
            }, orElse: () {
              return const SizedBox();
            })
          ],
        ),
        gapHeight16,
        agentEarning.maybeWhen(data: (data) {
          if ((data.earningDetails ?? []).isNotEmpty) {
            return AppInfoContainer(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              color: AppColor.cyan.withOpacity(0.2),
              child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.earningDetails!.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: AppColor.white.withOpacity(0.2),
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return EarningRecord(earning: data.earningDetails![index]);
                  }),
            );
          } else {
            return AppInfoContainer(
                child: Text(
              'Start your first sale to begin and see your earning grow.',
              style: AppTextStyle.description,
            ));
          }
        }, orElse: () {
          return AppInfoContainer(
              child: Text(
            'Start your first sale to begin and see your earning grow.',
            style: AppTextStyle.description,
          ));
        }),
        gapHeight32,
      ],
    );
  }
}
