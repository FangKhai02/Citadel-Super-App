import 'package:citadel_super_app/abstract/add_edit_bank_base.dart';
import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/bank.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/service/base_web_service.dart';

import 'package:flutter/material.dart';

class CorporateAddEditBankDetailPage extends AddEditBankBase {
  final CommonBankDetails? bankDetails;
  final String? corporateClientId;

  CorporateAddEditBankDetailPage(
      {super.key, this.bankDetails, this.corporateClientId})
      : super(
            onCreate: (context, ref, formKey) async {
              await formKey.currentState?.validate(onSuccess: (formData) async {
                CorporateRepository corporateRepository = CorporateRepository();
                EasyLoadingHelper.show();
                await corporateRepository
                    .createCorporateBank(
                        ParameterHelper().createCorporateBankParam(formData),
                        corporateClientId)
                    .baseThen(context, onResponseSuccess: (_) async {
                  // ignore: unused_result
                  await ref
                      .refresh(corporateBankProvider(corporateClientId).future);
                  Navigator.popUntil(getAppContext() ?? context, (route) {
                    if ([
                      CustomRouter.corporateProfile,
                      CustomRouter.selectCorporateBank,
                    ].contains(route.settings.name)) {
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
                CorporateRepository corporateRepository = CorporateRepository();
                EasyLoadingHelper.show();
                await corporateRepository
                    .deleteCorporateBank(bankDetails?.id, corporateClientId)
                    .baseThen(getAppContext() ?? context,
                        onResponseSuccess: (_) {
                  ref.invalidate(corporateBankProvider);
                  Navigator.popUntil(context, (route) {
                    return route.settings.name == CustomRouter.corporateProfile;
                  });
                }).whenComplete(() => EasyLoadingHelper.dismiss());
              }
            },
            onEdit: (context, ref, formKey) async {
              await formKey.currentState!.validate(onSuccess: (formData) async {
                CorporateRepository corporateRepository = CorporateRepository();
                EasyLoadingHelper.show();
                await corporateRepository
                    .editCorporateBank(
                        ParameterHelper()
                            .editCorporateBankParam(bankDetails?.id, formData),
                        corporateClientId)
                    .baseThen(
                  context,
                  onResponseSuccess: (_) {
                    ref.invalidate(corporateBankProvider);
                    Navigator.popUntil(context, (route) {
                      return route.settings.name ==
                          CustomRouter.corporateProfile;
                    });
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
            onRefreshBank: (ref) async {
              // ignore: unused_result
              await ref
                  .refresh(corporateBankProvider(corporateClientId).future);
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
