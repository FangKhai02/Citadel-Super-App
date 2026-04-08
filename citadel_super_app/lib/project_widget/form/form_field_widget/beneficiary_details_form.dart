import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/data/vo/individual_beneficiary_vo.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_date_picker_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_gender_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_martial_status_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_mobile_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_residential_status_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/address_details_form.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BeneficiaryDetailsForm extends HookConsumerWidget {
  final GlobalKey<AppFormState> formKey;
  final IndividualBeneficiaryVo? beneficiary;

  const BeneficiaryDetailsForm(
      {super.key, required this.formKey, this.beneficiary});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryCodeNotifier = ref.watch(countryCodeProvider.notifier);
    return Column(children: [
      AppTextFormField(
        formKey: formKey,
        label: 'Full Name',
        initialValue: beneficiary?.fullName ?? '',
        fieldKey: AppFormFieldKey.nameKey,
      ),
      AppTextFormField(
        formKey: formKey,
        label: 'User ID',
        initialValue: beneficiary?.identityCardNumber ?? '',
        fieldKey: AppFormFieldKey.documentNumberKey,
        maxLength: 12,
      ),
      AppDatePickerFormField(
        formKey: formKey,
        label: 'Date of Birth',
        initialValue: beneficiary?.dob?.toDDMMYYY ?? '',
      ),
      AppGenderFormField(
        formKey: formKey,
        initialValue: beneficiary?.gender,
      ),
      Consumer(builder: (context, ref, child) {
        final countries = ref.read(countryCodeProvider).countryCodes ?? [];
        final options = countries
            .map((country) => AppDropDownItem(
                value: country.countryName ?? '',
                text: country.countryName ?? ''))
            .toList();

        return AppDropdown(
            formKey: formKey,
            label: 'Nationality',
            fieldKey: AppFormFieldKey.nationalityKey,
            hintText: 'Nationality',
            options: options);
      }),
      AddressDetailsForm(
        formKey: formKey,
        address: beneficiary?.addressObject,
      ),
      AppResidentialStatusFormField(
        formKey: formKey,
        initialValue: beneficiary?.residentialStatus,
      ),
      AppMartialStatusFormField(
        formKey: formKey,
        initialValue: beneficiary?.maritalStatus,
      ),
      AppMobileFormField(
        formKey: formKey,
        country: countryCodeNotifier
                .getObjectByDialCode(
                    dialCode: beneficiary?.mobileCountryCode ?? '')
                ?.countryName ??
            '',
        initialValue: beneficiary?.mobileNumber ?? '',
      ),
      AppTextFormField(
          initialValue: beneficiary?.email ?? '',
          formKey: formKey,
          label: 'Email',
          fieldKey: AppFormFieldKey.emailKey),
      gapHeight16,
    ]);
  }
}
