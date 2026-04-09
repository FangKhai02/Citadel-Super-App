import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app_folder/app_constant.dart';
import '../../data/state/app_state.dart';
import 'app_form.dart';

class AppResidentialStatusFormField extends StatelessWidget {
  final GlobalKey<AppFormState>? formKey;
  final String? initialValue;
  final bool enabled;
  final TextEditingController? textController;

  const AppResidentialStatusFormField({
    super.key,
    this.formKey,
    this.initialValue,
    this.enabled = true,
    this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final constants = ref.read(appProvider).constants ?? [];
        final residentialStatusConstants = constants.firstWhere(
            (element) => element.category == AppConstantsKey.residentialStatus);
        // final items = residentialStatusConstants.list?.where(
        //         (e) => e.key == initialValue || e.value == initialValue) ??
        //     [];

        return AppDropdown(
            formKey: formKey,
            label: 'Residential Status',
            fieldKey: AppFormFieldKey.residentialStatusKey,
            hintText: 'Residential Status',
            enabled: enabled,
            initialValue: initialValue ?? '',
            textController: textController,
            enableSearch: false,
            // initialSelectedItem: items.isEmpty
            //     ? null
            //     : AppDropDownItem(
            //         value: items.first.key ?? '',
            //         text: items.first.value ?? ''),
            options: residentialStatusConstants.list!
                .map((e) => AppDropDownItem(value: e.key!, text: e.value!))
                .toList());
      },
    );
  }
}
