import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/product_state.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/screen/fund/component/display_fund_banner.dart';
import 'package:citadel_super_app/screen/fund/component/simple_fund_banner.dart';
import 'package:citadel_super_app/screen/fund/trust_fund_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TrustFundWidget extends HookConsumerWidget {
  final String? corporateClientId;
  const TrustFundWidget({super.key, this.corporateClientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productFutureProvider);

    // return const TrustFundComingSoon();

    return products.when(
      data: (data) {
        if (data.isEmpty) {
          return const TrustFundComingSoon();
        } else {
          return TrustFundWithData(
            products: data,
            corporateClientId: corporateClientId,
          );
        }
      },
      error: (error, stackTrace) {
        return const SizedBox();
      },
      loading: () {
        return const SizedBox();
      },
    );
  }
}

class TrustFundWithData extends StatelessWidget {
  final List<dynamic> products;
  final String? corporateClientId;

  const TrustFundWithData(
      {required this.products, super.key, this.corporateClientId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: _trustFundTitle()),
              Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: AppTextButton(
                  title: 'View More',
                  onTap: () {
                    Navigator.pushNamed(context, CustomRouter.trustFund,
                        arguments: TrustFundPage(
                          clientId: corporateClientId,
                        ));
                  },
                ),
              ),
            ],
          ),
          gapHeight16,
          SizedBox(
            height: 168.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: products.take(3).toList().length,
              itemBuilder: (BuildContext context, int index) {
                return SimpleFundBanner(product: products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TrustFundComingSoon extends StatelessWidget {
  const TrustFundComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_trustFundTitle(), gapHeight16, const DisplayFundBanner()],
      ),
    );
  }
}

Widget _trustFundTitle() {
  return Text(
    'Trust Products Available',
    style: AppTextStyle.header2,
  );
}
