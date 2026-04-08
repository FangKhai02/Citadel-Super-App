import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/extension/agent_client_extension.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TotalClientDetailPage extends HookConsumerWidget {
  final String agentId;
  const TotalClientDetailPage({super.key, required this.agentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientList = ref.watch(agentClientListFutureProvider(agentId));

    return AppInfoContainer(
      child: clientList.when(data: (data) {
        return ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final client = data.clients![index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client.nameDisplay,
                    style: AppTextStyle.header3,
                  ),
                  gapHeight8,
                  Text(
                    client.clientIdDisplay,
                    style: AppTextStyle.bodyText,
                  ),
                  gapHeight8,
                  Text(
                    'Date Joined: ${client.joinedDate.toDDMMMYYYhhmmWithSpace}',
                    style: AppTextStyle.caption,
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  gapHeight16,
                  Divider(
                    color: AppColor.white.withOpacity(0.2),
                  ),
                  gapHeight16
                ],
              );
            },
            itemCount: (data.clients ?? []).length);
      }, error: (e, s) {
        return Center(
          child: Text('Error: $e'),
        );
      }, loading: () {
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
