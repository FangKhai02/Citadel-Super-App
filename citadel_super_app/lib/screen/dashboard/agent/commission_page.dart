import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/screen/dashboard/agent/component/overriding_detail_page.dart';
import 'package:citadel_super_app/screen/dashboard/agent/component/personal_sale_detail_page.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommissionPage extends StatefulHookConsumerWidget {
  const CommissionPage({super.key});

  @override
  ConsumerState<CommissionPage> createState() => _CommissionPageState();
}

class _CommissionPageState extends ConsumerState<CommissionPage> {
  @override
  Widget build(BuildContext context) {
    final agentTotalSales = ref.watch(agentTotalSalesFutureProvider(null));
    final agentSalesDetails = ref.watch(agentSalesDetailsFutureProvider(null));
    final agentComissionOverriding =
        ref.watch(agentComissionOverridingFutureProvider(null));

    final currentPageIndex = useState(0);
    final pageController = usePageController();
    return CitadelBackground(
        backgroundType: BackgroundType.blueToOrange2,
        onRefresh: () async {
          await ref.refresh(agentTotalSalesFutureProvider(null).future);
          await ref.refresh(agentSalesDetailsFutureProvider(null).future);
          await ref
              .refresh(agentComissionOverridingFutureProvider(null).future);
        },
        child: Column(
          children: [
            const CitadelAppBar(
              title: "Commission",
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.r),
                    border: Border.all(color: AppColor.white)),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                child: Row(
                  children: [
                    Expanded(
                        child: tab('Personal Sales', 0, currentPageIndex,
                            pageController)),
                    Expanded(
                        child: tab(
                            'Overriding', 1, currentPageIndex, pageController))
                  ],
                ),
              ),
            ),
            ExpandablePageView(
              controller: pageController,
              onPageChanged: (index) {
                currentPageIndex.value = index;
              },
              children: const [
                PersonalSaleDetailPage(),
                OverridingDetailsPage()
              ],
            )
          ],
        ));
  }

  Widget tab(String title, int index, ValueNotifier<int> currentPageIndex,
      PageController pageController) {
    final isSelected = currentPageIndex.value == index;

    return InkWell(
        onTap: () {
          currentPageIndex.value = index;
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 7.5.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColor.cyan : Colors.transparent,
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: Center(
            child: Text(
              title,
              style:
                  isSelected ? AppTextStyle.action : AppTextStyle.description,
            ),
          ),
        ));
  }
}
