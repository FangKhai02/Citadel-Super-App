import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/fund/corporate_beneficiary_distribution.dart';
import 'package:citadel_super_app/data/state/beneficiary_distribution_state.dart';
import 'package:citadel_super_app/data/state/purchase_fund_state.dart';
import 'package:citadel_super_app/data/vo/product_order_beneficiary_request_vo.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/base_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<CorporateBeneficiaryDistribution> showCorporateDistributionBottomSheet(
    BuildContext context) async {
  CorporateBeneficiaryDistribution value = await showModalBottomSheet(
    backgroundColor: AppColor.white,
    context: context,
    isScrollControlled: true,
    builder: (context) => const CorporateBeneficiaryDistributionBottomSheet(),
  );
  return value;
}

class CorporateBeneficiaryDistributionBottomSheet
    extends StatefulHookConsumerWidget {
  const CorporateBeneficiaryDistributionBottomSheet({
    super.key,
  });

  @override
  CorporateBeneficiaryDistributionState createState() {
    return CorporateBeneficiaryDistributionState();
  }
}

class CorporateBeneficiaryDistributionState
    extends ConsumerState<CorporateBeneficiaryDistributionBottomSheet> {
  final formKey = GlobalKey<AppFormState>();

  @override
  void initState() {
    super.initState();
    formKey.currentState?.validateFormButton();
  }

  @override
  Widget build(BuildContext context) {
    final incorrectPercentage = useState(false);

    final corporateBeneficiaryDistributionState =
        ref.watch(corporateBeneficiaryDistributionProvider);

    final corporatePurchaseFundNotifier =
        ref.read(corporatePurchaseFundProvider.notifier);

    final corporateBeneficiaryDistributionNotifier =
        ref.watch(corporateBeneficiaryDistributionProvider.notifier);

    String? getPercentage(int index) {
      if (corporateBeneficiaryDistributionState.subBeneficiary == null &&
          corporateBeneficiaryDistributionState.beneficiary?.length == 1) {
        return '100';
      } else if (corporateBeneficiaryDistributionState.subBeneficiary != null &&
          corporateBeneficiaryDistributionState.subBeneficiary?.length == 1) {
        return '100';
      }

      return null;
    }

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AppForm(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gapHeight32,
                Text(
                  corporateBeneficiaryDistributionState.subBeneficiary == null
                      ? 'Distribution for the beneficiaries'
                      : 'Distribution for the sub-beneficiaries',
                  style:
                      AppTextStyle.header3.copyWith(color: AppColor.mainBlack),
                ),
                gapHeight24,
                ...List.generate(
                    corporateBeneficiaryDistributionState.subBeneficiary == null
                        ? corporateBeneficiaryDistributionState
                                .beneficiary?.length ??
                            0
                        : corporateBeneficiaryDistributionState
                                .subBeneficiary?.length ??
                            0, (index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          corporateBeneficiaryDistributionState
                                      .subBeneficiary ==
                                  null
                              ? corporateBeneficiaryDistributionState
                                      .beneficiary![index].fullName ??
                                  ''
                              : corporateBeneficiaryDistributionState
                                      .subBeneficiary![index].fullName ??
                                  '',
                          style: AppTextStyle.label
                              .copyWith(color: AppColor.labelBlack),
                        ),
                        AppTextFormField(
                          label: 'Percentage',
                          height: 32.h,
                          textStyle: BaseFormField.blackTextStyle,
                          initialValue: getPercentage(index) ?? '',
                          fieldKey: '${AppFormFieldKey.percentageKey}$index',
                          // floatingLabelBehavior: FloatingLabelBehavior.always,
                          decoration:
                              BaseFormField.blackTextInputDecoration.copyWith(
                            hintText: 'Enter beneficiary amount',
                            suffix: Text(
                              '%',
                              style: AppTextStyle.header3
                                  .copyWith(color: AppColor.brightBlue),
                            ),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ],
                    ),
                  );
                }),
                Visibility(
                  visible: incorrectPercentage.value,
                  child: Text(
                    'The total percentage for all primary beneficiaries must equal 100%.',
                    style:
                        AppTextStyle.caption.copyWith(color: AppColor.errorRed),
                  ),
                ),
                gapHeight32,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w)
                      .copyWith(bottom: 16.h),
                  child: PrimaryButton(
                    key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                    title: 'Confirm',
                    onTap: () async {
                      await formKey.currentState!.validate(
                          onSuccess: (formData) async {
                        FocusScope.of(context).unfocus();

                        double totalPercentage = 0;
                        List<double> proportion = [];
                        for (int i = 0; i < formData.length; i++) {
                          totalPercentage += double.parse(
                              formData['${AppFormFieldKey.percentageKey}$i']
                                  as String);
                          proportion.add(double.parse(
                              formData['${AppFormFieldKey.percentageKey}$i']
                                  as String));
                        }

                        if (totalPercentage != 100.0) {
                          incorrectPercentage.value = true;
                          return;
                        } else {
                          incorrectPercentage.value = false;

                          if (corporateBeneficiaryDistributionState
                                  .subBeneficiary ==
                              null) {
                            final List<ProductOrderBeneficiaryRequestVo>
                                beneficiaries =
                                corporateBeneficiaryDistributionState
                                    .beneficiary!
                                    .asMap()
                                    .entries
                                    .map((entry) {
                              final int index = entry.key;
                              final beneficiaryDistribute = entry.value;
                              return ProductOrderBeneficiaryRequestVo(
                                beneficiaryId: beneficiaryDistribute
                                    .corporateBeneficiaryId,
                                distributionPercentage: proportion[index],
                              );
                            }).toList();

                            corporatePurchaseFundNotifier
                                .setBeneficiaries(beneficiaries);
                            corporateBeneficiaryDistributionNotifier
                                .setSelectedDistribution(proportion);
                          } else {
                            final List<ProductOrderBeneficiaryRequestVo>
                                beneficiaries =
                                corporateBeneficiaryDistributionState
                                    .subBeneficiary!
                                    .asMap()
                                    .entries
                                    .map((entry) {
                              final int index = entry.key;
                              final beneficiaryDistribute = entry.value;
                              return ProductOrderBeneficiaryRequestVo(
                                beneficiaryId: beneficiaryDistribute
                                    .corporateBeneficiaryId,
                                distributionPercentage: proportion[index],
                              );
                            }).toList();
                            corporatePurchaseFundNotifier
                                .setSubBeneficiaries(beneficiaries);
                            corporateBeneficiaryDistributionNotifier
                                .setSelectedSubDistribution(proportion);
                          }

                          Navigator.pop(
                            context,
                            ref.read(corporateBeneficiaryDistributionProvider),
                          );
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
