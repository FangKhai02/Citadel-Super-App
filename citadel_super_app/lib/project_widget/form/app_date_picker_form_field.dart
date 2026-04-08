import 'package:citadel_super_app/extension/date_time_extension.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:flutter/material.dart';
import '../../app_folder/app_color.dart';
import '../../app_folder/app_constant.dart';
import '../dialog/app_calender_date_picker_dialog.dart';
import 'app_text_form_field.dart';

class AppDatePickerFormField extends StatefulWidget {
  final String label;
  final GlobalKey<AppFormState>? formKey;
  final String initialValue;
  final TextEditingController? controller;
  final bool isEnabled;
  final String? fieldKey;

  const AppDatePickerFormField({
    super.key,
    this.formKey,
    this.initialValue = '',
    this.label = 'Date',
    this.controller,
    this.isEnabled = true,
    this.fieldKey,
  });

  @override
  AppDatePickerFormFieldState createState() => AppDatePickerFormFieldState();
}

class AppDatePickerFormFieldState extends State<AppDatePickerFormField> {
  late TextEditingController controller;
  @override
  void initState() {
    controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextFormField(
      formKey: widget.formKey,
      label: widget.label,
      controller: controller,
      fieldKey: widget.fieldKey ?? AppFormFieldKey.dobKey,
      isEnabled: widget.isEnabled,
      onTap: () async {
        final selectedDate = await showCalendarDatePickerDialog(context);
        if (selectedDate == null) {
          return null;
        }

        return selectedDate.tommddyyyy;
      },
      suffix: const Icon(
        Icons.calendar_today,
        color: AppColor.white,
      ),
      onChanged: (value) {
        widget.formKey?.currentState?.validateFormButton();
      },
    );
  }
}
