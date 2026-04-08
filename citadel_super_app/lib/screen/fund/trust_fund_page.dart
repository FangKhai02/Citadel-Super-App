import 'package:citadel_super_app/data/state/product_state.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/screen/fund/component/trust_fund_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TrustFundPage extends HookConsumerWidget {
  final String? clientId;
  final bool purchaseByAgent;
  const TrustFundPage({super.key, this.clientId, this.purchaseByAgent = false});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CitadelBackground(
        backgroundType: BackgroundType.pureBlack,
        appBar: const CitadelAppBar(title: 'Trust Products'),
        onRefresh: () async {
          // ignore: unused_result
          await ref.refresh(productFutureProvider.future);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              TrustFundList(
                clientId: clientId,
                purchaseByAgent: purchaseByAgent,
              ),
            ],
          ),
        ));
  }
}
