import 'package:citadel_super_app/abstract/purchase_fund_base.dart';
import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/agent_repository.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/state/client_dashboard_state.dart';
import 'package:citadel_super_app/data/state/corporate_dashboard_state.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/state/product_state.dart';
import 'package:citadel_super_app/data/state/purchase_fund_state.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/project_widget/bottom_sheet/corporate_beneficiary_distribution_bottom_sheet.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/screen/fund/purchase_fund/purchase_fund_summary_page.dart';
import 'package:citadel_super_app/screen/universal/select_corporate_bank_detail_page.dart';
import 'package:citadel_super_app/screen/universal/select_corporate_beneficiary_page.dart';
import 'package:citadel_super_app/screen/universal/select_corporate_sub_beneficiary_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CorporatePurchaseFundPage extends PurchaseFundBase {
  final int productId;
  final String? corporateClientId;
  final bool purchaseByAgent;

  CorporatePurchaseFundPage(
      {super.key,
      required this.productId,
      this.corporateClientId,
      this.purchaseByAgent = false})
      : super(
          productId: productId,
          onPurchase: (context, ref, formKey) async {
            final CorporateRepository corporateRepository =
                CorporateRepository();

            final corporatePurchaseFundNotifier =
                ref.watch(corporatePurchaseFundProvider.notifier);

            final corporateProfile = await ref
                .read(corporateProfileProvider(corporateClientId).future);

            corporatePurchaseFundNotifier.setProductId(productId);
            corporatePurchaseFundNotifier.setCorporateId(corporateClientId ??
                corporateProfile.corporateClient?.corporateClientId ??
                '');

            EasyLoadingHelper.show();

            if (purchaseByAgent && corporateClientId != null) {
              await agentProductPurchase(
                  context, ref, formKey, corporateClientId);
            } else {
              await corporateProductPurchase(
                  context, ref, formKey, corporateClientId);
            }
          },
          onAmountChoosen: (ref, purchaseAmount, dividend, investMonth) {
            final corporatePurchaseFundNotifier =
                ref.watch(corporatePurchaseFundProvider.notifier);
            corporatePurchaseFundNotifier.setInvestAmount(purchaseAmount);

            corporatePurchaseFundNotifier.setDividend(dividend);

            corporatePurchaseFundNotifier
                .setInvestmentTenureMonths(investMonth);
          },
          onLivingTrustChoosen: (ref, livingTrustEnabled) {
            final corporatePurchaseFundNotifier =
                ref.watch(corporatePurchaseFundProvider.notifier);
            corporatePurchaseFundNotifier
                .setLivingTrustEnabled(livingTrustEnabled);
          },
        );
}

Future<void> agentProductPurchase(BuildContext context, WidgetRef ref,
    GlobalKey<AppFormState> formKey, String clientId) async {
  final AgentRepository agentRepository = AgentRepository();

  final purchaseFundState = ref.watch(corporatePurchaseFundProvider);

  EasyLoadingHelper.show();
  await agentRepository
      .agentProductPurchase(purchaseFundState)
      .baseThen(context, onResponseSuccess: (response) {
    ref.read(productOrderRefProvider.notifier).state = null;
    ref.read(productOrderRefProvider.notifier).state =
        response.productOrderReferenceNumber;

    Navigator.pushNamed(context, CustomRouter.selectCorporateBank,
        arguments: SelectCorporateBankDetailPage(
            chosenBank: null,
            corporateClientId: clientId,
            onConfirm: (bank) async {
              if (bank != null) {
                ref.read(corporatePurchaseFundProvider.notifier).setBankChoosen(
                      bank.id!,
                      bank.bankName!,
                    );

                await agentRepository
                    .agentProductPurchase(
                        ref.read(corporatePurchaseFundProvider),
                        referenceNumber: ref.read(productOrderRefProvider))
                    .baseThen(context, onResponseSuccess: (_) {
                  Navigator.pushNamed(getAppContext() ?? context,
                      CustomRouter.selectCorporateBeneficiary,
                      arguments: SelectCorporateBeneficiaryPage(
                        corporateClientId: clientId,
                        onConfirm: () {
                          showCorporateDistributionBottomSheet(
                            getAppContext() ?? context,
                          ).then((beneficiariesList) {
                            if ((beneficiariesList.beneficiary ?? []).length ==
                                1) {
                              Navigator.pushNamed(getAppContext() ?? context,
                                  CustomRouter.selectCorporateSubsBeneficiary,
                                  arguments: SelectCorporateSubsBeneficiaryPage(
                                    corporateClientId: clientId,
                                    onConfirm: (selectedSubsBeneficiary) {
                                      agentPurchaseSummary(
                                          context, ref, clientId);
                                    },
                                  ));
                            } else {
                              agentPurchaseSummary(context, ref, clientId);
                            }
                          });
                        },
                        onSaveDraft: () async {
                          await ref.refresh(
                              corporatePortfolioFutureProvider(clientId)
                                  .future);
                          Navigator.pushNamedAndRemoveUntil(
                              getAppContext() ?? context,
                              CustomRouter.dashboard,
                              (route) => route.isFirst);
                        },
                      ));
                });
              }
            }));
  }, onResponseError: (e, s) {}).whenComplete(
          () => EasyLoadingHelper.dismiss());
}

Future<void> agentPurchaseSummary(
    BuildContext context, WidgetRef ref, String clientId) async {
  final AgentRepository agentRepository = AgentRepository();
  await agentRepository
      .agentProductPurchase(ref.read(corporatePurchaseFundProvider),
          referenceNumber: ref.read(productOrderRefProvider))
      .baseThen(context, onResponseSuccess: (resp) {
    Navigator.pushNamed(context, CustomRouter.purchaseFundSummary,
        arguments: PurchaseFundSummaryPage(
          productSummary: resp,
          clientId: clientId,
          isCorporate: true,
        ));
  });
}

Future<void> corporateProductPurchase(BuildContext context, WidgetRef ref,
    GlobalKey<AppFormState> formKey, String? corporateClientId) async {
  final corporateProfile =
      await ref.read(corporateProfileProvider(corporateClientId).future);

  final CorporateRepository corporateRepository = CorporateRepository();
  await corporateRepository
      .purchaseProduct(ref.read(corporatePurchaseFundProvider))
      .baseThen(getAppContext() ?? context,
          onResponseSuccess: (response) async {
    ref.read(productOrderRefProvider.notifier).state = null;
    ref.read(productOrderRefProvider.notifier).state =
        response.productOrderReferenceNumber;

    Navigator.pushNamed(context, CustomRouter.selectCorporateBank,
        arguments: SelectCorporateBankDetailPage(
            chosenBank: null,
            onConfirm: (bank) async {
              if (bank != null) {
                ref.read(corporatePurchaseFundProvider.notifier).setBankChoosen(
                      bank.id!,
                      bank.bankName!,
                    );

                await corporateRepository
                    .purchaseProduct(ref.read(corporatePurchaseFundProvider),
                        referenceNumber:
                            ref.read(productOrderRefProvider.notifier).state)
                    .baseThen(
                  context,
                  onResponseSuccess: (response) async {
                    Navigator.pushNamed(getAppContext() ?? context,
                        CustomRouter.selectCorporateBeneficiary,
                        arguments: SelectCorporateBeneficiaryPage(
                          onConfirm: () {
                            showCorporateDistributionBottomSheet(
                              getAppContext() ?? context,
                            ).then((beneficiariesList) {
                              if ((beneficiariesList.beneficiary ?? [])
                                      .length ==
                                  1) {
                                Navigator.pushNamed(getAppContext() ?? context,
                                    CustomRouter.selectCorporateSubsBeneficiary,
                                    arguments:
                                        SelectCorporateSubsBeneficiaryPage(
                                  onConfirm: (selectedSubsBeneficiary) {
                                    productPurchase(context, ref, formKey,
                                        corporateClientId: corporateClientId);
                                  },
                                ));
                              } else {
                                productPurchase(
                                    getAppContext() ?? context, ref, formKey,
                                    corporateClientId: corporateClientId);
                              }
                            });
                          },
                          onSaveDraft: () async {
                            // ignore: unused_result
                            await ref.refresh(corporatePortfolioFutureProvider(
                                    corporateClientId ??
                                        corporateProfile.corporateClient
                                            ?.corporateClientId ??
                                        '')
                                .future);
                            Navigator.pushNamedAndRemoveUntil(
                                getAppContext() ?? context,
                                CustomRouter.dashboard,
                                (route) => route.isFirst);
                          },
                        ));
                  },
                  onResponseError: (e, s) {
                    if (e.message.contains('validation')) {
                      FormValidationHelper()
                          .resolveValidationError(formKey, e.message);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.message),
                          backgroundColor: AppColor.errorRed,
                        ),
                      );
                    }
                  },
                ).whenComplete(() => EasyLoadingHelper.dismiss());
              }
            }));
  }, onResponseError: (e, s) {
    if (e.message.contains('validation')) {
      FormValidationHelper().resolveValidationError(formKey, e.message);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
          backgroundColor: AppColor.errorRed,
        ),
      );
    }
  }).whenComplete(() {
    EasyLoadingHelper.dismiss();
  });
}

Future<void> productPurchase(
    BuildContext context, WidgetRef ref, GlobalKey<AppFormState> formKey,
    {String? corporateClientId}) async {
  final CorporateRepository corporateRepository = CorporateRepository();
  final corporatePurchaseFund = ref.watch(corporatePurchaseFundProvider);
  final productState = ref.watch(productOrderRefProvider);

  final corporateProfile =
      await ref.read(corporateProfileProvider(corporateClientId).future);

  if (productState == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColor.errorRed,
        content: Text('Reference number is missing'),
      ),
    );
    return;
  }

  EasyLoadingHelper.show();
  await corporateRepository
      .purchaseProduct(corporatePurchaseFund,
          referenceNumber: ref.read(productOrderRefProvider.notifier).state)
      .baseThen(
    context,
    onResponseSuccess: (response) async {
      ref.invalidate(corporatePortfolioDetailFutureProvider(
          ClientPortfolioReference(
              referenceNumber: productState,
              clientId: corporateProfile.corporateClient?.corporateClientId)));

      Navigator.pushNamed(context, CustomRouter.purchaseFundSummary,
          arguments: PurchaseFundSummaryPage(
            productSummary: response,
            isCorporate: true,
          ));
    },
    onResponseError: (e, s) {
      if (e.message.contains('validation')) {
        FormValidationHelper().resolveValidationError(formKey, e.message);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: AppColor.errorRed,
          ),
        );
      }
    },
  ).whenComplete(() => EasyLoadingHelper.dismiss());
}
