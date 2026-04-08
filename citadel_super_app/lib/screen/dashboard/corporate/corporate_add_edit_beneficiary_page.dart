import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/state/microblink_result_state.dart';
import 'package:citadel_super_app/data/vo/corporate_beneficiary_vo.dart';
import 'package:citadel_super_app/extension/microblink_result_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/project_widget/form/app_relationship_form_field.dart';
import 'package:citadel_super_app/abstract/corporate_beneficiary_form_base.dart';
import 'package:citadel_super_app/screen/dashboard/corporate/corporate_select_guardian_page.dart';
import 'package:flutter/material.dart';

class CorporateAddEditBeneficiaryPage extends CorporateDetailsForm {
  final CorporateBeneficiaryVo? beneficiaryDetail;
  final int? beneficiaryID;
  final String? corporateClientId;

  CorporateAddEditBeneficiaryPage(
      {super.key,
      this.beneficiaryDetail,
      this.beneficiaryID,
      this.corporateClientId})
      : super(
            onCreate: (context, ref, formKey) async {
              await formKey.currentState!.validate(onSuccess: (formData) async {
                final microblinkState = ref.read(microblinkResultProvider);
                final req = ParameterHelper().createCorporateBeneficiaryParam(
                    formData, microblinkState?.docType ?? 'MYKAD');
                CorporateRepository corporateRepository = CorporateRepository();
                EasyLoadingHelper.show();
                await corporateRepository
                    .createCorporateBeneficiary(req, corporateClientId)
                    .baseThen(context, onResponseSuccess: (data) {
                  ref.invalidate(microblinkResultProvider);
                  ref.invalidate(corporateBeneficiaryProvider);
                  if (data.isUnderAge == true) {
                    Navigator.pushReplacementNamed(
                        context, CustomRouter.corporateSelectGuardian,
                        arguments: CorporateSelectGuardianPage(
                          beneficiaryId: data.corporateBeneficiaryId!,
                          corporateClientId: corporateClientId,
                        ));
                  } else {
                    Navigator.popUntil(context, (routes) {
                      if ([
                        CustomRouter.corporateProfile,
                        CustomRouter.selectCorporateBeneficiary,
                        CustomRouter.selectCorporateSubsBeneficiary
                      ].contains(routes.settings.name)) {
                        return true;
                      }
                      return false;
                    });
                  }
                }, onResponseError: (e, s) {
                  if (e.message.contains('validation')) {
                    FormValidationHelper()
                        .resolveValidationError(formKey, e.message);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e.message),
                      backgroundColor: AppColor.errorRed,
                    ));
                  }
                }).whenComplete(() => EasyLoadingHelper.dismiss());
              });
            },
            onDelete: beneficiaryDetail != null
                ? (context, ref, formKey) {
                    return AppTextButton(
                        title: 'Delete this beneficiary',
                        textStyle: AppTextStyle.action
                            .copyWith(color: AppColor.errorRed),
                        onTap: () async {
                          final isConfirm = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AppDialog(
                                    title:
                                        'Are you sure you want to delete this beneficiary?',
                                    positiveText: 'No',
                                    positiveOnTap: () {
                                      Navigator.pop(context);
                                    },
                                    isRounded: true,
                                    negativeText: 'Yes, delete',
                                    negativeOnTap: () {
                                      Navigator.pop(context, true);
                                    },
                                  );
                                },
                              ) as bool? ??
                              false;

                          if (!isConfirm || !context.mounted) return;

                          CorporateRepository corporateRepository =
                              CorporateRepository();
                          EasyLoadingHelper.show();
                          await corporateRepository
                              .deleteCorporateBeneficiary(
                                  beneficiaryDetail.corporateBeneficiaryId,
                                  corporateClientId)
                              .baseThen(context, onResponseSuccess: (data) {
                            ref.invalidate(corporateBeneficiaryProvider);
                            Navigator.popUntil(context, (route) {
                              return route.settings.name ==
                                  CustomRouter.corporateProfile;
                            });
                          }).whenComplete(() => EasyLoadingHelper.dismiss());
                        });
                    //
                  }
                : (context, ref, formKey) {
                    return const SizedBox.shrink();
                  },
            onEdit: (context, ref, formKey) async {
              await formKey.currentState!.validate(onSuccess: (formData) async {
                final req =
                    ParameterHelper().editCorporateBeneficiaryParam(formData);

                CorporateRepository corporateRepository = CorporateRepository();
                EasyLoadingHelper.show();
                await corporateRepository
                    .editCorporateBeneficiary(
                        req,
                        beneficiaryDetail?.corporateBeneficiaryId,
                        corporateClientId)
                    .baseThen(context, onResponseSuccess: (data) {
                  ref.invalidate(corporateBeneficiaryProvider);
                  Navigator.popUntil(context, (route) {
                    return route.settings.name == CustomRouter.corporateProfile;
                  });
                }, onResponseError: (e, s) {
                  if (e.message.contains('validation')) {
                    FormValidationHelper()
                        .resolveValidationError(formKey, e.message);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(e.message),
                      backgroundColor: AppColor.errorRed,
                    ));
                  }
                }).whenComplete(() => EasyLoadingHelper.dismiss());
              });
            },
            beneficiary: beneficiaryDetail,
            relationship: (context, ref, formKey) {
              return (AppRelationshipFormField(
                formKey: formKey,
                initialValue: beneficiaryDetail?.relationshipToSettlor,
              ));
            },
            title: 'Beneficiary');
}
