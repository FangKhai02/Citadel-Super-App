import 'package:citadel_super_app/abstract/beneficiary_form_base.dart';
import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/client_repository.dart';
import 'package:citadel_super_app/data/state/microblink_result_state.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/data/vo/individual_beneficiary_vo.dart';
import 'package:citadel_super_app/extension/microblink_result_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/project_widget/form/app_relationship_form_field.dart';
import 'package:citadel_super_app/screen/universal/select_guardian_page.dart';
import 'package:flutter/material.dart';

class AddEditBeneficiaryPage extends DetailsForm {
  final IndividualBeneficiaryVo? beneficiaryDetail;
  final bool fromProfile;
  final String? clientId;

  AddEditBeneficiaryPage(
      {super.key,
      this.beneficiaryDetail,
      this.fromProfile = false,
      this.clientId})
      : super(
            onCreate: (context, ref, formKey) async {
              await formKey.currentState!.validate(onSuccess: (formData) async {
                final docType =
                    ref.watch(microblinkResultProvider)?.docTypeConstant() ?? 'MYKAD';
                final req = ParameterHelper()
                    .createClientBeneficiaryParam(docType, formData);
                ClientRepository clientRepository = ClientRepository();
                EasyLoadingHelper.show();
                await clientRepository
                    .createBeneficiary(req, clientId: clientId)
                    .baseThen(
                  context,
                  onResponseSuccess: (data) {
                    ref.invalidate(microblinkResultProvider);

                    if (data.isUnderAge == true) {
                      Navigator.pushReplacementNamed(
                        context,
                        CustomRouter.selectGuardian,
                        arguments: SelectGuardianPage(
                          beneficiaryId: data.individualBeneficiaryId ?? 0,
                          fromProfile: fromProfile,
                          clientId: clientId,
                        ),
                      );
                    } else {
                      Navigator.popUntil(context, (routes) {
                        if ([
                          CustomRouter.clientProfile,
                          CustomRouter.selectBeneficiary,
                          CustomRouter.selectSubstituteBeneficiary,
                          CustomRouter.beneficiaryList,
                        ].contains(routes.settings.name)) {
                          return true;
                        }
                        return false;
                      });
                    }
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
            onDelete: beneficiaryDetail != null
                ? (context, ref, formKey) {
                    return (AppTextButton(
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

                        ClientRepository clientRepository = ClientRepository();
                        EasyLoadingHelper.show();
                        await clientRepository
                            .deleteBeneficiary(
                                beneficiaryDetail.individualBeneficiaryId,
                                clientId: clientId)
                            .baseThen(context, onResponseSuccess: (data) {
                          ref.invalidate(beneficiariesProvider);
                          Navigator.popUntil(context, (routes) {
                            if ([
                              CustomRouter.clientProfile,
                              CustomRouter.selectBeneficiary,
                              CustomRouter.beneficiaryList,
                            ].contains(routes.settings.name)) {
                              return true;
                            }

                            return false;
                          });
                        }).whenComplete(() => EasyLoadingHelper.dismiss());
                      },
                    ));
                  }
                : (context, ref, formKey) {
                    return const SizedBox.shrink();
                  },
            onEdit: (context, ref, formKey) async {
              await formKey.currentState!.validate(onSuccess: (formData) async {
                final req = ParameterHelper()
                    .updateClientBeneficiaryParam(formData, beneficiaryDetail);

                ClientRepository clientRepository = ClientRepository();
                EasyLoadingHelper.show();
                await clientRepository
                    .updateBeneficiary(
                        req, beneficiaryDetail?.individualBeneficiaryId,
                        clientId: clientId)
                    .baseThen(context, onResponseSuccess: (data) {
                  Navigator.popUntil(context, (routes) {
                    if ([
                      CustomRouter.clientProfile,
                      CustomRouter.selectBeneficiary,
                      CustomRouter.beneficiaryList
                    ].contains(routes.settings.name)) {
                      return true;
                    }

                    return false;
                  });

                  ref.invalidate(beneficiariesProvider);
                }, onResponseError: (e, s) {
                  if (e.message.contains('validation')) {
                    FormValidationHelper()
                        .resolveValidationError(formKey, e.message);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: AppColor.errorRed,
                        content: Text(e.message)));
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
