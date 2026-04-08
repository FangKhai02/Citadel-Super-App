import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/fund/payment.dart';
import 'package:citadel_super_app/data/model/fund/portfolio_status.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/data/repository/agreement_repository.dart';
import 'package:citadel_super_app/data/state/agent_client_state.dart';
import 'package:citadel_super_app/data/state/client_dashboard_state.dart';
import 'package:citadel_super_app/data/state/corporate_dashboard_state.dart';
import 'package:citadel_super_app/data/vo/bank_details_vo.dart';
import 'package:citadel_super_app/data/vo/fund_beneficiary_details_vo.dart';
import 'package:citadel_super_app/data/vo/product_order_payment_details_vo.dart';
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
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/project_widget/container/white_border_container.dart';
import 'package:citadel_super_app/project_widget/dialog/app_checkbox_dialog.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/screen/fund/component/fund_status_indicator.dart';
import 'package:citadel_super_app/screen/universal/e_sign_agreement_page.dart';
import 'package:citadel_super_app/service/log_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentPendingSignPortfolioDetailPage extends StatefulHookConsumerWidget {
  final String referenceNumber;
  final String clientId;
  final String? newProductReferenceNumber;

  const AgentPendingSignPortfolioDetailPage(
      {super.key,
      required this.referenceNumber,
      required this.clientId,
      this.newProductReferenceNumber});

  @override
  AgentPendingSignPortfolioDetailPageState createState() =>
      AgentPendingSignPortfolioDetailPageState();
}

class AgentPendingSignPortfolioDetailPageState
    extends ConsumerState<AgentPendingSignPortfolioDetailPage> {
  late bool isCorporate;
  late ClientPortfolioReference portfolioReference;

  Widget _bankSection(BuildContext context, BankDetailsVo? bankDetails,
      WidgetRef ref, String referenceNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bank',
          style: AppTextStyle.header3,
        ),
        gapHeight16,
        AppInfoContainer(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bankDetails?.bankName ?? '',
              style: AppTextStyle.header3,
            ),
            Text(bankDetails?.bankAccountHolderName ?? '',
                style: AppTextStyle.description),
          ],
        ))
      ],
    );
  }

  Widget _beneficiarySection(BuildContext context,
      List<FundBeneficiaryDetailsVo> beneficiaries, WidgetRef ref) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        'Beneficiary',
        style: AppTextStyle.header3,
      ),
      gapHeight16,
      AppInfoContainer(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      Text(
                          getValueForKey(
                              beneficiaries[index].relationship ?? '', ref),
                          style: AppTextStyle.description),
                      Text(
                          '${beneficiaries[index].distributionPercentage?.toStringAsFixed(2) ?? ''}%',
                          style: AppTextStyle.description),
                    ],
                  )),
                  if (beneficiaries[index].subBeneficiaries != null &&
                      beneficiaries[index].subBeneficiaries!.isNotEmpty) ...[
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                        itemCount:
                            (beneficiaries[index].subBeneficiaries!.length))
                  ]
                ],
              ),
            );
          }),
        ]),
      )
    ]);
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
    ProductOrderPaymentDetailsVo? paymentMade,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment',
          style: AppTextStyle.header3,
        ),
        gapHeight16,
        AppInfoContainer(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppInfoText(
                'Payment Method', paymentMade?.paymentMethodNameDisplay ?? ''),
            gapHeight16,
            if (paymentMade?.bankName != null) ...[
              AppInfoText('Bank Name', paymentMade?.bankName ?? ''),
              gapHeight16,
            ],
            if (paymentMade?.transactionId != null) ...[
              AppInfoText('Transaction ID', paymentMade?.transactionId ?? ''),
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

  @override
  void initState() {
    super.initState();

    portfolioReference = ClientPortfolioReference(
        referenceNumber: widget.referenceNumber, clientId: widget.clientId);
  }

  Widget witnessCondition() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Text(
            'Choosing a Witness for Your Private Trust',
            style: AppTextStyle.header1.copyWith(color: AppColor.mainBlack),
          ),
          gapHeight16,
          Text(
            'To ensure your trust is legally valid, your witness must:',
            style: AppTextStyle.bodyText.copyWith(color: AppColor.mainBlack),
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
                    text: 'Be ',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: '18 or older',
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
                    text: 'Be ',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: 'of sound mind',
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
                    text: 'Not be a beneficiary',
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
                    text: 'Not be the spouse ',
                    style: AppTextStyle.header3
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: 'of a beneficiary (or risk losing entitlement)',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.mainBlack),
                  ),
                ],
              )))
            ],
          ),
          gapHeight8,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                Assets.images.icons.alert.path,
                width: 16.w,
                height: 16.w,
                color: AppColor.errorRed,
              ),
              gapWidth8,
              Expanded(
                  child: RichText(
                      text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Important: The ',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: 'Settlor, Beneficiaries, ',
                    style: AppTextStyle.header3
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: 'their ',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: 'spouses',
                    style: AppTextStyle.header3
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: ', or anyone legally unfit ',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: 'cannot ',
                    style: AppTextStyle.header3
                        .copyWith(color: AppColor.mainBlack),
                  ),
                  TextSpan(
                    text: 'act as witnesses. ',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.mainBlack),
                  ),
                ],
              )))
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final portfolioDetailsAsync = widget.clientId.characters.last == 'C'
        ? ref.watch(corporatePortfolioDetailFutureProvider(portfolioReference))
        : ref.watch(clientPortfolioDetailFutureProvider(portfolioReference));

    return portfolioDetailsAsync.maybeWhen(data: (portfolio) {
      return CitadelBackground(
        backgroundType: BackgroundType.blueToOrange2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CitadelAppBar(
              title: 'Trust Product Details',
            ),
            Padding(
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
                          Text(portfolio.clientPortfolio?.productName ?? '',
                              style: AppTextStyle.header2),
                          gapHeight8,
                          Text(
                              'RM${(portfolio.clientPortfolio?.purchasedAmount ?? 0.0).toInt().thousandSeparator()}',
                              style: AppTextStyle.number),
                          gapHeight8,
                          if (portfolio.agreementNumber != null) ...[
                            Text(portfolio.agreementNumber ?? '',
                                style: AppTextStyle.description),
                            gapHeight8,
                          ],
                          Text(
                              portfolio.clientPortfolio?.productPurchaseDate
                                      .toDDMMMYYYhhmmWithSpace ??
                                  '',
                              style: AppTextStyle.description),
                        ],
                      )),
                      gapHeight16,
                      FundStatusIndicator(
                          status: PortfolioStatus.active.getStatus(
                              portfolio.clientPortfolio?.status ?? '')),
                    ],
                  ),
                  gapHeight24,
                  _bankSection(context, portfolio.bankDetails, ref,
                      portfolio.clientPortfolio?.orderReferenceNumber ?? ''),
                  gapHeight24,
                  _beneficiarySection(
                    context,
                    portfolio.fundBeneficiaries ?? [],
                    ref,
                  ),
                  gapHeight24,
                  (portfolio.agreementNumber ?? '').contains('REALLOCATE') ||
                          (portfolio.agreementNumber ?? '').contains('ROLLOVER')
                      ? _noPaymentRequired()
                      : _paymentSection(
                          context,
                          ref,
                          portfolio.paymentDetails,
                        ),
                  gapHeight48,
                  PrimaryButton(
                    title: 'Proceed to sign E-agreement',
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AppCheckOutDialog(
                              title: 'Witness Eligibility Check',
                              message:
                                  'Other than the Settlor, Beneficiaries or their spouses and any other persons deemed unfit to be witnesses pursuant to the local statutory enactments. The failure to adhere to these statutory requirements could jeopardize the validity and enforceability of the legal document.\n\nAs a witness,',
                              checkBoxText:
                                  'I consent to the above mentioned clause and agree to proceed.',
                              positiveText: 'Continue',
                              positiveOnTap: () async {
                                if (widget.newProductReferenceNumber != null) {
                                  AgreementRepository repo =
                                      AgreementRepository();

                                  await repo
                                      .earlyRedemptionAgreement(
                                          widget.newProductReferenceNumber!)
                                      .baseThen(context,
                                          onResponseSuccess: (link) {
                                    if (link != null) {
                                      DownloadFileHelper()
                                          .createFileOfPdfFromUrl(link)
                                          .then((file) {
                                        Navigator.popAndPushNamed(
                                            getAppContext() ?? context,
                                            CustomRouter.eSignAgreement,
                                            arguments: ESignAgreementPage(
                                                widgetsList: [
                                                  witnessCondition()
                                                ],
                                                path: file.path,
                                                requiredIdentity: true,
                                                onSubmit: (signature,
                                                    [name,
                                                    userId,
                                                    role]) async {
                                                  await repo
                                                      .submitEarlyRedemptionAgreement(
                                                          widget
                                                              .newProductReferenceNumber!,
                                                          signature,
                                                          fullName: name,
                                                          userId: userId)
                                                      .baseThen(
                                                    getAppContext() ?? context,
                                                    onResponseSuccess: (_) {
                                                      ref.refresh(
                                                          agentPendingAgreementPortfoliosFutureProvider
                                                              .future);
                                                      Navigator.popUntil(
                                                          getAppContext() ??
                                                              context,
                                                          (route) =>
                                                              route.settings
                                                                  .name ==
                                                              CustomRouter
                                                                  .dashboard);
                                                    },
                                                    onResponseError: (e, s) {
                                                      if (e.message
                                                          .equalsIgnoreCase(
                                                              'api.invalid.signer')) {
                                                        //TODO: here still gt context issue
                                                        // Navigator.pop(
                                                        //     getAppContext() ??
                                                        //         context);
                                                        showDialog(
                                                            context:
                                                                getAppContext() ??
                                                                    context,
                                                            builder: (ctx) {
                                                              return AppDialog(
                                                                  title:
                                                                      'Unable to proceed',
                                                                  message:
                                                                      'A valid witness must not be the settlor or any of the beneficiaries. Kindly choose an eligible individual.',
                                                                  isRounded:
                                                                      true,
                                                                  positiveOnTap:
                                                                      () {
                                                                    Navigator.pop(
                                                                        getAppContext() ??
                                                                            ctx);
                                                                  },
                                                                  showNegativeButton:
                                                                      false,
                                                                  positiveText:
                                                                      'Retry');
                                                            });
                                                      } else {
                                                        context
                                                            .showErrorSnackBar(
                                                                e.message);
                                                      }
                                                    },
                                                  );
                                                }));
                                      }).catchError((e) {
                                        ScaffoldMessenger.of(
                                                getAppContext() ?? context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor:
                                                    AppColor.errorRed,
                                                content: Text(
                                                    'Agreement not found, please seek for assistance')));
                                      });
                                    } else {
                                      ScaffoldMessenger.of(
                                              getAppContext() ?? context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor:
                                                  AppColor.errorRed,
                                              content: Text(
                                                  'Agreement not found, please seek for assistance')));
                                    }
                                  });
                                } else {
                                  AgreementRepository repo =
                                      AgreementRepository();

                                  await repo
                                      .purchaseAgreement(widget.referenceNumber)
                                      .baseThen(context,
                                          onResponseSuccess: (link) {
                                    if (link != null) {
                                      DownloadFileHelper()
                                          .createFileOfPdfFromUrl(link)
                                          .then((file) {
                                        Navigator.pop(
                                            getAppContext() ?? context);
                                        Navigator
                                            .pushNamed(
                                                getAppContext() ?? context,
                                                CustomRouter.eSignAgreement,
                                                arguments: ESignAgreementPage(
                                                    widgetsList: [
                                                      witnessCondition()
                                                    ],
                                                    path: file.path,
                                                    requiredIdentity: true,
                                                    onSubmit: (signature,
                                                        [name,
                                                        userId,
                                                        role]) async {
                                                      await repo
                                                          .verifyAgreementWitness(
                                                              widget
                                                                  .referenceNumber,
                                                              fullName: name,
                                                              userId: userId,
                                                              signature)
                                                          .baseThen(
                                                        getAppContext() ??
                                                            context,
                                                        onResponseSuccess:
                                                            (_) async {
                                                          await showDialog(
                                                              context:
                                                                  getAppContext() ??
                                                                      context,
                                                              builder:
                                                                  (context) {
                                                                return AppDialog(
                                                                  title:
                                                                      'Declaration',
                                                                  message:
                                                                      'I declare that the details furnished above are true and correct to the best of my knowledge and I undertake to inform you of any changes therein immediately. I am also aware that I may be held liable for any form of false, misleading or misrepresented information being provided. I authorise Citadel Trustee Berhad to perform credit checks or any inquiries on my creditworthiness or in relation to assets, liabilities and make references to any credit applications or any subsequent application. I also understand that Citadel Trustee Berhad has the right to request for further information and or to decline this application.',
                                                                  positiveText:
                                                                      'Confirm',
                                                                  positiveOnTap:
                                                                      () async {
                                                                    EasyLoadingHelper
                                                                        .show();
                                                                    await repo
                                                                        .updatePurchaseAgreement(
                                                                            widget
                                                                                .referenceNumber,
                                                                            fullName:
                                                                                name,
                                                                            userId:
                                                                                userId,
                                                                            signature)
                                                                        .baseThen(
                                                                      getAppContext() ??
                                                                          context,
                                                                      onResponseSuccess:
                                                                          (_) {
                                                                        // ignore: unused_result
                                                                        ref.refresh(
                                                                            agentPendingAgreementPortfoliosFutureProvider.future);
                                                                        Navigator.popUntil(
                                                                            getAppContext() ??
                                                                                context,
                                                                            (route) =>
                                                                                route.settings.name ==
                                                                                CustomRouter.dashboard);
                                                                      },
                                                                      onResponseError:
                                                                          (e, s) {
                                                                        if (e
                                                                            .message
                                                                            .equalsIgnoreCase('api.invalid.signer')) {
                                                                          Navigator.pop(getAppContext() ??
                                                                              context);
                                                                          showDialog(
                                                                              context: getAppContext() ?? context,
                                                                              builder: (ctx) {
                                                                                return AppDialog(
                                                                                    title: 'Unable to proceed',
                                                                                    message: 'A valid witness must not be the settlor or any of the beneficiaries. Kindly choose an eligible individual.',
                                                                                    isRounded: true,
                                                                                    positiveOnTap: () {
                                                                                      Navigator.pop(ctx);
                                                                                    },
                                                                                    showNegativeButton: false,
                                                                                    positiveText: 'Retry');
                                                                              });
                                                                        } else {
                                                                          context
                                                                              .showErrorSnackBar(e.message);
                                                                        }
                                                                      },
                                                                    ).whenComplete(
                                                                            () {
                                                                      EasyLoadingHelper
                                                                          .dismiss();
                                                                    });
                                                                  },
                                                                  negativeText:
                                                                      'Decline',
                                                                  negativeOnTap:
                                                                      () {},
                                                                );
                                                              });
                                                        },
                                                        onResponseError:
                                                            (e, s) {
                                                          if (e.message
                                                              .equalsIgnoreCase(
                                                                  'api.invalid.signer')) {
                                                            showDialog(
                                                                context:
                                                                    getAppContext() ??
                                                                        context,
                                                                builder: (ctx) {
                                                                  return AppDialog(
                                                                      title:
                                                                          'Unable to proceed',
                                                                      message:
                                                                          'A valid witness must not be the settlor or any of the beneficiaries. Kindly choose an eligible individual.',
                                                                      isRounded:
                                                                          true,
                                                                      positiveOnTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            ctx);
                                                                      },
                                                                      showNegativeButton:
                                                                          false,
                                                                      positiveText:
                                                                          'Retry');
                                                                });
                                                          } else {
                                                            context
                                                                .showErrorSnackBar(
                                                                    e.message);
                                                          }
                                                        },
                                                      ).whenComplete(() {
                                                        EasyLoadingHelper
                                                            .dismiss();
                                                      });
                                                    }));
                                      }).catchError((e) {
                                        context.showErrorSnackBar(
                                            'Agreement not found, please seek for assistance');
                                      });
                                    } else {
                                      context.showErrorSnackBar(
                                          'Agreement not found, please seek for assistance');
                                    }
                                  });
                                }
                              },
                              isRounded: true,
                              negativeText: 'Cancel',
                              negativeOnTap: () {},
                            );
                          });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      );
    }, orElse: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
