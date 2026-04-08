import 'package:citadel_super_app/data/state/product_state.dart';
import 'package:citadel_super_app/screen/fund/component/detail_fund_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TrustFundList extends HookConsumerWidget {
  final String? clientId;
  final bool purchaseByAgent;
  const TrustFundList({super.key, this.clientId, this.purchaseByAgent = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productFutureProvider);

    return products.when(data: (data) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 24.h),
            child: DetailFundBanner(
              product: data[index],
              clientId: clientId,
              purchaseByAgent: purchaseByAgent,
            ),
          );
        },
      );
    }, error: (error, stackTrace) {
      return const Center(
        child:
            Text('Unable to retrieve product, please refresh and try again.'),
      );
    }, loading: () {
      return const Center(child: CircularProgressIndicator());
    });
  }
}
