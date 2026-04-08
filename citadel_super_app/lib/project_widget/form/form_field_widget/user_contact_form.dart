import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_mobile_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/address_details_form.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/user_details_form.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/vo/client_personal_details_vo.dart';

class UserContactForm extends HookConsumerWidget {
  final GlobalKey<AppFormState> formKey;
  final ClientPersonalDetailsVo? user;
  final List<DisabledField> disabledFields;

  const UserContactForm(
      {super.key,
      required this.formKey,
      this.user,
      this.disabledFields = const []});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryCodeNotifier = ref.watch(countryCodeProvider.notifier);

    return Column(children: [
      AddressDetailsForm(
        formKey: formKey,
        address: user?.addressModel,
      ),
      AppMobileFormField(
        formKey: formKey,
        country: countryCodeNotifier
                .getObjectByDialCode(dialCode: user?.mobileCountryCode ?? '')
                ?.countryName ??
            '',
        initialValue: user?.mobileNumber ?? '',
      ),
      AppTextFormField(
        formKey: formKey,
        label: 'Email',
        initialValue: user?.email ?? '',
        isEnabled: !(disabledFields.contains(DisabledField.email)),
        fieldKey: AppFormFieldKey.emailKey,
        keyboardType: TextInputType.emailAddress,
      ),
    ]);
  }
}
