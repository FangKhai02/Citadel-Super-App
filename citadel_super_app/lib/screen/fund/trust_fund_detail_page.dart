import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/state/bottom_navigation_state.dart';
import 'package:citadel_super_app/data/state/product_state.dart';
import 'package:citadel_super_app/data/vo/product_vo.dart';
import 'package:citadel_super_app/extension/product_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/fund/corporate_purchase_fund/corporate_purchase_fund_page.dart';
import 'package:citadel_super_app/screen/fund/purchase_fund/purchase_fund_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';
import 'package:url_launcher/url_launcher.dart';

class TrustFundDetailPage extends HookConsumerWidget {
  final ProductVo? product;
  final String? clientId;
  final bool purchaseByAgent;

  const TrustFundDetailPage(
      {super.key,
      required this.product,
      this.clientId,
      this.purchaseByAgent = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PdfControllerPinch pdfPinchController = useMemoized(() {
      return PdfControllerPinch(
        document: PdfDocument.openData(
          http
              .get(Uri.parse(product.productCatalogueUrlDisplay))
              .then((response) => response.bodyBytes),
        ),
      );
    }, []);

    useEffect(() {
      return () => pdfPinchController.dispose;
    }, []);

    return CitadelBackground(
        backgroundType: BackgroundType.pureWhite,
        appBar: CitadelAppBar(
          title: product.nameDisplay,
          titleColor: AppColor.mainBlack,
          actions: [
            GestureDetector(
                onTap: () async {
                  EasyLoadingHelper.show();
                  final Uri uri = Uri.parse(product.productCatalogueUrlDisplay);
                  await launchUrl(uri);
                  EasyLoadingHelper.dismiss();
                },
                child: Image.asset(
                  Assets.images.icons.download.path,
                  width: 24.w,
                  color: AppColor.mainBlack,
                ))
          ],
        ),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
          child: PrimaryButton(
            title: 'Purchase Now',
            onTap: () {
              if (ref.read(bottomNavigationProvider).isLoginAsGuest) {
                Navigator.pushNamedAndRemoveUntil(
                    context, CustomRouter.login, (route) => false);
              } else {
                if (ref.read(bottomNavigationProvider).isCorporatePage ||
                    (clientId != null &&
                        (clientId ?? '').characters.last == 'C')) {
                  ref.read(productOrderRefProvider.notifier).state = null;
                  Navigator.pushNamed(
                      context, CustomRouter.corporatePurchaseFund,
                      arguments: CorporatePurchaseFundPage(
                        productId: product?.id ?? 0,
                        corporateClientId: clientId,
                        purchaseByAgent: purchaseByAgent,
                      ));
                } else {
                  Navigator.pushNamed(context, CustomRouter.purchaseFund,
                      arguments: PurchaseFundPage(
                        productId: product?.id ?? 0,
                        clientId: clientId,
                      ));
                }
              }
            },
          ),
        ),
        child: Column(children: [
          Flexible(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: PdfViewPinch(
                  controller: pdfPinchController,
                )),
          )
        ]));
  }
}
