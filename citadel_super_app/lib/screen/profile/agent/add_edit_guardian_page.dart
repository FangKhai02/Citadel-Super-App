import 'package:citadel_super_app/abstract/beneficiary_form_base.dart';
import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/client_repository.dart';
import 'package:citadel_super_app/data/request/beneficiary_guardian_relationship_update_request_vo.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/data/state/microblink_result_state.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/data/vo/guardian_vo.dart';
import 'package:citadel_super_app/data/vo/individual_beneficiary_vo.dart';
import 'package:citadel_super_app/extension/microblink_result_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:flutter/material.dart';

class AddEditGuardianPage extends DetailsForm {
  final IndividualBeneficiaryVo? beneficiaryDetail;
  final int? beneficiaryID;
  final GuardianVo? cuurentGuardian;
  final String? relationshipToBen;
  final String? clientId;

  AddEditGuardianPage(
      {super.key,
      this.beneficiaryDetail,
      this.beneficiaryID,
      this.relationshipToBen,
      this.cuurentGuardian,
      this.clientId})
      : super(
            isEdit: cuurentGuardian != null ? true : false,
            isEnabled: beneficiaryDetail == null ? true : false,
            onCreate: (context, ref, formKey) async {
              await formKey.currentState!.validate(onSuccess: (formData) async {
                final docType =
                    ref.watch(microblinkResultProvider)?.docTypeConstant() ?? 'MYKAD';
                final req = ParameterHelper().createClientGuardianParam(
                    beneficiaryDetail != null
                        ? beneficiaryDetail.identityDocumentType
                        : docType,
                    formData,
                    beneficiaryID);

                ClientRepository clientRepository = ClientRepository();
                EasyLoadingHelper.show();
                await clientRepository.createGuardian(req, clientId).baseThen(
                  context,
                  onResponseSuccess: (resp) async {
                    Navigator.popUntil(context, (routes) {
                      if ([
                        CustomRouter.clientProfile,
                        CustomRouter.selectBeneficiary,
                        CustomRouter.selectSubstituteBeneficiary,
                      ].contains(routes.settings.name)) {
                        return true;
                      }

                      return false;
                    });
                    ref.invalidate(beneficiariesProvider);
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
                ClientRepository clientRepository = ClientRepository();

                EasyLoadingHelper.show();
                await clientRepository
                    .updateGuardianRelationship(
                        BeneficiaryGuardianRelationshipUpdateRequestVo(
                            beneficiaryId: beneficiaryID,
                            guardianId: cuurentGuardian?.id,
                            relationshipToBeneficiary: formData[
                                AppFormFieldKey.relationshipToBeneficiaryKey],
                            relationshipToGuardian: formData[
                                AppFormFieldKey.relationshipToBeneficiaryKey]))
                    .baseThen(context, onResponseSuccess: (resp) async {
                  await clientRepository
                      .editGuardian(
                          cuurentGuardian?.id,
                          ParameterHelper().editGuardianParam(formData),
                          clientId)
                      .baseThen(
                    context,
                    onResponseSuccess: (resp) {
                      Navigator.popUntil(context, (route) {
                        return route.settings.name ==
                            CustomRouter.clientProfile;
                      });
                      ref.invalidate(beneficiariesProvider);
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
              });
            },
            onDelete: cuurentGuardian != null
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

                          ClientRepository clientRepository =
                              ClientRepository();
                          EasyLoadingHelper.show();
                          await clientRepository
                              .deleteGuardian(cuurentGuardian.id, clientId)
                              .baseThen(context, onResponseSuccess: (data) {
                            ref.invalidate(beneficiariesProvider);

                            Navigator.popUntil(context, (route) {
                              return route.settings.name ==
                                  CustomRouter.clientProfile;
                            });
                          }).whenComplete(() => EasyLoadingHelper.dismiss());
                        });
                  }
                : (context, ref, formKey) {
                    return const SizedBox.shrink();
                  },
            guardian: cuurentGuardian,
            beneficiary: beneficiaryDetail,
            relationship: (context, ref, formKey) {
              final constants = ref.read(appProvider).constants ?? [];
              final relationshipList = constants.firstWhere((element) =>
                  element.category == AppConstantsKey.relationshipToSettlor);
              return AppDropdown(
                formKey: formKey,
                label: 'Relationship to Beneficiary',
                fieldKey: AppFormFieldKey.relationshipToBeneficiaryKey,
                textController:
                    TextEditingController(text: relationshipToBen ?? ''),
                hintText: 'Relationship to Beneficiary',
                options: relationshipList.list!
                    .map((e) => AppDropDownItem(value: e.key!, text: e.value!))
                    .toList(),
                onSelected: (item) {},
              );
            },
            title: 'Guardian');
}
