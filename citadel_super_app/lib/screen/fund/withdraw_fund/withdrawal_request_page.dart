import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/agreement_repository.dart';
import 'package:citadel_super_app/data/repository/product_repository.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/data/state/client_dashboard_state.dart';
import 'package:citadel_super_app/data/state/corporate_dashboard_state.dart';
import 'package:citadel_super_app/data/vo/client_portfolio_vo.dart';
import 'package:citadel_super_app/extension/context_extension.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/download_file_helper.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/document/app_upload_document_widget.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/base_form_field.dart';
import 'package:citadel_super_app/screen/universal/e_sign_agreement_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WithdrawalRequestPage extends StatefulHookConsumerWidget {
  final ClientPortfolioVo portfolio;
  const WithdrawalRequestPage({super.key, required this.portfolio});

  @override
  WithdrawalRequestPageState createState() => WithdrawalRequestPageState();
}

class WithdrawalRequestPageState extends ConsumerState<WithdrawalRequestPage> {
  final formKey = GlobalKey<AppFormState>();

  @override
  Widget build(BuildContext context) {
    final selectedMethod = useState('');

    return CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: const CitadelAppBar(
          title: 'Redemption Request',
        ),
        child: AppForm(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 1.sw,
                  decoration: BoxDecoration(
                    color: AppColor.brightBlue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.portfolio.productName ?? '',
                        style: AppTextStyle.header2,
                      ),
                      gapHeight8,
                      Text(
                        'RM${(widget.portfolio.purchasedAmount ?? 0.0).toInt().thousandSeparator()}',
                        style: AppTextStyle.number,
                      ),
                    ],
                  ),
                ),
                gapHeight32,
                Consumer(
                  builder: (context, ref, child) {
                    final constants = ref.read(appProvider).constants ?? [];
                    final earlyRedeemConstants = constants.firstWhere(
                        (element) =>
                            element.category ==
                            AppConstantsKey.redemptionEarlyRedeem);
                    final options = earlyRedeemConstants.list!
                        .map((e) =>
                            AppDropDownItem(value: e.key!, text: e.value!))
                        .toList();
                    return AppDropdown(
                      label: 'Method of Redemption',
                      fieldKey: AppFormFieldKey.methodOfRedemptionKey,
                      hintText: 'Method of Redemption',
                      options: options,
                      initialValue: 'All',
                      onSelected: (item) {
                        setState(() {
                          selectedMethod.value = item.value;
                        });
                      },
                    );
                  },
                ),
                if (selectedMethod.value == 'PARTIAL_AMOUNT') ...[
                  gapHeight24,
                  Text(
                    'Amount to Redeem',
                    style: TextStyle(
                        color: AppColor.labelGray,
                        fontSize: 11.spMin,
                        fontWeight: FontWeight.w500),
                  ),
                  AppTextFormField(
                    label: 'Amount to Redeem',
                    fieldKey: AppFormFieldKey.redeemAmountKey,
                    keyboardType:
                        const TextInputType.numberWithOptions(signed: true),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: BaseFormField.inputDecoration.copyWith(
                      hintText: 'Amount to Redeem',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: AppColor.placeHolderBlack,
                        fontFamily: 'ITCAvantGardeStd',
                      ),
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 32.w, maxWidth: 32.w),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'RM',
                            style: AppTextStyle.header3
                                .copyWith(color: AppColor.brightBlue),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                gapHeight16,
                Consumer(
                  builder: (context, ref, child) {
                    final constants = ref.read(appProvider).constants ?? [];
                    final reasonConstants = constants.firstWhere((element) =>
                        element.category == AppConstantsKey.withdrawalReason);
                    final options = reasonConstants.list!
                        .map((e) =>
                            AppDropDownItem(value: e.key!, text: e.value!))
                        .toList();
                    return const AppTextFormField(
                      label: 'Reason of Withdrawal',
                      fieldKey: AppFormFieldKey.reasonOfRedemptionKey,
                      maxLength: 50,
                    );
                  },
                ),
                gapHeight32,
                AppUploadDocumentWidget(
                    formKey: formKey,
                    fieldKey: AppFormFieldKey.proofDocKey,
                    type: DocumentType.normalDocument,
                    label: 'Supporting Document'),
                gapHeight48,
                PrimaryButton(
                  title: 'Submit',
                  onTap: () async {
                    await formKey.currentState!.validate(
                        onSuccess: (formData) async {
                      double redeemAmount;

                      if ((formData[AppFormFieldKey.methodOfRedemptionKey]
                              as String)
                          .equalsIgnoreCase('ALL')) {
                        redeemAmount = widget.portfolio.purchasedAmount ?? 0.0;
                      } else {
                        if ((double.tryParse(formData[
                                    AppFormFieldKey.redeemAmountKey]) ??
                                0.0) >
                            (widget.portfolio.purchasedAmount ?? 1.0)) {
                          context.showErrorSnackBar(
                              'Amount to redeem cannot be more than the purchased amount');
                          return;
                        } else {
                          redeemAmount = double.tryParse(
                                  formData[AppFormFieldKey.redeemAmountKey]) ??
                              0.0;
                        }
                      }
                      ProductRepository productRepo = ProductRepository();
                      final req = ParameterHelper()
                          .productEarlyRedemptionRequestVo(
                              widget.portfolio.orderReferenceNumber ?? '',
                              redeemAmount,
                              formData);
                      EasyLoadingHelper.show();

                      await productRepo
                          .productEarlyRedemption(true, req)
                          .baseThen(context, onResponseSuccess: (resp) async {
                        AgreementRepository agreementRepo =
                            AgreementRepository();
                        EasyLoadingHelper.show();
                        agreementRepo
                            .earlyRedemptionAgreement(
                                resp.redemptionReferenceNumber ?? '')
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
                                        await agreementRepo
                                            .submitEarlyRedemptionAgreement(
                                                resp.redemptionReferenceNumber ??
                                                    '',
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
                        }, onResponseError: (e, s) {
                          context.showErrorSnackBar(e.message);
                        }).whenComplete(() => EasyLoadingHelper.dismiss());
                      }, onResponseError: (e, s) {
                        context.showErrorSnackBar(e.message);
                      }).whenComplete(() => EasyLoadingHelper.dismiss());
                    });
                  },
                )
              ],
            ),
          ),
        ));
  }
}
