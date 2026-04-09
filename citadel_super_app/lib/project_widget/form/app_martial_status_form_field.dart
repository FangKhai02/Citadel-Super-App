import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app_folder/app_constant.dart';
import '../../data/state/app_state.dart';
import '../dropdown/app_dropdown.dart';
import 'app_form.dart';

class AppMartialStatusFormField extends HookConsumerWidget {
  final GlobalKey<AppFormState>? formKey;
  final String? initialValue;
  final bool enabled;
  final TextEditingController? textController;

  const AppMartialStatusFormField(
      {super.key,
      this.formKey,
      this.initialValue,
      this.enabled = true,
      this.textController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final constants = ref.read(appProvider).constants ?? [];
        final martialStatusConstants = constants.firstWhere(
            (element) => element.category == AppConstantsKey.martialStatus);
        final items = martialStatusConstants.list?.where(
                (e) => e.key == initialValue || e.value == initialValue) ??
            [];

        return AppDropdown(
          formKey: formKey,
          label: 'Marital Status',
          fieldKey: AppFormFieldKey.maritalStatusKey,
          hintText: 'Marital Status',
          enabled: enabled,
          initialValue: items.isEmpty ? '' : items.first.value ?? '',
          enableSearch: false,
          options: martialStatusConstants.list!
              .map((e) => AppDropDownItem(value: e.key!, text: e.value!))
              .toList(),
        );
      },
    );
  }
}
