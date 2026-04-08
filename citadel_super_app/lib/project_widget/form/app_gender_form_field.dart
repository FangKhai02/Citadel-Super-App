import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app_folder/app_constant.dart';
import '../../data/state/app_state.dart';
import 'app_form.dart';

class AppGenderFormField extends StatelessWidget {
  final GlobalKey<AppFormState>? formKey;
  final String? initialValue;

  const AppGenderFormField({
    super.key,
    this.formKey,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final constants = ref.read(appProvider).constants ?? [];
        final residentialStatusConstants = constants.firstWhere(
            (element) => element.category == AppConstantsKey.gender);
        final items = residentialStatusConstants.list?.where(
                (e) => e.key == initialValue || e.value == initialValue) ??
            [];

        return AppDropdown(
            formKey: formKey,
            label: 'Gender',
            fieldKey: AppFormFieldKey.genderKey,
            hintText: 'Gender',
            initialValue: items.isEmpty ? '' : items.first.value ?? '',
            options: residentialStatusConstants.list!
                .map((e) => AppDropDownItem(value: e.key!, text: e.value!))
                .toList());
      },
    );
  }
}
