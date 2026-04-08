import 'dart:convert';

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/state/corporate_shareholder_state.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/data/state/microblink_result_state.dart';
import 'package:citadel_super_app/data/vo/corporate_shareholder_vo.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/extension/microblink_result_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/project_widget/form/app_document_image_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_mobile_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/address_details_form.dart';
import 'package:citadel_super_app/screen/company/share_holder_pep_declaration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:citadel_super_app/extension/corporate_extension.dart';

class ShareHolderPage extends HookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();
  final CorporateShareholderVo? shareholder;
  final bool allowEditPercentage;

  ShareHolderPage({
    super.key,
    this.shareholder,
    this.allowEditPercentage = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final microblinkResultState = ref.watch(microblinkResultProvider);
    final countryCodeNotifier = ref.watch(countryCodeProvider.notifier);
    // final corporateRefState = ref.watch(corporateRefProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState!.validateFormButton();
      });
      return;
    }, []);

    return PopScope(
      canPop: false,
      child: CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: CitadelAppBar(
            title: 'Identity Verification',
            onTap: () {
              Navigator.popUntil(context, (routes) {
                if ([
                  CustomRouter.corporateProfile,
                  CustomRouter.shareHolderDetails,
                ].contains(routes.settings.name)) {
                  return true;
                }
                return false;
              });
            }),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AppForm(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Share Holder Details',
                  style: AppTextStyle.header1,
                ),
                AppTextFormField(
                  label: 'Share Holder Name',
                  fieldKey: AppFormFieldKey.nameKey,
                  controller: TextEditingController(
                      text: shareholder?.name ??
                          microblinkResultState
                              .getResultAsClientPersonalDetails.nameDisplay),
                ),
                AddressDetailsForm(
                  formKey: formKey,
                  address: shareholder != null
                      ? shareholder?.shareholderAddressObject
                      : microblinkResultState
                          .getResultAsClientPersonalDetails.addressModel,
                ),
                AppTextFormField(
                  formKey: formKey,
                  label: 'Share Holder Share Percentage',
                  fieldKey: AppFormFieldKey.percentageKey,
                  isEnabled: allowEditPercentage,
                  keyboardType:
                      const TextInputType.numberWithOptions(signed: true),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  initialValue:
                      shareholder?.percentageOfShareholdings.toString() ?? '',
                  validator: (value) {
                    if ((double.tryParse(value) ?? 0.0) <= 0.0 ||
                        (double.tryParse(value) ?? 0.0) > 100.0) {
                      return 'Percentage must be between 1 and 100';
                    }
                    return '';
                  },
                ),
                AppMobileFormField(
                    formKey: formKey,
                    label: 'Primary Contact Mobile Number',
                    country: countryCodeNotifier
                            .getObjectByDialCode(
                                dialCode: shareholder.mobileCountryCodeDisplay)
                            ?.countryName ??
                        '',
                    initialValue: shareholder.mobileNumberDisplay),
                AppTextFormField(
                  formKey: formKey,
                  label: 'Primary Contact Email',
                  fieldKey: AppFormFieldKey.emailKey,
                  keyboardType: TextInputType.emailAddress,
                  initialValue: shareholder.emailDisplay,
                ),
                if (shareholder == null) ...[
                  gapHeight32,
                  AppDocumentImageFormField(
                    documentType: microblinkResultState?.docType ?? 'MYKAD',
                    frontImage: microblinkResultState?.frontImage?.isNotEmpty == true
                        ? base64Decode(microblinkResultState!.frontImage!)
                        : null,
                    backImage: microblinkResultState?.backImage?.isNotEmpty == true
                        ? base64Decode(microblinkResultState!.backImage!)
                        : null,
                    onRescanComplete: (result) {
                      formKey.currentState!.validateFormButton();
                    },
                  ),
                ],
                gapHeight48,
                PrimaryButton(
                  key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                  title: shareholder == null ? 'Add' : 'Confirm',
                  onTap: () async => shareholder == null
                      ? await create(context, ref)
                      : await edit(context, ref),
                ),
                gapHeight16,
                if (shareholder != null)
                  AppTextButton(
                    title: 'Delete this shareholder',
                    textStyle:
                        AppTextStyle.action.copyWith(color: AppColor.errorRed),
                    onTap: () async =>
                        await delete(context, ref, shareholder!.id!),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> create(
    BuildContext context,
    WidgetRef ref,
  ) async {
    FocusScope.of(context).unfocus();
    await formKey.currentState?.validate(onSuccess: (formData) {
      final error = validatePercentage(formData[AppFormFieldKey.percentageKey]);

      final checkEmail = validateEmail(formData[AppFormFieldKey.emailKey]);

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: AppColor.errorRed, content: Text(error)));
        return;
      }

      if (checkEmail != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColor.errorRed, content: Text(checkEmail)));
        return;
      }

      final microblinkResultState = ref.watch(microblinkResultProvider);

      final corporateShareholderNotifier =
          ref.read(corporateShareholderProvider.notifier);

      corporateShareholderNotifier.setCorporateShareholder(
          microblinkResultState?.docTypeConstant() ?? 'MYKAD',
          formData,
          microblinkResultState
              ?.getResultAsClientPersonalDetails.identityCardNumberDisplay ?? '');
      Navigator.pushNamed(context, CustomRouter.shareHolderPepDeclaration,
          arguments: ShareHolderPepDeclarationPage());
    });
  }

  Future<void> edit(
    BuildContext context,
    WidgetRef ref,
  ) async {
    FocusScope.of(context).unfocus();
    await formKey.currentState?.validate(onSuccess: (formData) async {
      final error = validatePercentage(formData[AppFormFieldKey.percentageKey]);

      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: AppColor.errorRed, content: Text(error)));
        return;
      }

      final corporateRef = ref.read(corporateRefProvider);

      final req = ParameterHelper()
          .editCorporateShareholderParam(shareholder!.id!, formData);
      CorporateRepository corporateRepository = CorporateRepository();
      EasyLoadingHelper.show();
      await corporateRepository
          .editShareholder(req, corporateRef!)
          .baseThen(context, onResponseSuccess: (resp) {
        ref.invalidate(corporateShareholderProvider);
        ref.invalidate(shareholdersProvider);
        // ignore: unused_result
        ref.refresh(corporateProfileProvider(null).future);

        Navigator.pop(context);
      }, onResponseError: (e, s) {
        if (e.message.contains('validation')) {
          FormValidationHelper().resolveValidationError(formKey, e.message);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColor.errorRed, content: Text(e.message)));
        }
      }).whenComplete(() => EasyLoadingHelper.dismiss());
    });
  }

  Future<void> delete(BuildContext context, WidgetRef ref, int id) async {
    final confirmDelete = await showDialog(
          context: context,
          builder: (context) {
            return AppDialog(
              title: 'Are you sure you want to delete this shareholder?',
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

    if (confirmDelete) {
      final corporateRef = ref.read(corporateRefProvider);
      CorporateRepository corporateRepository = CorporateRepository();
      EasyLoadingHelper.show();
      await corporateRepository
          .deleteShareholder(shareholder!.id!, corporateRef ?? '')
          .baseThen(getAppContext() ?? context, onResponseSuccess: (_) {
        // ignore: unused_result
        ref.refresh(shareholdersProvider.future);
        // ignore: unused_result
        ref.refresh(corporateProfileProvider(null).future);
        Navigator.popUntil(context, (routes) {
          if ([
            CustomRouter.corporateProfile,
            CustomRouter.shareHolderDetails,
          ].contains(routes.settings.name)) {
            return true;
          }
          return false;
        });
      }, onResponseError: (e, s) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: AppColor.errorRed, content: Text(e.message)));
      }).whenComplete(() => EasyLoadingHelper.dismiss());
    }
  }
}
