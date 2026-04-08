import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum SummarizeType {
  client(
    title: 'Total Client',
    description: 'New client this\nmonth: ',
  ),
  downline(
    title: 'Total Downline',
    description: 'New recruit this\nmonth: ',
  );

  final String title;
  final String description;

//total clients/  total downline
  int totalMember(WidgetRef ref) {
    final clients = ref.read(agentClientListFutureProvider(null));
    final downlines = ref.read(agentDownlineFutureProvider);
    switch (this) {
      case SummarizeType.client:
        return clients.when(
            data: (data) => data.totalClients ?? 0,
            loading: () => 0,
            error: (error, stackTrace) => 0);
      case SummarizeType.downline:
        return downlines.when(
            data: (data) => data.totalDownLine ?? 0,
            loading: () => 0,
            error: (error, stackTrace) => 0);
    }
  }

  int totalNewMemberThisMonth(WidgetRef ref) {
    final clients = ref.read(agentClientListFutureProvider(null));
    final downlines = ref.read(agentDownlineFutureProvider);
    switch (this) {
      case SummarizeType.client:
        return clients.when(
            data: (data) => data.totalNewClients ?? 0,
            loading: () => 0,
            error: (error, stackTrace) => 0);
      case SummarizeType.downline:
        return downlines.when(
            data: (data) => data.newRecruitThisMonth ?? 0,
            loading: () => 0,
            error: (error, stackTrace) => 0);
    }
  }

  Function()? navigate(BuildContext context) {
    switch (this) {
      case SummarizeType.client:
        return () {
          Navigator.pushNamed(context, CustomRouter.agentClientList);
        };
      case SummarizeType.downline:
        return () {
          Navigator.pushNamed(context, CustomRouter.agentDownlineList);
        };
    }
  }

  const SummarizeType({required this.title, required this.description});
}

class TotalWidget extends ConsumerWidget {
  final SummarizeType type;

  const TotalWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(agentClientListFutureProvider(null));
    ref.watch(agentDownlineFutureProvider);

    return GestureDetector(
      onTap: type.navigate(context),
      child: AppInfoContainer(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          borderRadius: 32.r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                Assets.images.icons.multiUser.path,
                width: 24.w,
                height: 24.h,
              ),
              gapHeight8,
              Text(
                type.title,
                style: AppTextStyle.header3,
              ),
              gapHeight16,
              Text(
                type.totalMember(ref).toString(),
                style: AppTextStyle.number,
              ),
              gapHeight16,
              Text(
                '${type.description} ${type.totalNewMemberThisMonth(ref)}',
                style: AppTextStyle.description,
              )
            ],
          )),
    );
  }
}
