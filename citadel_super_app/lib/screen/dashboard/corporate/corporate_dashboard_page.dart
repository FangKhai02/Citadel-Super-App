import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/data/state/corporate_dashboard_state.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/bottom_nav_bar/citadel_bottom_nav.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/component/corporate_greeting_widget.dart';
import 'package:citadel_super_app/screen/fund/component/corporate_portfolio_widget.dart';
import 'package:citadel_super_app/screen/fund/component/trust_fund_widget.dart';
import 'package:citadel_super_app/screen/transaction/component/my_transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CorporateDashboardPage extends HookConsumerWidget {
  final String corporateClientId;
  const CorporateDashboardPage({super.key, required this.corporateClientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final corporateTransactionData =
        ref.watch(corporateTransactionFutureProvider(corporateClientId));
    return CitadelBackground(
        backgroundType: BackgroundType.blueToOrange2,
        bottomNavigationBar: const CitadelBottomNav(),
        onRefresh: () async {
          ref.invalidate(corporateProfileProvider);
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: kToolbarHeight)),
                  const CorporateGreetingWidget(),
                  gapHeight32,
                  CorporatePortfolioWidget(
                      corporateClientId: corporateClientId),
                  gapHeight32,
                  corporateTransactionData.when(
                    data: (data) => MyTransactionWidget(transactions: data),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) => const Center(
                      child: Text(
                        'Error loading transactions',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  gapHeight32,
                ],
              ),
            ),
            TrustFundWidget(
              corporateClientId: corporateClientId,
            )
          ],
        ));
  }
}
