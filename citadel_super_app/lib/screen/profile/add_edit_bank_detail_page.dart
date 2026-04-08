import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/bank_repository.dart';
import 'package:citadel_super_app/data/repository/validation_repository.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/service/base_web_service.dart';
import 'package:flutter/material.dart';
import 'package:citadel_super_app/abstract/add_edit_bank_base.dart';
import 'package:citadel_super_app/data/model/bank.dart';

class AddEditBankDetailPage extends AddEditBankBase {
  final CommonBankDetails? bankDetails;
  final String? clientId;
  AddEditBankDetailPage({super.key, this.bankDetails, this.clientId})
      : super(
            onCreate: (context, ref, formKey) async {
              await formKey.currentState!.validate(onSuccess: (formData) async {
                ValidationRepository validationRepository =
                    ValidationRepository();
                EasyLoadingHelper.show();
                await validationRepository
                    .bankDetailsValidation(
                        ParameterHelper().bankDetailsValidationParam(formData))
                    .baseThen(
                  context,
                  onResponseSuccess: (resp) async {
                    BankRepository bankRepository = BankRepository();
                    await bankRepository
                        .createBank(
                            ParameterHelper().createBankDetailParam(formData),
                            clientId: clientId)
                        .baseThen(
                      context,
                      onResponseSuccess: (_) async {
                        Navigator.popUntil(context, (routes) {
                          if ([
                            CustomRouter.clientProfile,
                            CustomRouter.bankList,
                            CustomRouter.selectBankDetail,
                            CustomRouter.selectCorporateBank
                          ].contains(routes.settings.name)) {
                            return true;
                          }
                          return false;
                        });
                        // ignore: unused_result
                        await ref.refresh(bankProvider(clientId).future);
                      },
                      onResponseError: (e, s) {
                        if (e.message.contains('validation')) {
                          FormValidationHelper()
                              .resolveValidationError(formKey, e.message);
                        } else {
                          resolveErrorMessage(e, context);
                        }
                      },
                    );
                  },
                  onResponseError: (e, s) {
                    if (e.message.contains('validation')) {
                      FormValidationHelper()
                          .resolveValidationError(formKey, e.message);
                    } else {
                      resolveErrorMessage(e, context);
                    }
                  },
                ).whenComplete(() => EasyLoadingHelper.dismiss());
              });
            },
            onDelete: (context, ref, formKey) async {
              final confirmDelete = await showDialog(
                    context: context,
                    builder: (context) {
                      return AppDialog(
                        title:
                            'Are you sure you want to delete this bank details?',
                        positiveText: 'No',
                        positiveOnTap: () {
                          Navigator.pop(context);
                        },
                        isRounded: true,
                        negativeText: 'Yes, delete',
                        negativeOnTap: () => Navigator.pop(context, true),
                      );
                    },
                  ) as bool? ??
                  false;

              if (confirmDelete) {
                final BankRepository bankRepository = BankRepository();
                EasyLoadingHelper.show();
                await bankRepository
                    .deleteBank(bankDetails?.id, clientId: clientId)
                    .baseThen(getAppContext() ?? context,
                        onResponseSuccess: (_) {
                  Navigator.popUntil(context, (routes) {
                    if ([
                      CustomRouter.clientProfile,
                      CustomRouter.bankList,
                      CustomRouter.agentProfile
                    ].contains(routes.settings.name)) {
                      return true;
                    }

                    return false;
                  });
                  ref.invalidate(bankProvider);
                }).whenComplete(() => EasyLoadingHelper.dismiss());
              }
            },
            onEdit: (context, ref, formKey) async {
              await formKey.currentState!.validate(onSuccess: (formData) async {
                // BankDetailsRequestVo req =
                //     ParameterHelper().createBankDetailParam(formData);

                BankRepository bankRepository = BankRepository();
                EasyLoadingHelper.show();
                await bankRepository
                    .updateBank(bankDetails?.id,
                        ParameterHelper().createBankDetailParam(formData),
                        clientId: clientId)
                    .baseThen(context, onResponseSuccess: (_) {
                  ref.invalidate(bankProvider);
                  Navigator.popUntil(context, (routes) {
                    if ([CustomRouter.clientProfile, CustomRouter.bankList]
                        .contains(routes.settings.name)) {
                      return true;
                    }

                    return false;
                  });
                }, onResponseError: (e, s) {
                  if (e.message.contains('validation')) {
                    FormValidationHelper()
                        .resolveValidationError(formKey, e.message);
                  } else {
                    resolveErrorMessage(e, context);
                  }
                }).whenComplete(() => EasyLoadingHelper.dismiss());
              });
            },
            onRefreshBank: (ref) async {
              // ignore: unused_result
              await ref.refresh(bankProvider(null).future);
            },
            bank: bankDetails);
}

void resolveErrorMessage(ResponseErrorException e, BuildContext context) {
  if (e.message.equalsIgnoreCase('api.bank.account.exists')) {
    ScaffoldMessenger.of(getAppContext() ?? context).showSnackBar(
      const SnackBar(
        content: Text(
            'Bank account number already exist. Kindly enter a different bank account'),
        backgroundColor: AppColor.errorRed,
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: AppColor.errorRed, content: Text(e.message)));
  }
}
