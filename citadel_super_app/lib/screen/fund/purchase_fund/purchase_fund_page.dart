import 'package:citadel_super_app/abstract/purchase_fund_base.dart';
import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/agent_repository.dart';
import 'package:citadel_super_app/data/repository/product_repository.dart';
import 'package:citadel_super_app/data/state/client_dashboard_state.dart';
import 'package:citadel_super_app/data/state/product_state.dart';
import 'package:citadel_super_app/data/state/purchase_fund_state.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/bottom_sheet/beneficiary_distribution_bottom_sheet.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/screen/fund/purchase_fund/purchase_fund_summary_page.dart';
import 'package:citadel_super_app/screen/universal/select_bank_detail_page.dart';
import 'package:citadel_super_app/screen/universal/select_beneficiary_page.dart';
import 'package:citadel_super_app/screen/universal/select_subs_beneficiary_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PurchaseFundPage extends PurchaseFundBase {
  final int productId;
  final String? clientId;

  PurchaseFundPage({super.key, required this.productId, this.clientId})
      : super(
          productId: productId,
          onPurchase: (context, ref, formKey) async {
            final ProductRepository productRepository = ProductRepository();

            final purchaseFundState = ref.watch(purchaseFundProvider);

            final purchaseFundNotifier =
                ref.watch(purchaseFundProvider.notifier);

            purchaseFundNotifier.setProductId(productId);
            purchaseFundNotifier.setClientId(clientId);

            await productRepository
                .purchaseProductValidation(purchaseFundState)
                .baseThen(
              context,
              onResponseSuccess: (response) async {
                if (clientId != null) {
                  await agentProductPurchase(context, ref, formKey, clientId);
                } else {
                  await clientProductPurchase(context, ref, formKey);
                }
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
            );
          },
          onAmountChoosen: (ref, purchaseAmount, dividend, investMonth) {
            final purchaseFundNotifier =
                ref.watch(purchaseFundProvider.notifier);
            purchaseFundNotifier.setInvestAmount(purchaseAmount);

            purchaseFundNotifier.setDividend(dividend);

            purchaseFundNotifier.setInvestmentTenureMonths(investMonth);
          },
          onLivingTrustChoosen: (ref, livingTrustEnabled) {
            final purchaseFundNotifier =
                ref.watch(purchaseFundProvider.notifier);
            purchaseFundNotifier.setLivingTrustEnabled(livingTrustEnabled);
          },
        );
}

Future<void> clientProductPurchase(BuildContext context, WidgetRef ref,
    GlobalKey<AppFormState> formKey) async {
  final ProductRepository productRepository = ProductRepository();
  final purchaseFundState = ref.watch(purchaseFundProvider);

  await productRepository.purchaseProduct(purchaseFundState, '').baseThen(
    context,
    onResponseSuccess: (response) async {
      ref.read(productOrderRefProvider.notifier).state = null;
      ref.read(productOrderRefProvider.notifier).state =
          response.productOrderReferenceNumber;

      Navigator.pushNamed(context, CustomRouter.selectBankDetail,
          arguments: SelectBankDetailPage(
              chosenBank: null,
              onConfirm: (bank) async {
                if (bank != null) {
                  ref.read(purchaseFundProvider.notifier).setBankChoosen(
                        bank.id!,
                        bank.bankName!,
                      );
                  await validatePurchaseProduct(context, ref,
                      onSuccess: () async {
                    await productRepository
                        .purchaseProduct(purchaseFundState,
                            ref.read(productOrderRefProvider)!)
                        .baseThen(context, onResponseSuccess: (_) {
                      ref.invalidate(clientPortfolioDetailFutureProvider(
                          ClientPortfolioReference(
                              referenceNumber:
                                  ref.read(productOrderRefProvider)!)));
                      ref.invalidate(clientPortfolioFutureProvider);

                      Navigator.pushNamed(getAppContext() ?? context,
                          CustomRouter.selectBeneficiary,
                          arguments: SelectBeneficiaryPage(
                            onConfirm: () {
                              showDistributionBottomSheet(
                                getAppContext() ?? context,
                              ).then((beneficiariesList) {
                                if ((beneficiariesList.beneficiary ?? [])
                                        .length ==
                                    1) {
                                  Navigator.pushNamed(
                                      getAppContext() ?? context,
                                      CustomRouter.selectSubstituteBeneficiary,
                                      arguments: SelectSubsBeneficiaryPage(
                                    onConfirm: (selectedSubsBeneficiary) {
                                      validationCheckpoint2(
                                          context, ref, formKey);
                                    },
                                  ));
                                } else {
                                  validationCheckpoint2(context, ref, formKey);
                                }
                              });
                            },
                            onSaveDraft: () async {
                              // ignore: unused_result
                              await ref.refresh(
                                  clientPortfolioFutureProvider.future);
                              Navigator.pushNamedAndRemoveUntil(
                                  getAppContext() ?? context,
                                  CustomRouter.dashboard,
                                  (route) => route.isFirst);
                            },
                          ));
                    }, onResponseError: (e, s) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: AppColor.errorRed,
                          content: Text(e.message)));
                    });
                  });
                }
              }));
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
  );
}

Future<void> agentProductPurchase(BuildContext context, WidgetRef ref,
    GlobalKey<AppFormState> formKey, String clientId) async {
  final AgentRepository agentRepository = AgentRepository();

  final purchaseFundState = ref.watch(purchaseFundProvider);
  final req =
      ParameterHelper().agentProductPurchaseParam(clientId, purchaseFundState);

  EasyLoadingHelper.show();
  await agentRepository.agentProductPurchase(req).baseThen(context,
      onResponseSuccess: (response) {
    ref.read(productOrderRefProvider.notifier).state = null;
    ref.read(productOrderRefProvider.notifier).state =
        response.productOrderReferenceNumber;

    Navigator.pushNamed(context, CustomRouter.selectBankDetail,
        arguments: SelectBankDetailPage(
            chosenBank: null,
            clientId: clientId,
            onConfirm: (bank) async {
              if (bank != null) {
                ref.read(purchaseFundProvider.notifier).setBankChoosen(
                      bank.id!,
                      bank.bankName!,
                    );
                await validatePurchaseProduct(context, ref,
                    onSuccess: () async {
                  final req2 = ParameterHelper()
                      .agentProductPurchaseParam(clientId, purchaseFundState);
                  await agentRepository
                      .agentProductPurchase(req2,
                          referenceNumber: ref.read(productOrderRefProvider))
                      .baseThen(context, onResponseSuccess: (_) {
                    Navigator.pushNamed(getAppContext() ?? context,
                        CustomRouter.selectBeneficiary,
                        arguments: SelectBeneficiaryPage(
                          clientId: clientId,
                          onConfirm: () {
                            showDistributionBottomSheet(
                              getAppContext() ?? context,
                            ).then((beneficiariesList) {
                              if ((beneficiariesList.beneficiary ?? [])
                                      .length ==
                                  1) {
                                Navigator.pushNamed(getAppContext() ?? context,
                                    CustomRouter.selectSubstituteBeneficiary,
                                    arguments: SelectSubsBeneficiaryPage(
                                      clientId: clientId,
                                      onConfirm: (selectedSubsBeneficiary) {
                                        validationCheckpoint2(
                                            context, ref, formKey,
                                            clientId: clientId);
                                      },
                                    ));
                              } else {
                                validationCheckpoint2(context, ref, formKey,
                                    clientId: clientId);
                              }
                            });
                          },
                          onSaveDraft: () async {
                            await ref
                                // ignore: unused_result
                                .refresh(clientPortfolioFutureProvider.future);
                            Navigator.pushNamedAndRemoveUntil(
                                getAppContext() ?? context,
                                CustomRouter.dashboard,
                                (route) => route.isFirst);
                          },
                        ));
                  }, onResponseError: (e, s) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: AppColor.errorRed,
                        content: Text(e.message)));
                  });
                });
              }
            }));
  }, onResponseError: (e, s) {}).whenComplete(
      () => EasyLoadingHelper.dismiss());
}

Future<void> validatePurchaseProduct(BuildContext context, WidgetRef ref,
    {required Function() onSuccess}) async {
  final ProductRepository productRepository = ProductRepository();

  final orderRefNumber = ref.watch(productOrderRefProvider);
  final purchaseFundState = ref.watch(purchaseFundProvider);

  if (orderRefNumber == null) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: AppColor.errorRed,
        content: Text('Reference number is missing')));
    return;
  }

  EasyLoadingHelper.show();
  await productRepository
      .purchaseProductValidation(purchaseFundState)
      .baseThen(context, onResponseSuccess: (_) async {
    await onSuccess();
  }, onResponseError: (e, s) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: AppColor.errorRed, content: Text(e.message)));
  }).whenComplete(() {
    EasyLoadingHelper.dismiss();
  });
}

Future<void> validationCheckpoint2(
    BuildContext context, WidgetRef ref, GlobalKey<AppFormState> formKey,
    {String? clientId}) async {
  final ProductRepository productRepository = ProductRepository();
  final AgentRepository agentRepository = AgentRepository();
  final purchaseFund = ref.watch(purchaseFundProvider);
  final productState = ref.watch(productOrderRefProvider);

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
  await productRepository.purchaseProductValidation2(purchaseFund).baseThen(
    context,
    onResponseSuccess: (response) async {
      if (clientId != null) {
        final req =
            ParameterHelper().agentProductPurchaseParam(clientId, purchaseFund);

        await agentRepository
            .agentProductPurchase(req,
                referenceNumber: ref.read(productOrderRefProvider))
            .baseThen(context, onResponseSuccess: (resp) {
          Navigator.pushNamed(context, CustomRouter.purchaseFundSummary,
              arguments: PurchaseFundSummaryPage(
                productSummary: resp,
                clientId: clientId,
              ));
        });
      } else {
        await productRepository
            .purchaseProduct(purchaseFund, productState)
            .baseThen(
          context,
          onResponseSuccess: (response) {
            ref.invalidate(clientPortfolioDetailFutureProvider(
                ClientPortfolioReference(referenceNumber: productState)));
            Navigator.pushNamed(context, CustomRouter.purchaseFundSummary,
                arguments: PurchaseFundSummaryPage(
                  productSummary: response,
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
        );
      }
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
