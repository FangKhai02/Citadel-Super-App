import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/document.dart';
import 'package:citadel_super_app/data/model/fund/payment.dart';
import 'package:citadel_super_app/data/model/fund/portfolio_status.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/data/repository/agreement_repository.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/repository/product_repository.dart';
import 'package:citadel_super_app/data/request/product_early_redemption_request_vo.dart';
import 'package:citadel_super_app/data/request/product_order_payment_upload_request_vo.dart';
import 'package:citadel_super_app/data/response/client_portfolio_product_details_response_vo.dart';
import 'package:citadel_super_app/data/state/client_dashboard_state.dart';
import 'package:citadel_super_app/data/state/corporate_dashboard_state.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/state/product_state.dart';
import 'package:citadel_super_app/data/state/purchase_fund_state.dart';
import 'package:citadel_super_app/data/vo/bank_details_vo.dart';
import 'package:citadel_super_app/data/vo/fund_beneficiary_details_vo.dart';
import 'package:citadel_super_app/data/vo/portfolio_product_order_options_vo.dart';
import 'package:citadel_super_app/data/vo/product_order_beneficiary_request_vo.dart';
import 'package:citadel_super_app/data/vo/product_order_payment_details_vo.dart';
import 'package:citadel_super_app/data/vo/product_order_payment_receipt_vo.dart';
import 'package:citadel_super_app/extension/context_extension.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/helper/download_file_helper.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/project_widget/app_info_document.dart';
import 'package:citadel_super_app/project_widget/app_info_text.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/bottom_sheet/corporate_beneficiary_distribution_bottom_sheet.dart';
import 'package:citadel_super_app/project_widget/bottom_sheet/payment_method_selection_bottom_sheet.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/project_widget/container/white_border_container.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/screen/fund/component/fund_detail_remark_action.dart';
import 'package:citadel_super_app/screen/fund/component/fund_status_indicator.dart';
import 'package:citadel_super_app/screen/fund/component/rollover/rollover_request_page.dart';
import 'package:citadel_super_app/screen/fund/component/withdraw_fund_confirmation_dialog.dart';
import 'package:citadel_super_app/screen/fund/payment_result_page.dart';
import 'package:citadel_super_app/screen/fund/portfolio/portfolio_page.dart';
import 'package:citadel_super_app/screen/universal/e_sign_agreement_page.dart';
import 'package:citadel_super_app/screen/universal/payment_proof_page.dart';
import 'package:citadel_super_app/screen/universal/select_corporate_bank_detail_page.dart';
import 'package:citadel_super_app/screen/universal/select_corporate_beneficiary_page.dart';
import 'package:citadel_super_app/screen/universal/select_corporate_sub_beneficiary_page.dart';
import 'package:citadel_super_app/screen/universal/select_subs_beneficiary_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class CorporatePortfolioDetailPage extends StatefulHookConsumerWidget {
  String referenceNumber;
  String corporateClientId;
  bool allowEdit;

  CorporatePortfolioDetailPage(
      {super.key,
      required this.referenceNumber,
      required this.corporateClientId,
      this.allowEdit = true});

  @override
  CorporatePortfolioDetailPageState createState() {
    return CorporatePortfolioDetailPageState();
  }
}

class CorporatePortfolioDetailPageState
    extends ConsumerState<CorporatePortfolioDetailPage> {
  late ClientPortfolioReference portfolioReference;
  late PortfolioStatus? status;
  @override
  void initState() {
    super.initState();
    portfolioReference = ClientPortfolioReference(
        referenceNumber: widget.referenceNumber,
        clientId: widget.corporateClientId);
  }

  @override
  Widget build(BuildContext context) {
    final portfolioDetailState =
        ref.watch(corporatePortfolioDetailFutureProvider(portfolioReference));

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final portfolioDetails = await ref.read(
            corporatePortfolioDetailFutureProvider(portfolioReference).future);

        final corporateProfile =
            await ref.read(corporateProfileProvider(null).future);

        ref.read(productOrderRefProvider.notifier).state = null;

        ref.read(productOrderRefProvider.notifier).state =
            portfolioDetails.clientPortfolio?.orderReferenceNumber;

        ref.invalidate(corporatePurchaseFundProvider);

        final purchaseFundNoti =
            ref.read(corporatePurchaseFundProvider.notifier);

        purchaseFundNoti.setCorporateId(
            corporateProfile.corporateClient?.corporateClientId ?? '');

        purchaseFundNoti.setInvestAmount(
            portfolioDetails.clientPortfolio?.purchasedAmount ?? 0);
        purchaseFundNoti
            .setProductId(portfolioDetails.clientPortfolio?.productId ?? 0);
        purchaseFundNoti.setDividend(
            portfolioDetails.clientPortfolio?.productDividendAmount ?? 0);
        purchaseFundNoti.setInvestmentTenureMonths(
            portfolioDetails.clientPortfolio?.productTenureMonth ?? 0);
        purchaseFundNoti.setInvestmentTenureMonths(
            portfolioDetails.clientPortfolio?.productTenureMonth ?? 0);
        if (portfolioDetails.bankDetails?.id != null) {
          purchaseFundNoti.setBankChoosen(portfolioDetails.bankDetails?.id ?? 0,
              portfolioDetails.bankDetails?.bankName ?? '');
        }
        if ((portfolioDetails.fundBeneficiaries ?? []).isNotEmpty) {
          final List<ProductOrderBeneficiaryRequestVo> beneficiaries =
              portfolioDetails.fundBeneficiaries!.map((fundBeneficiary) {
            return ProductOrderBeneficiaryRequestVo(
              beneficiaryId: fundBeneficiary.beneficiaryId,
              distributionPercentage: fundBeneficiary.distributionPercentage,
            );
          }).toList();
          purchaseFundNoti.setBeneficiaries(beneficiaries);

          if (portfolioDetails.fundBeneficiaries?[0].subBeneficiaries != null) {
            final List<ProductOrderBeneficiaryRequestVo> subBeneficiaries =
                portfolioDetails.fundBeneficiaries!
                    .expand((fundBeneficiary) =>
                        fundBeneficiary.subBeneficiaries ?? [])
                    .map((subBeneficiary) {
              return ProductOrderBeneficiaryRequestVo(
                beneficiaryId: subBeneficiary.beneficiaryId,
                distributionPercentage: subBeneficiary.distributionPercentage,
              );
            }).toList();

            purchaseFundNoti.setSubBeneficiaries(subBeneficiaries);
          }
        }
      });
      return;
    }, []);

    return CitadelBackground(
      backgroundType: BackgroundType.blueToOrange2,
      child: Column(
        children: [
          const CitadelAppBar(
            title: 'Trust Product Details',
          ),
          portfolioDetailState.maybeWhen(data: (portfolioDetails) {
            status = PortfolioStatus.active
                .getStatus(portfolioDetails.clientPortfolio?.status ?? '');

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              portfolioDetails.clientPortfolio?.productName ??
                                  '',
                              style: AppTextStyle.header2),
                          gapHeight8,
                          Text(
                              'RM${(portfolioDetails.clientPortfolio?.purchasedAmount ?? 0.0).toInt().thousandSeparator()}',
                              style: AppTextStyle.number),
                          gapHeight8,
                          if (portfolioDetails.agreementNumber != null) ...[
                            Text(portfolioDetails.agreementNumber ?? '',
                                style: AppTextStyle.description),
                            gapHeight8,
                          ],
                          Text(
                              portfolioDetails
                                      .clientPortfolio
                                      ?.productPurchaseDate
                                      .toDDMMMYYYhhmmWithSpace ??
                                  '',
                              style: AppTextStyle.description),
                        ],
                      )),
                      gapHeight16,
                      FundStatusIndicator(
                          status: PortfolioStatus.active.getStatus(
                              portfolioDetails.clientPortfolio?.status ?? '')),
                    ],
                  ),
                  gapHeight24,
                  FundDetailRemarkAction(
                      status: PortfolioStatus.active.getStatus(
                          portfolioDetails.clientPortfolio?.status ?? ''),
                      remark: portfolioDetails.clientPortfolio?.remark,
                      documents:
                          widget.allowEdit ? portfolioDetails.documents : null),
                  if (portfolioDetails.clientPortfolio?.optionsVo != null) ...[
                    actionHistorySection(
                        portfolioDetails.clientPortfolio!.optionsVo!),
                    gapHeight24
                  ],
                  _bankSection(
                      context,
                      portfolioDetails.bankDetails,
                      ref,
                      portfolioDetails.clientPortfolio?.orderReferenceNumber ??
                          ''),
                  gapHeight24,
                  _beneficiarySection(
                      context,
                      portfolioDetails.fundBeneficiaries ?? [],
                      ref,
                      portfolioDetails.bankDetails?.id != null ? true : false,
                      portfolioDetails.clientPortfolio?.orderReferenceNumber ??
                          ''),
                  gapHeight24,
                  (portfolioDetails.agreementNumber ?? '')
                              .contains('REALLOCATE') ||
                          (portfolioDetails.agreementNumber ?? '')
                              .contains('ROLLOVER')
                      ? _noPaymentRequired()
                      : _paymentSection(
                          context,
                          ref,
                          portfolioDetails.clientPortfolio?.productCode ?? '',
                          portfolioDetails.paymentDetails,
                          PortfolioStatus.active.getStatus(
                              portfolioDetails.clientPortfolio?.status ?? ''),
                          portfolioDetails
                                  .clientPortfolio?.orderReferenceNumber ??
                              '',
                          portfolioDetails.fundBeneficiaries != null &&
                                  portfolioDetails.fundBeneficiaries!.isNotEmpty
                              ? true
                              : false),
                  gapHeight48,
                  if ((widget.allowEdit &&
                          (portfolioDetails
                                      .clientPortfolio?.clientAgreementStatus ??
                                  '')
                              .equalsIgnoreCase('PENDING')) ||
                      (!widget.allowEdit &&
                          (portfolioDetails.clientPortfolio
                                      ?.witnessAgreementStatus ??
                                  '')
                              .equalsIgnoreCase('PENDING'))) ...[
                    PrimaryButton(
                      title: 'Proceed to sign E-agreement',
                      onTap: () async {
                        AgreementRepository repo = AgreementRepository();

                        await repo
                            .purchaseAgreement(widget.referenceNumber)
                            .baseThen(context, onResponseSuccess: (link) {
                          if (link != null) {
                            DownloadFileHelper()
                                .createFileOfPdfFromUrl(link)
                                .then((file) {
                              Navigator.pushNamed(
                                  context, CustomRouter.eSignAgreement,
                                  arguments: ESignAgreementPage(
                                      requiredIdentity: true,
                                      requiredCompanyRole: true,
                                      clientId: widget.corporateClientId,
                                      path: file.path,
                                      widgetsList: [
                                        _corporateTrusteeInformation(),
                                        _declaration()
                                      ],
                                      onSubmit: (signature,
                                          [name, userId, role]) async {
                                        await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AppDialog(
                                                title: 'Declaration',
                                                message:
                                                    'I declare that the details furnished above are true and correct to the best of my knowledge and I undertake to inform you of any changes therein immediately. I am also aware that I may be held liable for any form of false, misleading or misrepresented information being provided. I authorise Citadel Trustee Berhad to perform credit checks or any inquiries on my creditworthiness or in relation to assets, liabilities and make references to any credit applications or any subsequent application. I also understand that Citadel Trustee Berhad has the right to request for further information and or to decline this application.',
                                                positiveText: 'Confirm',
                                                positiveOnTap: () async {
                                                  EasyLoadingHelper.show();
                                                  await repo
                                                      .updatePurchaseAgreement(
                                                          widget
                                                              .referenceNumber,
                                                          signature,
                                                          fullName: name,
                                                          userId: userId,
                                                          role: role)
                                                      .baseThen(context,
                                                          onResponseSuccess:
                                                              (_) {
                                                    // ignore: unused_result
                                                    ref.refresh(
                                                        corporatePortfolioFutureProvider(
                                                                widget
                                                                    .corporateClientId)
                                                            .future);
                                                    Navigator.popUntil(
                                                        context,
                                                        (route) =>
                                                            route.settings
                                                                .name ==
                                                            CustomRouter
                                                                .dashboard);
                                                  }).whenComplete(() {
                                                    EasyLoadingHelper.dismiss();
                                                  });
                                                },
                                                negativeText: 'Decline',
                                                negativeOnTap: () {
                                                  Navigator.pop(context);
                                                },
                                              );
                                            });
                                      }));
                            }).catchError((e) {
                              ScaffoldMessenger.of(getAppContext() ?? context)
                                  .showSnackBar(const SnackBar(
                                      backgroundColor: AppColor.errorRed,
                                      content: Text(
                                          'Agreement not found, please seek for assistance')));
                            });
                          } else {
                            ScaffoldMessenger.of(getAppContext() ?? context)
                                .showSnackBar(const SnackBar(
                                    backgroundColor: AppColor.errorRed,
                                    content: Text(
                                        'Agreement not found, please seek for assistance')));
                          }
                        });
                      },
                    )
                  ] else if (widget.allowEdit &&
                      (portfolioDetails
                                  .clientPortfolio?.optionsVo?.optionStatus ??
                              '')
                          .equalsIgnoreCase('PENDING')) ...[
                    PrimaryButton(
                      title: 'Proceed to sign E-agreement',
                      onTap: () async {
                        final redemptionReferenceNumber = portfolioDetails
                                .clientPortfolio
                                ?.optionsVo
                                ?.newProductOrderReferenceNumber ??
                            '';
                        AgreementRepository repo = AgreementRepository();

                        await repo
                            .earlyRedemptionAgreement(redemptionReferenceNumber)
                            .baseThen(context, onResponseSuccess: (link) {
                          if (link != null) {
                            DownloadFileHelper()
                                .createFileOfPdfFromUrl(link)
                                .then((file) {
                              Navigator.pushNamed(
                                  context, CustomRouter.eSignAgreement,
                                  arguments: ESignAgreementPage(
                                      path: file.path,
                                      onSubmit: (signature,
                                          [name, userId, role]) async {
                                        await repo
                                            .submitEarlyRedemptionAgreement(
                                                redemptionReferenceNumber,
                                                signature)
                                            .baseThen(
                                          context,
                                          onResponseSuccess: (_) {
                                            Navigator.pushNamed(context,
                                                CustomRouter.withdrawalResult);
                                            ref.refresh(
                                                clientPortfolioFutureProvider
                                                    .future);
                                            ref.invalidate(
                                                corporatePortfolioFutureProvider);
                                          },
                                          onResponseError: (e, s) {
                                            context
                                                .showErrorSnackBar(e.message);
                                          },
                                        );
                                      }));
                            }).catchError((e) {
                              ScaffoldMessenger.of(getAppContext() ?? context)
                                  .showSnackBar(const SnackBar(
                                      backgroundColor: AppColor.errorRed,
                                      content: Text(
                                          'Agreement not found, please seek for assistance')));
                            });
                          } else {
                            ScaffoldMessenger.of(getAppContext() ?? context)
                                .showSnackBar(const SnackBar(
                                    backgroundColor: AppColor.errorRed,
                                    content: Text(
                                        'Agreement not found, please seek for assistance')));
                          }
                        });
                      },
                    )
                  ] else if (widget.allowEdit &&
                      portfolioDetails.clientPortfolio?.status == 'DRAFT') ...[
                    AppTextButton(
                      title: 'Delete this draft',
                      textStyle: AppTextStyle.action
                          .copyWith(color: AppColor.errorRed),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AppDialog(
                                  title: 'Delete Draft',
                                  message:
                                      'Are you sure you want to delete this draft?',
                                  isRounded: true,
                                  positiveOnTap: () {
                                    deletePortfolioDraft(
                                        context, ref, widget.referenceNumber);
                                  },
                                  showNegativeButton: true,
                                  positiveText: 'Ok');
                            });
                      },
                    )
                  ] else if (widget.allowEdit &&
                      portfolioDetails.clientPortfolio?.status ==
                          'REJECTED') ...[
                    PrimaryButton(
                      title: 'Resubmit for review',
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AppDialog(
                                title: 'Confirmation',
                                message:
                                    'Please review and confirm that all details of your trust fund order are correct before proceeding.\n\nOnce resubmitted, our team will review your submission.',
                                isRounded: true,
                                positiveOnTap: () async {
                                  CorporateRepository corporateRepository =
                                      CorporateRepository();
                                  await corporateRepository
                                      .purchaseProduct(
                                          ref.read(
                                              corporatePurchaseFundProvider),
                                          referenceNumber:
                                              widget.referenceNumber)
                                      .baseThen(context,
                                          onResponseSuccess: (_) async {
                                    final portfolioList = await ref.refresh(
                                        corporatePortfolioFutureProvider(
                                                widget.corporateClientId)
                                            .future);
                                    Navigator.pop(getAppContext() ?? context);
                                    Navigator.pop(getAppContext() ?? context);
                                    Navigator.pushReplacementNamed(
                                      getAppContext() ?? context,
                                      CustomRouter.portfolio,
                                      arguments: PortfolioPage(
                                        portfolios: portfolioList,
                                        isCorporate: true,
                                      ),
                                    );
                                  }).whenComplete(
                                          () => EasyLoadingHelper.dismiss());
                                },
                                showNegativeButton: true,
                                positiveText: 'Confirm & Resubmit',
                                negativeText: 'Cancel',
                              );
                            });
                      },
                    )
                  ] else if (widget.allowEdit &&
                      (portfolioDetails.earlyRedemptionAllowed ?? false))
                    AppTextButton(
                      title: 'Early redeem this trust product',
                      textStyle: AppTextStyle.action
                          .copyWith(color: AppColor.errorRed),
                      onTap: () async {
                        ProductRepository productRepository =
                            ProductRepository();

                        ProductEarlyRedemptionRequestVo req =
                            ProductEarlyRedemptionRequestVo(
                                orderReferenceNumber: widget.referenceNumber,
                                withdrawalMethod: 'ALL');

                        await productRepository
                            .productEarlyRedemption(false, req)
                            .baseThen(context, onResponseSuccess: (data) {
                          showWithdrawFundConfirmationDialog(context,
                              portfolio: portfolioDetails.clientPortfolio!,
                              redeemInfo: data);
                        });
                      },
                    )
                  else if (widget.allowEdit &&
                      ((portfolioDetails.rolloverAllowed ?? false) ||
                          (portfolioDetails.reallocationAllowed ?? false) ||
                          (portfolioDetails.fullRedemptionAllowed ??
                              false))) ...[
                    PrimaryButton(
                      title: rolloverButtonName(portfolioDetails),
                      onTap: () {
                        Navigator.pushNamed(
                            context, CustomRouter.rolloverRequest,
                            arguments: RolloverRequestPage(
                                referenceNumber: widget.referenceNumber,
                                portfolioDetails: portfolioDetails));
                      },
                    )
                  ],
                  if (portfolioDetails.displayShareAgreementButton ??
                      false) ...[
                    gapHeight8,
                    PrimaryButton(
                      title: 'Share agreement to 2nd Signee',
                      icon: Assets.images.icons.share
                          .image(width: 24.w, height: 24.w),
                      onTap: () async {
                        await AgreementRepository()
                            .getSecondSigneeAgreementLink(portfolioDetails
                                    .clientPortfolio?.orderReferenceNumber ??
                                '')
                            .baseThen(
                          context,
                          onResponseSuccess: (link) {
                            if (link != null) {
                              SharePlus.instance
                                  .share(ShareParams(uri: Uri.parse(link)));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: AppColor.errorRed,
                                      content: Text(
                                          'Agreement not found, please seek for assistance')));
                            }
                          },
                          onResponseError: (e, s) {
                            context.showErrorSnackBar(e.message);
                          },
                        );
                      },
                    )
                  ]
                ],
              ),
            );
          }, orElse: () {
            return const Center(child: CircularProgressIndicator());
          }),
        ],
      ),
    );
  }

  String rolloverButtonName(
      ClientPortfolioProductDetailsResponseVo portfolioDetails) {
    List<String> actions = [];

    if (portfolioDetails.fullRedemptionAllowed == true) {
      actions.add('Redeem');
    }
    if (portfolioDetails.rolloverAllowed == true) {
      actions.add('Roll Over');
    }
    if (portfolioDetails.reallocationAllowed == true) {
      actions.add('Reallocation');
    }

    return actions.isNotEmpty ? actions.join(' / ') : '';
  }

  Widget actionHistorySection(PortfolioProductOrderOptionsVo options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Withdrawal / Rollover',
          style: AppTextStyle.header3,
        ),
        gapHeight16,
        AppInfoContainer(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getOptionString(options.optionType),
                style: AppTextStyle.bodyText),
            gapHeight8,
            Text(
              'RM${options.amount?.toInt().thousandSeparator()}',
              style: AppTextStyle.header3,
            ),
            gapHeight8,
            Text(
              options.statusString ?? '',
              style: AppTextStyle.caption,
            ),
          ],
        )),
      ],
    );
  }

  Widget _bankSection(BuildContext context, BankDetailsVo? bankDetails,
      WidgetRef ref, String referenceNumber) {
    final bool showEditButton = widget.allowEdit &&
        bankDetails?.id != null &&
        (status == PortfolioStatus.draft || status == PortfolioStatus.rejected);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              'Bank',
              style: AppTextStyle.header3,
            )),
            Visibility(
              visible: showEditButton,
              child: AppTextButton(
                  title: 'Edit',
                  onTap: () {
                    Navigator.pushNamed(
                        context, CustomRouter.selectCorporateBank,
                        arguments: SelectCorporateBankDetailPage(
                          chosenBank: null,
                          chosenBankFromPortfolio:
                              bankDetails?.id != null ? bankDetails : null,
                          onConfirm: (bank) async {
                            if (bank != null) {
                              final purchaseFundNotifier = ref
                                  .read(corporatePurchaseFundProvider.notifier);
                              purchaseFundNotifier.setBankChoosen(
                                  bank.id ?? 0, bank.bankName ?? '');

                              EasyLoadingHelper.show();

                              CorporateRepository corporateRepository =
                                  CorporateRepository();

                              await corporateRepository
                                  .purchaseProduct(
                                      ref.read(corporatePurchaseFundProvider),
                                      referenceNumber: referenceNumber)
                                  .baseThen(context, onResponseSuccess: (_) {
                                ref.invalidate(
                                    corporatePortfolioDetailFutureProvider(
                                        portfolioReference));
                              }).whenComplete(
                                      () => EasyLoadingHelper.dismiss());
                            }
                            Navigator.pop(getAppContext() ?? context);
                          },
                        ));
                  }),
            )
          ],
        ),
        gapHeight16,
        AppInfoContainer(
            child: bankDetails?.id != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bankDetails?.bankName ?? '',
                        style: AppTextStyle.header3,
                      ),
                      Text(bankDetails?.bankAccountHolderName ?? '',
                          style: AppTextStyle.description),
                    ],
                  )
                : RichText(
                    text: TextSpan(
                        style: AppTextStyle.description,
                        text: 'No bank was added. ',
                        children: widget.allowEdit
                            ? [
                                TextSpan(
                                  text: 'Add Now',
                                  style: AppTextStyle.action.copyWith(
                                    color: AppColor.brightBlue,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                        context,
                                        CustomRouter.selectCorporateBank,
                                        arguments:
                                            SelectCorporateBankDetailPage(
                                          chosenBank: null,
                                          chosenBankFromPortfolio:
                                              bankDetails?.id != null
                                                  ? bankDetails
                                                  : null,
                                          onConfirm: (bank) async {
                                            if (bank != null) {
                                              final purchaseFundNotifier =
                                                  ref.read(
                                                      corporatePurchaseFundProvider
                                                          .notifier);
                                              purchaseFundNotifier
                                                  .setBankChoosen(bank.id ?? 0,
                                                      bank.bankName ?? '');

                                              EasyLoadingHelper.show();

                                              CorporateRepository
                                                  corporateRepository =
                                                  CorporateRepository();

                                              await corporateRepository
                                                  .purchaseProduct(
                                                      ref.read(
                                                          corporatePurchaseFundProvider),
                                                      referenceNumber:
                                                          referenceNumber)
                                                  .baseThen(context,
                                                      onResponseSuccess: (_) {
                                                ref.invalidate(
                                                    corporatePortfolioDetailFutureProvider(
                                                        portfolioReference));
                                              }).whenComplete(() =>
                                                      EasyLoadingHelper
                                                          .dismiss());
                                            }
                                            Navigator.pop(
                                                getAppContext() ?? context);
                                          },
                                        ),
                                      );
                                    },
                                ),
                              ]
                            : [])))
      ],
    );
  }

  Widget _beneficiarySection(
      BuildContext context,
      List<FundBeneficiaryDetailsVo> beneficiaries,
      WidgetRef ref,
      bool allowEdit,
      String referenceNumber) {
    final bool showEditButton = widget.allowEdit &&
        allowEdit &&
        (status == PortfolioStatus.draft || status == PortfolioStatus.rejected);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              'Beneficiary',
              style: AppTextStyle.header3,
            )),
            Visibility(
              visible: showEditButton,
              child: AppTextButton(
                  title: 'Edit',
                  onTap: () {
                    Navigator.pushNamed(
                        context, CustomRouter.selectCorporateBeneficiary,
                        arguments: SelectCorporateBeneficiaryPage(
                          fundBeneficiaries: beneficiaries,
                          showSaveDraft: false,
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
                                    Navigator.popUntil(
                                        context,
                                        (route) =>
                                            route.settings.name ==
                                            CustomRouter
                                                .corporatePortfolioDetail);
                                    portfolioValidationCheckpoint2(
                                        context, ref, referenceNumber);
                                  },
                                ));
                              } else {
                                Navigator.pop(getAppContext() ?? context);
                                portfolioValidationCheckpoint2(
                                    getAppContext() ?? context,
                                    ref,
                                    referenceNumber);
                              }
                            });
                          },
                        ));
                  }),
            )
          ],
        ),
        gapHeight16,
        beneficiaries.isEmpty
            ? AppInfoContainer(
                child: allowEdit
                    ? RichText(
                        text: TextSpan(
                          style: AppTextStyle.description,
                          text: 'No beneficiary was added. ',
                          children: widget.allowEdit
                              ? [
                                  TextSpan(
                                    text: 'Add Now',
                                    style: AppTextStyle.action.copyWith(
                                      color: AppColor.brightBlue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushNamed(
                                            context,
                                            CustomRouter
                                                .selectCorporateBeneficiary,
                                            arguments:
                                                SelectCorporateBeneficiaryPage(
                                          onConfirm: () {
                                            showCorporateDistributionBottomSheet(
                                              getAppContext() ?? context,
                                            ).then((beneficiariesList) {
                                              if ((beneficiariesList
                                                              .beneficiary ??
                                                          [])
                                                      .length ==
                                                  1) {
                                                Navigator.pushNamed(
                                                    getAppContext() ?? context,
                                                    CustomRouter
                                                        .selectSubstituteBeneficiary,
                                                    arguments:
                                                        SelectSubsBeneficiaryPage(
                                                  onConfirm:
                                                      (selectedSubsBeneficiary) {
                                                    Navigator.popUntil(
                                                        context,
                                                        (route) =>
                                                            route.settings
                                                                .name ==
                                                            CustomRouter
                                                                .portfolioDetail);
                                                    portfolioValidationCheckpoint2(
                                                        context,
                                                        ref,
                                                        referenceNumber);
                                                  },
                                                ));
                                              } else {
                                                portfolioValidationCheckpoint2(
                                                    getAppContext() ?? context,
                                                    ref,
                                                    referenceNumber);
                                              }
                                            });
                                          },
                                        ));
                                      },
                                  ),
                                ]
                              : [],
                        ),
                      )
                    : Text(
                        'No beneficiary was added. ',
                        style: AppTextStyle.description,
                      ))
            : AppInfoContainer(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(
                        '${beneficiaries.length} beneficiar${beneficiaries.length > 1 ? 'ies' : 'y'} added.',
                        style: AppTextStyle.description),
                    gapHeight16,
                    ...List.generate(beneficiaries.length, (index) {
                      return Padding(
                        padding: index != beneficiaries.length - 1
                            ? EdgeInsets.only(bottom: 16.h)
                            : EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WhiteBorderContainer(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(beneficiaries[index].beneficiaryName ?? '',
                                    style: AppTextStyle.header3),
                                Text(beneficiaries[index].relationship ?? '',
                                    style: AppTextStyle.description),
                                Text(
                                    '${beneficiaries[index].distributionPercentage?.toStringAsFixed(2) ?? ''}%',
                                    style: AppTextStyle.description),
                              ],
                            )),
                            if (beneficiaries[index].subBeneficiaries != null &&
                                beneficiaries[index]
                                    .subBeneficiaries!
                                    .isNotEmpty) ...[
                              gapHeight16,
                              Text(
                                  '${beneficiaries[index].subBeneficiaries?.length} sub-Beneficiar${beneficiaries[index].subBeneficiaries!.length > 1 ? 'ies' : 'y'} added.',
                                  style: AppTextStyle.description),
                              gapHeight16,
                              ListView.separated(
                                  padding: const EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, subIndex) {
                                    return WhiteBorderContainer(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            beneficiaries[index]
                                                    .subBeneficiaries?[subIndex]
                                                    .beneficiaryName ??
                                                '',
                                            style: AppTextStyle.header3),
                                        Text(
                                            beneficiaries[index]
                                                    .subBeneficiaries?[subIndex]
                                                    .relationship ??
                                                '',
                                            style: AppTextStyle.description),
                                        Text(
                                            '${beneficiaries[index].subBeneficiaries?[subIndex].distributionPercentage?.toStringAsFixed(2) ?? ''}%',
                                            style: AppTextStyle.description),
                                      ],
                                    ));
                                  },
                                  separatorBuilder: (context, subIndex) {
                                    return gapHeight16;
                                  },
                                  itemCount: (beneficiaries[index]
                                      .subBeneficiaries!
                                      .length))
                            ]
                          ],
                        ),
                      );
                    }),
                  ])),
      ],
    );
  }

  Widget _noPaymentRequired() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment',
          style: AppTextStyle.header3,
        ),
        gapHeight16,
        AppInfoContainer(
          child: Text(
            'No Payment Required',
            style: AppTextStyle.description,
          ),
        )
      ],
    );
  }

  Widget _paymentSection(
      BuildContext context,
      WidgetRef ref,
      String productCode,
      ProductOrderPaymentDetailsVo? paymentMade,
      PortfolioStatus status,
      String referenceNumber,
      bool allowEdit) {
    final bool showEditButton = widget.allowEdit &&
        allowEdit &&
        (status == PortfolioStatus.draft || status == PortfolioStatus.rejected);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              'Payment',
              style: AppTextStyle.header3,
            )),
            Visibility(
              visible: showEditButton,
              child: AppTextButton(
                  title: 'Edit',
                  onTap: () {
                    final purchaseFundNoti =
                        ref.watch(purchaseFundProvider.notifier);

                    switch (paymentMade?.paymentMethodNameDisplay ?? '') {
                      case 'Manual Transfer':
                        purchaseFundNoti
                            .setPaymentMethod(PaymentMethod.manualTransfer);

                        Navigator.pushNamed(getAppContext() ?? context,
                            CustomRouter.paymentProof,
                            arguments: PaymentProofPage(
                                productCode: productCode,
                                proofList: (paymentMade?.paymentReceipts ?? [])
                                    .map((doc) => NetworkFile(
                                        id: doc.id,
                                        fileName:
                                            doc.fileName ?? 'Payment Receipt',
                                        url: doc.file ?? ''))
                                    .toList(),
                                onConfirm: (proofList) async {
                                  await uploadReceipt(
                                      context, ref, proofList, referenceNumber);
                                }));

                        break;
                      case 'Online Banking':
                        // ref.read(purchaseFundProvider.notifier).setPayment(
                        //     Payment(paymentMethod: PaymentMethod.onlineBanking));
                        Navigator.pushNamed(getAppContext() ?? context,
                            CustomRouter.paymentGateway);
                        break;
                    }
                  }),
            )
          ],
        ),
        gapHeight16,
        !(paymentMade?.paymentMethod != null &&
                (paymentMade?.paymentReceipts ?? []).isNotEmpty)
            ? AppInfoContainer(
                child: allowEdit
                    ? RichText(
                        text: TextSpan(
                          style: AppTextStyle.description,
                          text: 'No payment made. ',
                          children: widget.allowEdit
                              ? [
                                  TextSpan(
                                    text: 'Pay Now',
                                    style: AppTextStyle.action.copyWith(
                                      color: AppColor.brightBlue,
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        final result =
                                            await showPaymentMethodBottomSheet(
                                                getAppContext() ?? context);

                                        if (result != null) {
                                          final purchaseFundNoti = ref.watch(
                                              corporatePurchaseFundProvider
                                                  .notifier);

                                          purchaseFundNoti
                                              .setPaymentMethod(result);

                                          switch (result) {
                                            case PaymentMethod.manualTransfer:
                                              Navigator.pushNamed(
                                                  getAppContext() ?? context,
                                                  CustomRouter.paymentProof,
                                                  arguments: PaymentProofPage(
                                                      productCode: productCode,
                                                      onConfirm:
                                                          (proofList) async {
                                                        await uploadReceipt(
                                                            context,
                                                            ref,
                                                            proofList,
                                                            referenceNumber);
                                                      }));
                                              break;
                                            case PaymentMethod.onlineBanking:
                                              // ref.read(corporatePurchaseFundProvider.notifier).setPayment(
                                              //     Payment(paymentMethod: PaymentMethod.onlineBanking));
                                              Navigator.pushNamed(
                                                  getAppContext() ?? context,
                                                  CustomRouter.paymentGateway);
                                              break;
                                          }
                                          //   });
                                          // }
                                        }
                                      },
                                  ),
                                ]
                              : [],
                        ),
                      )
                    : Text(
                        'No payment made',
                        style: AppTextStyle.description,
                      ))
            : AppInfoContainer(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppInfoText('Payment Method',
                      paymentMade?.paymentMethodNameDisplay ?? ''),
                  gapHeight16,
                  if (paymentMade?.bankName != null) ...[
                    AppInfoText('Bank Name', paymentMade?.bankName ?? ''),
                    gapHeight16,
                  ],
                  if (paymentMade?.transactionId != null) ...[
                    AppInfoText(
                        'Transaction ID', paymentMade?.transactionId ?? ''),
                    gapHeight16,
                  ],
                  (paymentMade?.paymentReceipts ?? []).isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppInfoDocument(
                                  'Payment Receipt',
                                  paymentMade!.paymentReceipts!.map((e) {
                                    return NetworkFile(
                                        fileName: 'Payment receipt',
                                        url: e.file ?? '');
                                  }).toList())
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              )),
      ],
    );
  }

  Widget _corporateTrusteeInformation() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Text(
            'Important Information for Corporate Trust Signatories',
            style: AppTextStyle.header1.copyWith(color: AppColor.mainBlack),
          ),
          gapHeight16,
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                text: 'Under ',
                style:
                    AppTextStyle.bodyText.copyWith(color: AppColor.mainBlack),
              ),
              TextSpan(
                text: 'Section 66 of the Companies Act 2016,',
                style: AppTextStyle.header3.copyWith(color: AppColor.mainBlack),
              ),
              TextSpan(
                text: ' documents for a Corporate Trust must be signed by:',
                style:
                    AppTextStyle.bodyText.copyWith(color: AppColor.mainBlack),
              ),
            ],
          )),
          gapHeight8,
          Row(
            children: [
              Image.asset(
                Assets.images.icons.tick.path,
                width: 16.w,
                height: 16.w,
                color: AppColor.brightBlue,
              ),
              gapWidth8,
              Expanded(
                  child: RichText(
                      text: TextSpan(
                children: [
                  TextSpan(
                    text: 'At least ',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: 'two authorised officers,',
                    style: AppTextStyle.header3
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: ' one of whom must be a',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: ' director.',
                    style: AppTextStyle.header3
                        .copyWith(color: AppColor.mainBlack),
                  ),
                ],
              )))
            ],
          ),
          gapHeight8,
          Row(
            children: [
              Image.asset(
                Assets.images.icons.tick.path,
                width: 16.w,
                height: 16.w,
                color: AppColor.brightBlue,
              ),
              gapWidth8,
              Expanded(
                  child: RichText(
                      text: TextSpan(
                children: [
                  TextSpan(
                    text: 'If the company has a ',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: 'sole director, ',
                    style: AppTextStyle.header3
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: 'an ',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: 'independent witness',
                    style: AppTextStyle.header3
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: ' is required',
                    style: AppTextStyle.header3
                        .copyWith(color: AppColor.mainBlack),
                  ),
                ],
              )))
            ],
          ),
          gapHeight8,
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                text: 'An authorised officer includes a ',
                style:
                    AppTextStyle.bodyText.copyWith(color: AppColor.mainBlack),
              ),
              TextSpan(
                text: 'director, company secretary,',
                style: AppTextStyle.header3.copyWith(color: AppColor.mainBlack),
              ),
              TextSpan(
                text: ' or any person approved by the board through a',
                style:
                    AppTextStyle.bodyText.copyWith(color: AppColor.mainBlack),
              ),
              TextSpan(
                text: ' formal resolution.',
                style: AppTextStyle.header3.copyWith(color: AppColor.mainBlack),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Widget _declaration() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Declaration',
            style: AppTextStyle.header1.copyWith(color: AppColor.mainBlack),
          ),
          gapHeight16,
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                text: 'Your ',
                style:
                    AppTextStyle.bodyText.copyWith(color: AppColor.mainBlack),
              ),
              TextSpan(
                text: 'electronic signature (e-sign)',
                style: AppTextStyle.header3.copyWith(color: AppColor.mainBlack),
              ),
              TextSpan(
                text:
                    ' is not legally binding. To finalise the agreement, the ',
                style:
                    AppTextStyle.bodyText.copyWith(color: AppColor.mainBlack),
              ),
              TextSpan(
                text: 'Declaration of Trust (DOT)',
                style: AppTextStyle.header3.copyWith(color: AppColor.mainBlack),
              ),
              TextSpan(
                text: ' and ',
                style:
                    AppTextStyle.bodyText.copyWith(color: AppColor.mainBlack),
              ),
              TextSpan(
                text: 'Trust Deeds (TD)',
                style: AppTextStyle.header3.copyWith(color: AppColor.mainBlack),
              ),
              TextSpan(
                text: ' must be physically signed (wet ink) and returned to ',
                style:
                    AppTextStyle.bodyText.copyWith(color: AppColor.mainBlack),
              ),
              TextSpan(
                text: 'Citadel Trust Wealth Partners Sdn. Bhd.',
                style: AppTextStyle.header3.copyWith(color: AppColor.mainBlack),
              ),
              TextSpan(
                text:
                    '\n\nThe agreement only takes effect once the original signed documents are received by us.',
                style:
                    AppTextStyle.bodyText.copyWith(color: AppColor.mainBlack),
              ),
            ],
          )),
        ],
      ),
    );
  }

  Future<void> uploadReceipt(BuildContext context, WidgetRef ref, proofList,
      String referenceNumber) async {
    final ProductRepository productRepository = ProductRepository();

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
        .uploadPaymentReceipt(req, widget.referenceNumber, false)
        .baseThen(context, onResponseSuccess: (_) async {
      final CorporateRepository corporateRepository = CorporateRepository();

      corporateRepository
          .purchaseProduct(ref.read(corporatePurchaseFundProvider),
              referenceNumber: referenceNumber)
          .baseThen(context, onResponseSuccess: (_) async {
        ref.invalidate(
            corporatePortfolioDetailFutureProvider(portfolioReference));

        ref.invalidate(corporatePortfolioFutureProvider);

        Navigator.pushNamed(
            getAppContext() ?? context, CustomRouter.paymentResult,
            arguments: const PaymentResultPage(
              type: PaymentResultType.manualTransferUpload,
              popOnly: true,
            ));
      });
    });
  }

  Future<void> portfolioValidationCheckpoint2(
      BuildContext context, WidgetRef ref, String referenceNumber) async {
    final purchaseFund = ref.watch(corporatePurchaseFundProvider);
    CorporateRepository corporateRepository = CorporateRepository();
    EasyLoadingHelper.show();

    await corporateRepository
        .purchaseProduct(purchaseFund, referenceNumber: referenceNumber)
        .baseThen(context, onResponseSuccess: (_) {
      ref.invalidate(
          corporatePortfolioDetailFutureProvider(portfolioReference));
    }).whenComplete(() => EasyLoadingHelper.dismiss());
  }

  Future<void> deletePortfolioDraft(
      BuildContext context, WidgetRef ref, String referenceNumber) async {
    ProductRepository productRepository = ProductRepository();
    EasyLoadingHelper.show();
    await productRepository.productDraftDelete(referenceNumber).baseThen(
      context,
      onResponseSuccess: (response) async {
        final portfolioList = await ref.refresh(
            corporatePortfolioFutureProvider(widget.corporateClientId).future);
        Navigator.pop(getAppContext() ?? context);
        Navigator.pop(getAppContext() ?? context);
        Navigator.pushReplacementNamed(
          getAppContext() ?? context,
          CustomRouter.portfolio,
          arguments: PortfolioPage(
            portfolios: portfolioList,
            isCorporate: true,
          ),
        );
      },
      onResponseError: (e, s) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColor.errorRed, content: Text(e.message)));
      },
    ).whenComplete(() => EasyLoadingHelper.dismiss());
  }
}
