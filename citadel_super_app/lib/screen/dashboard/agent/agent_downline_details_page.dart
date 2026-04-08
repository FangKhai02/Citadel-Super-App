import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/data/model/sales_details.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/data/vo/agent_vo.dart';
import 'package:citadel_super_app/extension/agent_detail_extension.dart';
import 'package:citadel_super_app/project_widget/app_info_text.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/screen/dashboard/agent/component/page_view_tab_widget.dart';
import 'package:citadel_super_app/screen/dashboard/agent/component/total_sales_detail_page.dart';
import 'package:citadel_super_app/screen/dashboard/agent/total_client_detail_page.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentDownlineDetailsPage extends StatefulHookConsumerWidget {
  final AgentVo agent;
  const AgentDownlineDetailsPage({super.key, required this.agent});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      AgentDownlineDetailsPageState();
}

class AgentDownlineDetailsPageState
    extends ConsumerState<AgentDownlineDetailsPage> {
  late SalesDetails salesDetails;
  @override
  void initState() {
    super.initState();
    salesDetails = SalesDetails(agentId: widget.agent.agentId);
  }

  @override
  Widget build(BuildContext context) {
    final agentTotalSales =
        ref.watch(agentTotalSalesFutureProvider(widget.agent.agentId));
    final agentSalesDetails =
        ref.watch(agentSalesDetailsFutureProvider(salesDetails));

    final currentPageIndex = useState(0);
    final pageController = usePageController();

    return agentTotalSales.when(data: (data) {
      return CitadelBackground(
          backgroundType: BackgroundType.blueToOrange2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CitadelAppBar(
                  title: "Agent Sales",
                ),
                AppInfoText('Agent Name', widget.agent.agentNameDisplay),
                gapHeight16,
                AppInfoText('Agent Role', widget.agent.agentRoleDisplay),
                gapHeight16,
                AppInfoText('Agent ID', widget.agent.agentIdDisplay),
                gapHeight16,
                AppInfoText('Date Joined', widget.agent.joinedDateDisplay),
                gapHeight32,
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.r),
                    border: Border.all(color: AppColor.white),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: PageViewTabWidget(
                          title: 'Total Sales',
                          index: 0,
                          currentPageIndex: currentPageIndex,
                          pageController: pageController,
                        ),
                      ),
                      Expanded(
                        child: PageViewTabWidget(
                          title: 'Total Client',
                          index: 1,
                          currentPageIndex: currentPageIndex,
                          pageController: pageController,
                        ),
                      ),
                    ],
                  ),
                ),
                gapHeight32,
                ExpandablePageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    currentPageIndex.value = index;
                  },
                  children: [
                    TotalSalesDetailPage(
                      agentId: widget.agent.agentIdDisplay,
                    ),
                    TotalClientDetailPage(
                      agentId: widget.agent.agentIdDisplay,
                    )
                  ],
                )
              ],
            ),
          ));
    }, error: (e, s) {
      return Center(
        child: Text('Error: $e'),
      );
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    });
  }
}
