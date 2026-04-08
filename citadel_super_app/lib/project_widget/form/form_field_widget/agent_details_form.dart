import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/data/vo/agent_personal_details_vo.dart';
import 'package:citadel_super_app/extension/agent_profile_extension.dart';
import 'package:citadel_super_app/project_widget/form/app_date_picker_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_mobile_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/address_details_form.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/user_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AgentDetailsForm extends HookConsumerWidget {
  final GlobalKey<AppFormState> formKey;
  final AgentPersonalDetailsVo? agent;
  final List<DisabledField> disabledFields;

  const AgentDetailsForm({
    super.key,
    required this.formKey,
    this.agent,
    this.disabledFields = const [],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryCodeNotifier = ref.watch(countryCodeProvider.notifier);
    return Column(children: [
      AppTextFormField(
        formKey: formKey,
        label: 'Full Name',
        isEnabled: !(disabledFields.contains(DisabledField.name)),
        initialValue: agent.nameDisplay,
        fieldKey: AppFormFieldKey.nameKey,
        hint: 'eg. John Doe',
      ),
      AppTextFormField(
        formKey: formKey,
        label: 'User ID',
        isEnabled: !(disabledFields.contains(DisabledField.myKadNumber)),
        initialValue: agent.identityCardNumberDisplay,
        fieldKey: AppFormFieldKey.documentNumberKey,
        keyboardType: const TextInputType.numberWithOptions(signed: true),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        hint: 'eg. 123456789012',
      ),
      AppDatePickerFormField(
        formKey: formKey,
        label: 'Date of Birth',
        initialValue: agent.dobDisplay,
        isEnabled: !(disabledFields.contains(DisabledField.dob)),
      ),
      AddressDetailsForm(
        formKey: formKey,
        address: agent?.addressModel,
      ),
      AppMobileFormField(
        formKey: formKey,
        country: countryCodeNotifier
                .getObjectByDialCode(dialCode: agent?.mobileCountryCode ?? '')
                ?.countryName ??
            '',
        initialValue: agent?.mobileNumber,
      ),
      AppTextFormField(
        formKey: formKey,
        label: 'Email',
        initialValue: agent.emailDisplay,
        fieldKey: AppFormFieldKey.emailKey,
        isEnabled: !(disabledFields.contains(DisabledField.email)),
        keyboardType: TextInputType.emailAddress,
      ),
    ]);
  }
}
