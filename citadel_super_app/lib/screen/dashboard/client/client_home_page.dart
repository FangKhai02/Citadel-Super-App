import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/data/repository/client_repository.dart';
import 'package:citadel_super_app/data/state/client_dashboard_state.dart';
import 'package:citadel_super_app/data/state/product_state.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/bottom_nav_bar/citadel_bottom_nav.dart';
import 'package:citadel_super_app/screen/dashboard/client/component/client_greeting_widget.dart';
import 'package:citadel_super_app/screen/fund/component/portfolio_widget.dart';
import 'package:citadel_super_app/screen/fund/component/trust_fund_widget.dart';
import 'package:citadel_super_app/screen/transaction/component/my_transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClientHomePage extends HookConsumerWidget {
  final ClientRepository clientRepository = ClientRepository();

  ClientHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionData = ref.watch(clientTransactionFutureProvider);

    return CitadelBackground(
      backgroundType: BackgroundType.blueToOrange2,
      bottomNavigationBar: const CitadelBottomNav(),
      onRefresh: () async {
        // ignore: unused_result
        await ref.refresh(clientPortfolioFutureProvider.future);
        // ignore: unused_result
        await ref.refresh(productFutureProvider.future);
        // ignore: unused_result
        await ref.refresh(clientTransactionFutureProvider.future);
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: kToolbarHeight)),
                const ClientGreetingWidget(),
                gapHeight32,
                const PortfolioWidget(),
                gapHeight32,
                transactionData.when(
                  data: (data) => MyTransactionWidget(transactions: data),
                  loading: () => const Center(child: SizedBox.shrink()),
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
          const TrustFundWidget(),
        ],
      ),
    );
  }
}
