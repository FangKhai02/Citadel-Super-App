import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/data/vo/agent_client_vo.dart';
import 'package:citadel_super_app/extension/agent_client_extension.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/search_bar/app_search_bar.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/screen/agent_action/agent_client_details_page.dart';
import 'package:citadel_super_app/screen/dashboard/agent/component/page_view_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentClientListPage extends HookConsumerWidget {
  const AgentClientListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clients = ref.watch(agentClientListFutureProvider(null));

    final textEditController = useTextEditingController();
    final searchValueNotifier = useState('');

    final currentPageIndex = useState(0);
    final pageController = usePageController();

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
          const CitadelAppBar(title: 'Client List'),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.r),
                border: Border.all(color: AppColor.white),
              ),
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
              child: Row(
                children: [
                  Expanded(
                    child: PageViewTabWidget(
                      title: 'Clients',
                      index: 0,
                      currentPageIndex: currentPageIndex,
                    ),
                  ),
                  Expanded(
                    child: PageViewTabWidget(
                      title: 'Corporate',
                      index: 1,
                      currentPageIndex: currentPageIndex,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AppInfoContainer(
              height: 0.68.sh,
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
                  clients.when(data: (data) {
                    final List<AgentClientVo> filteredClientData =
                        searchValueNotifier.value.isEmpty
                            ? data.clients?.where((client) {
                                  return (client.clientIdDisplay).endsWith('I');
                                }).toList() ??
                                []
                            : data.clients?.where((client) {
                                  final searchText = searchValueNotifier.value;
                                  return (client.clientIdDisplay)
                                          .endsWith('I') &&
                                      ((client.nameDisplay)
                                              .toLowerCase()
                                              .contains(searchText) ||
                                          (client.clientIdDisplay)
                                              .toLowerCase()
                                              .contains(searchText));
                                }).toList() ??
                                [];

                    final List<AgentClientVo> filteredCorporateData =
                        searchValueNotifier.value.isEmpty
                            ? data.clients?.where((client) {
                                  return (client.clientIdDisplay).endsWith('C');
                                }).toList() ??
                                []
                            : data.clients?.where((client) {
                                  final searchText = searchValueNotifier.value;
                                  return (client.clientIdDisplay)
                                          .endsWith('C') &&
                                      ((client.nameDisplay)
                                              .toLowerCase()
                                              .contains(searchText) ||
                                          (client.clientIdDisplay)
                                              .toLowerCase()
                                              .contains(searchText));
                                }).toList() ??
                                [];

                    return Flexible(
                      child: ListView.separated(
                        padding: EdgeInsets.only(top: 0.h, bottom: 16.h),
                        itemCount: currentPageIndex.value == 0
                            ? filteredClientData.length
                            : filteredCorporateData.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child:
                                Divider(color: AppColor.white.withOpacity(0.4)),
                          );
                        },
                        itemBuilder: (BuildContext context, int index) {
                          final client = currentPageIndex.value == 0
                              ? filteredClientData[index]
                              : filteredCorporateData[index];

                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: ListTile(
                                  title: Text(
                                    client.nameDisplay,
                                    style: AppTextStyle.header3
                                        .copyWith(color: Colors.white),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      gapHeight8,
                                      Text(
                                        client.clientIdDisplay,
                                        style: AppTextStyle.bodyText
                                            .copyWith(color: AppColor.offWhite),
                                      ),
                                      gapHeight8,
                                      Text(
                                        'Date joined: ${client.joinedDateDisplay}',
                                        style: AppTextStyle.caption.copyWith(
                                            color: AppColor.labelGray),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        CustomRouter.agentClientDetails,
                                        arguments: AgentClientDetailsPage(
                                            client: client));
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
