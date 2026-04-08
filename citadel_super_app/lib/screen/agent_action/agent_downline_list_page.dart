import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/data/vo/agent_vo.dart';
import 'package:citadel_super_app/extension/agent_detail_extension.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/search_bar/app_search_bar.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/screen/dashboard/agent/agent_downline_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentDownlineListPage extends HookConsumerWidget {
  const AgentDownlineListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downlines = ref.watch(agentDownLineListFutureProvider);

    final textEditController = useTextEditingController();
    final searchValueNotifier = useState('');

    useEffect(() {
      textEditController.addListener(() {
        searchValueNotifier.value =
            textEditController.text.toLowerCase().trim();
      });
      return textEditController.dispose;
    }, [textEditController]);

    return CitadelBackground(
      backgroundType: BackgroundType.blueToOrange2,
      child: Column(
        children: [
          const CitadelAppBar(title: 'Downline List'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AppInfoContainer(
              height: 0.77.sh,
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  AppSearchBar(
                    controller: textEditController,
                    fillColor: Colors.transparent,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.offWhite),
                  ),
                  downlines.when(data: (data) {
                    final List<AgentVo> filteredClientData =
                        searchValueNotifier.value.isEmpty
                            ? data
                            : data.where((agent) {
                                final searchText = searchValueNotifier.value;

                                return (agent.agentNameDisplay)
                                        .toLowerCase()
                                        .contains(searchText) ||
                                    (agent.agentIdDisplay)
                                        .toLowerCase()
                                        .contains(searchText);
                              }).toList();

                    return Flexible(
                      child: ListView.separated(
                        padding: EdgeInsets.only(top: 0.h, bottom: 16.h),
                        itemCount: filteredClientData.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child:
                                Divider(color: AppColor.white.withOpacity(0.4)),
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          final agent = filteredClientData[index];
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: ListTile(
                                  title: Text(
                                    agent.agentNameDisplay,
                                    style: AppTextStyle.header3
                                        .copyWith(color: Colors.white),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      gapHeight8,
                                      Text(
                                        agent.agentIdDisplay,
                                        style: AppTextStyle.bodyText
                                            .copyWith(color: AppColor.offWhite),
                                      ),
                                      gapHeight8,
                                      Text(
                                        'Date joined: ${agent.joinedDateDisplay}',
                                        style: AppTextStyle.caption.copyWith(
                                            color: AppColor.labelGray),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        CustomRouter.agentDownlineDetails,
                                        arguments: AgentDownlineDetailsPage(
                                            agent: agent));
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }, loading: () {
                    return const Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(AppColor.white)));
                  }, error: (error, stackTrace) {
                    return Center(
                        child: Text(
                      'Unable to retrieve data',
                      style: AppTextStyle.header2,
                    ));
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
