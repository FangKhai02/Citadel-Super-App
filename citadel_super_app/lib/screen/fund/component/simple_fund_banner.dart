import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/vo/product_vo.dart';
import 'package:citadel_super_app/extension/product_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/screen/fund/trust_fund_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimpleFundBanner extends HookWidget {
  final String? corporateClientId;
  final ProductVo? product;

  const SimpleFundBanner(
      {super.key, required this.product, this.corporateClientId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: GestureDetector(
        onTap: product.productCatalogueUrlDisplay.isNotEmpty
            ? () {
                Navigator.pushNamed(context, CustomRouter.trustFundDetail,
                    arguments: TrustFundDetailPage(
                      product: product,
                      clientId: corporateClientId,
                    ));
              }
            : null,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: Stack(
            alignment: Alignment.bottomLeft,
            // fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(32.r),
                child: Image(
                  width: 252.w,
                  height: 168.h,
                  fit: BoxFit.cover,
                  image: product.imageOfProductUrlDisplay.isNotEmpty
                      ? NetworkImage(product.imageOfProductUrlDisplay)
                          as ImageProvider
                      : AssetImage(
                          Assets.images.temporary.fakeFundICHTBackground.path),
                ),
              ),
              SizedBox(
                width: 252.w,
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Text(
                    product.nameDisplay,
                    style: AppTextStyle.header1.copyWith(color: AppColor.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
