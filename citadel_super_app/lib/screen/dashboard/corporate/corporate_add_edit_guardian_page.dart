import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/state/microblink_result_state.dart';
import 'package:citadel_super_app/data/vo/corporate_beneficiary_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_guardian_vo.dart';
import 'package:citadel_super_app/extension/microblink_result_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/abstract/corporate_beneficiary_form_base.dart';
import 'package:flutter/material.dart';

class CorporateAddEditGuardianPage extends CorporateDetailsForm {
  final CorporateBeneficiaryVo? beneficiaryDetail;
  final int? beneficiaryID;
  final CorporateGuardianVo? currentGuardian;
  final String? relationshipToBen;
  final String? corporateClientId;

  CorporateAddEditGuardianPage({
    super.key,
    this.beneficiaryDetail,
    this.beneficiaryID,
    this.currentGuardian,
    this.relationshipToBen,
    this.corporateClientId,
  }) : super(
            isEdit: currentGuardian != null ? true : false,
            isEnabled: beneficiaryDetail == null ? true : false,
            onCreate: (context, ref, formKey) async {
              await formKey.currentState!.validate(onSuccess: (formData) async {
                CorporateRepository corporateRepository = CorporateRepository();

                final docType =
                    ref.read(microblinkResultProvider)?.docTypeConstant() ?? 'MYKAD';
                EasyLoadingHelper.show();
                await corporateRepository
                    .createCorporateGuardian(
                        ParameterHelper().createCorporateGuardianParam(
                            beneficiaryID,
                            formData,
                            beneficiaryDetail != null
                                ? beneficiaryDetail.identityDocumentType
                                : docType),
                        corporateClientId)
                    .baseThen(
                  context,
                  onResponseSuccess: (resp) {
                    ref.invalidate(corporateBeneficiaryProvider);
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
                  },
                  onResponseError: (e, s) {
                    if (e.message.contains('validation')) {
                      FormValidationHelper()
                          .resolveValidationError(formKey, e.message);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: AppColor.errorRed,
                          content: Text(e.message)));
                    }
                  },
                ).whenComplete(() => EasyLoadingHelper.dismiss());
              });
            },
            onEdit: (context, ref, formKey) async {
              await formKey.currentState!.validate(onSuccess: (formData) async {
                CorporateRepository corporateRepository = CorporateRepository();

                EasyLoadingHelper.show();
                await corporateRepository
                    .editCorporateBeneficiaryRelationshipToGuardian(
                        formData[AppFormFieldKey.relationshipToBeneficiaryKey],
                        beneficiaryID!)
                    .baseThen(
                  context,
                  onResponseSuccess: (_) async {
                    await corporateRepository
                        .editCorporateGuardian(
                            ParameterHelper()
                                .editCorporateGuardianParam(formData),
                            currentGuardian?.corporateGuardianId,
                            corporateClientId)
                        .baseThen(
                      context,
                      onResponseSuccess: (resp) {
                        ref.invalidate(corporateBeneficiaryProvider);
                        Navigator.popUntil(context, (routes) {
                          if ([
                            CustomRouter.corporateProfile,
                            CustomRouter.selectCorporateBeneficiary,
                          ].contains(routes.settings.name)) {
                            return true;
                          }
                          return false;
                        });
                      },
                      onResponseError: (e, s) {
                        if (e.message.contains('validation')) {
                          FormValidationHelper()
                              .resolveValidationError(formKey, e.message);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: AppColor.errorRed,
                              content: Text(e.message)));
                        }
                      },
                    );
                  },
                  onResponseError: (e, s) {
                    if (e.message.contains('validation')) {
                      FormValidationHelper()
                          .resolveValidationError(formKey, e.message);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: AppColor.errorRed,
                          content: Text(e.message)));
                    }
                  },
                ).whenComplete(() => EasyLoadingHelper.dismiss());
              });
            },
            onDelete: currentGuardian != null
                ? (context, ref, formKey) {
                    return AppTextButton(
                        title: 'Delete this guardian',
                        textStyle: AppTextStyle.action
                            .copyWith(color: AppColor.errorRed),
                        onTap: () async {
                          final isConfirm = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AppDialog(
                                    title:
                                        'Are you sure you want to delete this guardian?',
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
                              .deleteCorporateGuardian(
                                  currentGuardian.corporateGuardianId,
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
            beneficiary: beneficiaryDetail,
            guardian: currentGuardian,
            relationship: (context, ref, formKey) {
              final constants = ref.read(appProvider).constants ?? [];
              final relationshipList = constants.firstWhere((element) =>
                  element.category == AppConstantsKey.relationshipToSettlor);
              return AppDropdown(
                textController:
                    TextEditingController(text: relationshipToBen ?? ''),
                formKey: formKey,
                label: 'Relationship to Beneficiary',
                fieldKey: AppFormFieldKey.relationshipToBeneficiaryKey,
                hintText: 'Relationship to Beneficiary',
                options: relationshipList.list!
                    .map((e) => AppDropDownItem(value: e.key!, text: e.value!))
                    .toList(),
                onSelected: (item) {},
              );
            },
            title: 'Guardian');
}
