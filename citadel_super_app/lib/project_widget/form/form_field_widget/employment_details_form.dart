import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/data/vo/client_employment_details_vo.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/address_details_form.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';

class EmploymentDetailsForm extends HookWidget {
  final GlobalKey<AppFormState> formKey;
  final ClientEmploymentDetailsVo? clientEmploymentDetails;
  final String? fieldKey;

  const EmploymentDetailsForm({
    super.key,
    required this.formKey,
    this.fieldKey,
    this.clientEmploymentDetails,
  });

  @override
  Widget build(BuildContext context) {
    final industryTypeController = useTextEditingController();

    return Column(
      children: [
        AppTextFormField(
          label: 'Name of Employer',
          fieldKey: AppFormFieldKey.employerNameKey,
          formKey: formKey,
          initialValue: clientEmploymentDetails?.employerName ?? '',
        ),
        Consumer(builder: (context, ref, child) {
          final constants = ref.read(appProvider).constants ?? [];
          final industryTypeConstants = constants.firstWhere(
            (element) => element.category == AppConstantsKey.industryType,
          );
          final options = industryTypeConstants.list!
              .map((e) => AppDropDownItem(value: e.key!, text: e.value!))
              .toList();

          final initialOption = options.firstWhereOrNull(
            (element) =>
                element.value == (clientEmploymentDetails?.industryType ?? ''),
          );
          industryTypeController.text = initialOption?.text ?? '';

          return AppDropdown(
            formKey: formKey,
            label: 'Industry Type',
            fieldKey: AppFormFieldKey.industryTypeKey,
            hintText: 'Industry Type',
            textController: industryTypeController,
            options: options,
          );
        }),
        AppTextFormField(
          label: 'Job Title',
          fieldKey: AppFormFieldKey.jobTitleKey,
          formKey: formKey,
          initialValue: clientEmploymentDetails?.jobTitle ?? '',
        ),
        AddressDetailsForm(
          formKey: formKey,
          address: clientEmploymentDetails?.employerAddressObject,
          fieldKey: fieldKey,
        ),
      ],
    );
  }
}
