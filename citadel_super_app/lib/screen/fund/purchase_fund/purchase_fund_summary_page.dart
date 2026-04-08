// ignore_for_file: unused_result

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/document.dart';
import 'package:citadel_super_app/data/model/fund/payment.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/repository/product_repository.dart';
import 'package:citadel_super_app/data/request/product_order_payment_upload_request_vo.dart';
import 'package:citadel_super_app/data/response/product_order_summary_response_vo.dart';
import 'package:citadel_super_app/data/state/client_dashboard_state.dart';
import 'package:citadel_super_app/data/state/corporate_dashboard_state.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/state/product_state.dart';
import 'package:citadel_super_app/data/state/purchase_fund_state.dart';
import 'package:citadel_super_app/data/vo/fund_beneficiary_details_vo.dart';
import 'package:citadel_super_app/data/vo/product_order_payment_receipt_vo.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/project_widget/app_info_text.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/bottom_sheet/payment_method_selection_bottom_sheet.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/screen/fund/agent_create_product_purchase_order_result_page.dart';
import 'package:citadel_super_app/screen/universal/payment_proof_page.dart';
import 'package:citadel_super_app/screen/fund/payment_result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PurchaseFundSummaryPage extends HookConsumerWidget {
  ProductOrderSummaryResponseVo productSummary;
  final bool isCorporate;
  final String? clientId;
  PurchaseFundSummaryPage(
      {super.key,
      required this.productSummary,
      this.isCorporate = false,
      this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productOrderRefProvider);

    return CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: const CitadelAppBar(title: 'Purchase Summary'),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
          child: PrimaryButton(
            title: clientId != null ? 'Confirm Order' : 'Pay Now',
            onTap: () async {
              if (clientId != null) {
                Navigator.pushNamed(
                  context,
                  CustomRouter.agentCreateProductOrderResult,
                  arguments: AgentCreateProductPurchaseOrderResultPage(
                    clientId: clientId!,
                  ),
                );
              } else {
                if (isCorporate) {
                  final result = await showPaymentMethodBottomSheet(
                      getAppContext() ?? context);

                  if (result != null) {
                    final corporatePurchaseFundNotifier =
                        ref.watch(corporatePurchaseFundProvider.notifier);
                    corporatePurchaseFundNotifier.setPaymentMethod(result);

                    switch (result) {
                      case PaymentMethod.manualTransfer:
                        Navigator.pushNamed(getAppContext() ?? context,
                            CustomRouter.paymentProof,
                            arguments: PaymentProofPage(
                              productCode: productSummary.productName ?? '',
                              showSaveDraftButton: true,
                              onConfirm: (proofList) async {
                                await corporatePurchaseUploadPayment(
                                    context, ref, proofList);
                              },
                              onSaveDraft: (proofList) async {
                                await corporatePurchaseDraftPayment(
                                    context, ref, proofList);
                              },
                            ));
                        break;
                      case PaymentMethod.onlineBanking:
                        Navigator.pushNamed(getAppContext() ?? context,
                            CustomRouter.paymentGateway);
                        break;
                    }

                    // final corporateRepository = CorporateRepository();
                    // await corporateRepository
                    //     .purchaseProduct(ref.read(corporatePurchaseFundProvider))
                    //     .baseThen(context, onResponseSuccess: (response) async {

                    //     });
                  }
                } else {
                  //Client purchase
                  final result = await showPaymentMethodBottomSheet(
                      getAppContext() ?? context);

                  if (result != null) {
                    final purchaseFundNoti =
                        ref.watch(purchaseFundProvider.notifier);

                    purchaseFundNoti.setPaymentMethod(result);

                    switch (result) {
                      case PaymentMethod.manualTransfer:
                        Navigator.pushNamed(getAppContext() ?? context,
                            CustomRouter.paymentProof,
                            arguments: PaymentProofPage(
                              productCode: productSummary.productName ?? '',
                              showSaveDraftButton: true,
                              onConfirm: (proofList) async {
                                await clientPurchaseUploadPayment(
                                    context, ref, proofList);
                              },
                              onSaveDraft: (proofList) async {
                                await clientPurchaseDraftPayment(
                                    context, ref, proofList);
                              },
                            ));
                        break;
                      case PaymentMethod.onlineBanking:
                        // ref.read(purchaseFundProvider.notifier).setPayment(
                        //     Payment(paymentMethod: PaymentMethod.onlineBanking));
                        Navigator.pushNamed(getAppContext() ?? context,
                            CustomRouter.paymentGateway);
                        break;
                    }
                  }
                }
              }
            },
          ),
        ),
        child: SizedBox(
          width: 1.sw,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productSummary.productName ?? '',
                  style: AppTextStyle.header1,
                ),
                gapHeight32,
                AppInfoText('Trust Product Amount',
                    'RM ${(productSummary.purchasedAmount ?? 0.0).toInt().thousandSeparator()}'),
                gapHeight24,
                AppInfoText('Returns from Placement (per Annum)',
                    '${productSummary.dividend.toString()}%'),
                gapHeight24,
                AppInfoText('Trust Tenure',
                    '${productSummary.investmentTenureMonth.getYearFromMonth} years'),
                gapHeight24,
                AppInfoText('Bank Account for Payout',
                    productSummary.bankDetails?.bankName ?? ''),
                gapHeight24,
                if (productSummary.productBeneficiaries != null) ...[
                  getBeneficiary(
                      context, ref, productSummary.productBeneficiaries!),
                  if (productSummary.productBeneficiaries!.length == 1 &&
                      ((productSummary.productBeneficiaries!.first
                                  .subBeneficiaries ??
                              [])
                          .isNotEmpty)) ...[
                    gapHeight24,
                    getSubBeneficiary(
                        context,
                        ref,
                        productSummary
                            .productBeneficiaries!.first.subBeneficiaries!),
                  ]
                ]
              ],
            ),
          ),
        ));
  }

  Future<void> corporatePurchaseUploadPayment(
      BuildContext context, WidgetRef ref, dynamic proofList) async {
    final corporateRepository = CorporateRepository();
    final productRepository = ProductRepository();
    final referenceNumber = ref.read(productOrderRefProvider);

    EasyLoadingHelper.show();

    final req = ProductOrderPaymentUploadRequestVo(
        receipts: ((proofList) as List<Document>)
            .map((e) => ProductOrderPaymentReceiptVo(
                  id: e.id,
                  fileName: e.fileName,
                  file: e.base64EncodeStr,
                  uploadStatus: "DRAFT",
                ))
            .toList());
    await productRepository
        .uploadPaymentReceipt(req, referenceNumber ?? '', false)
        .baseThen(context, onResponseSuccess: (_) async {
      await corporateRepository
          .purchaseProduct(ref.read(corporatePurchaseFundProvider),
              referenceNumber: referenceNumber)
          .baseThen(context, onResponseSuccess: (_) async {
        ref.invalidate(productOrderRefProvider);
        await ref.refresh(clientPortfolioFutureProvider.future);

        Navigator.pushNamed(
            getAppContext() ?? context, CustomRouter.paymentResult,
            arguments: const PaymentResultPage(
                type: PaymentResultType.manualTransferUpload));
      }, onResponseError: (e, s) {
        ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(SnackBar(
            backgroundColor: AppColor.errorRed, content: Text(e.message)));
      });
    }, onResponseError: (e, s) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: AppColor.errorRed,
        ),
      );
    }).whenComplete(() {
      EasyLoadingHelper.dismiss();
    });
  }

  Future<void> corporatePurchaseDraftPayment(
      BuildContext context, WidgetRef ref, dynamic proofList) async {
    final corporateRepository = CorporateRepository();
    final productRepository = ProductRepository();
    final referenceNumber = ref.read(productOrderRefProvider);
    final corporateProfile =
        await ref.read(corporateProfileProvider(null).future);

    EasyLoadingHelper.show();

    if (proofList.isNotEmpty) {
      final req = ProductOrderPaymentUploadRequestVo(
          receipts: ((proofList) as List<Document>)
              .map((e) => ProductOrderPaymentReceiptVo(
                    id: e.id,
                    fileName: e.fileName,
                    file: e.base64EncodeStr,
                    uploadStatus: "DRAFT",
                  ))
              .toList());
      await productRepository
          .uploadPaymentReceipt(req, referenceNumber ?? '', true)
          .baseThen(context, onResponseSuccess: (_) async {
        await corporateRepository
            .purchaseProduct(ref.read(corporatePurchaseFundProvider),
                referenceNumber: referenceNumber)
            .baseThen(context, onResponseSuccess: (_) async {
          ref.invalidate(productOrderRefProvider);
          await ref.refresh(clientPortfolioFutureProvider.future);

          Navigator.pushNamedAndRemoveUntil(getAppContext() ?? context,
              CustomRouter.dashboard, (route) => route.isFirst);
        }, onResponseError: (e, s) {
          ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
              SnackBar(
                  backgroundColor: AppColor.errorRed,
                  content: Text(e.message)));
        });
      }, onResponseError: (e, s) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: AppColor.errorRed,
          ),
        );
      }).whenComplete(() {
        EasyLoadingHelper.dismiss();
      });
    } else {
      EasyLoadingHelper.show();
      await corporateRepository
          .purchaseProduct(ref.read(corporatePurchaseFundProvider),
              referenceNumber: referenceNumber)
          .baseThen(context, onResponseSuccess: (_) async {
        await ref.refresh(corporatePortfolioFutureProvider(
                corporateProfile.corporateClient?.corporateClientId ?? '')
            .future);
        Navigator.pushNamedAndRemoveUntil(getAppContext() ?? context,
            CustomRouter.dashboard, (route) => route.isFirst);
      }).whenComplete(() {
        EasyLoadingHelper.dismiss();
      });
    }
  }

  Future<void> clientPurchaseUploadPayment(
      BuildContext context, WidgetRef ref, dynamic proofList) async {
    final productRepository = ProductRepository();
    final productState = ref.watch(productOrderRefProvider);

    EasyLoadingHelper.show();
    final req = ProductOrderPaymentUploadRequestVo(
        receipts: ((proofList) as List<Document>)
            .map((e) => ProductOrderPaymentReceiptVo(
                  id: e.id,
                  fileName: e.fileName,
                  file: e.base64EncodeStr,
                  uploadStatus: "DRAFT",
                ))
            .toList());
    await productRepository
        .uploadPaymentReceipt(req, productState ?? '', false)
        .baseThen(context, onResponseSuccess: (_) async {
      await productRepository
          .purchaseProduct(ref.read(purchaseFundProvider), productState!)
          .baseThen(context, onResponseSuccess: (_) async {
        ref.invalidate(productOrderRefProvider);
        await ref.refresh(clientPortfolioFutureProvider.future);
        Navigator.pushNamed(
            getAppContext() ?? context, CustomRouter.paymentResult,
            arguments: const PaymentResultPage(
                type: PaymentResultType.manualTransferUpload));
      }, onResponseError: (e, s) {
        ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(SnackBar(
            backgroundColor: AppColor.errorRed, content: Text(e.message)));
      }).whenComplete(() {
        EasyLoadingHelper.dismiss();
      });
    });
  }

  Future<void> clientPurchaseDraftPayment(
      BuildContext context, WidgetRef ref, dynamic proofList) async {
    ProductRepository productRepository = ProductRepository();
    final productState = ref.watch(productOrderRefProvider);
    if (proofList.isNotEmpty) {
      EasyLoadingHelper.show();
      final req = ProductOrderPaymentUploadRequestVo(
          receipts: ((proofList) as List<Document>)
              .map((e) => ProductOrderPaymentReceiptVo(
                    id: e.id,
                    fileName: e.fileName,
                    file: e.base64EncodeStr,
                    uploadStatus: "DRAFT",
                  ))
              .toList());
      await productRepository
          .uploadPaymentReceipt(req, productState ?? '', true)
          .baseThen(context, onResponseSuccess: (_) async {
        await productRepository
            .purchaseProduct(ref.read(purchaseFundProvider), productState!)
            .baseThen(context, onResponseSuccess: (_) async {
          ref.invalidate(productOrderRefProvider);
          await ref.refresh(clientPortfolioFutureProvider.future);
          Navigator.pushNamedAndRemoveUntil(getAppContext() ?? context,
              CustomRouter.dashboard, (route) => route.isFirst);
        }, onResponseError: (e, s) {
          ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
              SnackBar(
                  backgroundColor: AppColor.errorRed,
                  content: Text(e.message)));
        });
      }).whenComplete(() {
        EasyLoadingHelper.dismiss();
      });
    } else {
      await productRepository
          .purchaseProduct(ref.read(purchaseFundProvider), productState!)
          .baseThen(context, onResponseSuccess: (_) async {
        await ref.refresh(clientPortfolioFutureProvider.future);
        Navigator.pushNamedAndRemoveUntil(getAppContext() ?? context,
            CustomRouter.dashboard, (route) => route.isFirst);
      }).whenComplete(() {
        EasyLoadingHelper.dismiss();
      });
    }
  }

  Widget getBeneficiary(BuildContext context, WidgetRef ref,
      List<FundBeneficiaryDetailsVo> productBeneficiary) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        productBeneficiary.length > 1 ? 'Beneficiaries' : 'Beneficiary',
        style: AppTextStyle.label,
      ),
      gapHeight8,
      ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          itemBuilder: (context, index) {
            return Text(
              '${productBeneficiary[index].beneficiaryName} - ${productBeneficiary[index].distributionPercentage}%',
              style: AppTextStyle.bodyText,
            );
          },
          separatorBuilder: (context, index) {
            return gapHeight8;
          },
          itemCount: productBeneficiary.length),
    ]);
  }
}

Widget getSubBeneficiary(BuildContext context, WidgetRef ref,
    List<FundBeneficiaryDetailsVo> productSubBeneficiary) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(
      productSubBeneficiary.length > 1
          ? 'Sub-Beneficiaries'
          : 'Sub-Beneficiary',
      style: AppTextStyle.label,
    ),
    gapHeight8,
    ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Text(
            '${productSubBeneficiary[index].beneficiaryName} - ${productSubBeneficiary[index].distributionPercentage?.toStringAsFixed(2)}%',
            style: AppTextStyle.bodyText,
          );
        },
        separatorBuilder: (context, index) {
          return gapHeight8;
        },
        itemCount: productSubBeneficiary.length),
  ]);
}
