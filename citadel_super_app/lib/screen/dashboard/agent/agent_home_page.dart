import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/bottom_nav_bar/citadel_bottom_nav.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/screen/dashboard/agent/component/agent_greeting_widget.dart';
import 'package:citadel_super_app/screen/agent_action/component/earning_widget.dart';
import 'package:citadel_super_app/screen/agent_action/component/total_widget.dart';
import 'package:citadel_super_app/screen/dashboard/agent/component/agent_info_container.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentHomePage extends HookConsumerWidget {
  const AgentHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agentPendingAgreement =
        ref.watch(agentPendingAgreementPortfoliosFutureProvider);
    final agentEarning = ref.watch(agentEarningFutureProvider);
    final agentTotalSales = ref.watch(agentTotalSalesFutureProvider(null));

    return CitadelBackground(
        backgroundType: BackgroundType.blueToOrange2,
        bottomNavigationBar: const CitadelBottomNav(),
        onRefresh: () async {
          await ref
              .refresh(agentPendingAgreementPortfoliosFutureProvider.future);
          await ref.refresh(agentEarningFutureProvider.future);
          await ref.refresh(agentTotalSalesFutureProvider(null).future);
          await ref.refresh(agentClientListFutureProvider(null).future);
          await ref.refresh(agentDownlineFutureProvider.future);
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: kToolbarHeight)),
                  const AgentGreetingWidget(),
                  gapHeight32,
                  agentPendingAgreement.maybeWhen(
                    data: (data) {
                      var productOrders = data.productOrders ?? [];
                      var earlyRedemption = data.earlyRedemptions ?? [];

                      if (productOrders.isEmpty && earlyRedemption.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Column(
                        children: [
                          AppInfoContainer(
                            color: AppColor.actionYellow.withOpacity(0.2),
                            borderRadius: 32.r,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      Assets.images.icons.alert.path,
                                      width: 16.w,
                                      height: 16.w,
                                      color: AppColor.orange,
                                    ),
                                    gapWidth8,
                                    Expanded(
                                      child: Text(
                                        'Your action is required!',
                                        textAlign: TextAlign.left,
                                        style: AppTextStyle.header3,
                                      ),
                                    )
                                  ],
                                ),
                                gapHeight16,
                                RichText(
                                  text: TextSpan(
                                      text:
                                          'One of your client has initiated a request for Trust order or redemption request. ',
                                      style: AppTextStyle.description,
                                      children: [
                                        TextSpan(
                                            text: ' Proceed to sign',
                                            style: AppTextStyle.action.copyWith(
                                              color: AppColor.brightBlue,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.pushNamed(
                                                    context,
                                                    CustomRouter
                                                        .pendingSignPortfolio);
                                              })
                                      ]),
                                ),
                              ],
                            ),
                          ),
                          gapHeight16,
                        ],
                      );
                    },
                    orElse: () => const SizedBox.shrink(),
                  ),
                  AgentInfoContainer(
                    image: Assets
                        .images
                        .icons
                        .graphArrowIncreaseAscendGrowthUpArrowStatsGraphRightGrow
                        .path,
                    title: 'Revenue',
                    onTap: () {
                      Navigator.pushNamed(
                          context, CustomRouter.agentCommission);
                    },
                  ),
                  gapHeight16,
                  Row(
                    children: [
                      const Expanded(
                        child: TotalWidget(
                          type: SummarizeType.client,
                        ),
                      ),
                      gapWidth16,
                      const Expanded(
                        child: TotalWidget(
                          type: SummarizeType.downline,
                        ),
                      )
                    ],
                  ),
                  gapHeight32,
                  const EarningWidget(),
                ],
              ),
            )
          ],
        ));
  }
}
