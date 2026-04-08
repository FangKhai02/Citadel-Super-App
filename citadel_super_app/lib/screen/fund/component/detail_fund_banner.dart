import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/bottom_navigation_state.dart';
import 'package:citadel_super_app/data/state/product_state.dart';
import 'package:citadel_super_app/data/vo/product_vo.dart';
import 'package:citadel_super_app/extension/product_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/button/secondary_button.dart';
import 'package:citadel_super_app/screen/fund/corporate_purchase_fund/corporate_purchase_fund_page.dart';
import 'package:citadel_super_app/screen/fund/purchase_fund/purchase_fund_page.dart';
import 'package:citadel_super_app/screen/fund/trust_fund_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailFundBanner extends HookConsumerWidget {
  final ProductVo? product;
  final String? clientId;
  final bool purchaseByAgent;

  const DetailFundBanner(
      {super.key,
      required this.product,
      this.clientId,
      this.purchaseByAgent = false});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final navState = ref.watch(bottomNavigationProvider);

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 229.h),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.r),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: product.imageOfProductUrlDisplay.isNotEmpty
                  ? NetworkImage(product.imageOfProductUrlDisplay)
                      as ImageProvider
                  : AssetImage(
                      Assets.images.temporary.fakeFundICHTBackground.path),
              opacity: (product.isSoldOutDisplay) ? 0.5 : 1,
            )),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: 229.h),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      product.nameDisplay,
                      style: AppTextStyle.header1.copyWith(
                          color: AppColor.white.withOpacity(
                              (product.isSoldOutDisplay) ? 0.4 : 1)),
                    ),
                    gapHeight8,
                    Text(product.productDescriptionDisplay,
                        style: AppTextStyle.description.copyWith(
                            color: AppColor.white.withOpacity(
                                (product.isSoldOutDisplay) ? 0.4 : 1)),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3),
                    gapHeight24,
                    Row(
                      children: [
                        Expanded(
                            child: SecondaryButton(
                          height: 32.h,
                          onTap: product.productCatalogueUrlDisplay.isNotEmpty
                              ? () {
                                  Navigator.pushNamed(
                                      context, CustomRouter.trustFundDetail,
                                      arguments: TrustFundDetailPage(
                                          product: product,
                                          clientId: clientId));
                                }
                              : null,
                          title: 'View details',
                          icon: Image.asset(
                            Assets.images.icons.seeMore.path,
                            width: 16.r,
                          ),
                        )),
                        gapWidth16,
                        Expanded(
                          child: PrimaryButton(
                            height: 32.h,
                            onTap: product.isSoldOutDisplay == false
                                ? () {
                                    if (navState.isLoginAsGuest) {
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          CustomRouter.login, (route) => true);
                                    } else {
                                      if (navState.isCorporatePage ||
                                          (clientId != null &&
                                              (clientId ?? '')
                                                      .characters
                                                      .last ==
                                                  'C')) {
                                        ref
                                            .read(productOrderRefProvider
                                                .notifier)
                                            .state = null;
                                        Navigator.pushNamed(context,
                                            CustomRouter.corporatePurchaseFund,
                                            arguments:
                                                CorporatePurchaseFundPage(
                                              productId: product?.id ?? 0,
                                              corporateClientId: clientId,
                                              purchaseByAgent: purchaseByAgent,
                                            ));
                                      } else {
                                        Navigator.pushNamed(
                                            context, CustomRouter.purchaseFund,
                                            arguments: PurchaseFundPage(
                                              productId: product?.id ?? 0,
                                              clientId: clientId,
                                            ));
                                      }
                                    }
                                  }
                                : null,
                            title:
                                product.isSoldOutDisplay ? 'Sold' : 'Purchase',
                            icon: Image.asset(
                              Assets.images.icons.shop.path,
                              width: 16.r,
                            ),
                            primaryColor: product.isSoldOutDisplay
                                ? AppColor.disabledBlack
                                : AppColor.brightBlue,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Visibility(
                visible: (product.isSoldOutDisplay),
                child: Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    Assets.images.backgrounds.sold.path,
                    width: 80.w,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
