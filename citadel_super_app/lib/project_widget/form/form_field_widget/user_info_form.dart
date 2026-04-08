import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/project_widget/form/app_date_picker_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/user_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../data/vo/client_personal_details_vo.dart';

class UserInfoForm extends StatefulHookWidget {
  final GlobalKey<AppFormState> formKey;
  final ClientPersonalDetailsVo? user;
  final List<DisabledField> disabledFields;

  const UserInfoForm({
    super.key,
    required this.formKey,
    this.user,
    this.disabledFields = const [],
  });

  @override
  UserInfoFormState createState() {
    return UserInfoFormState();
  }
}

class UserInfoFormState extends State<UserInfoForm> {
  late final TextEditingController nameController;
  late final TextEditingController documentNumberController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.user?.nameDisplay);
    documentNumberController =
        TextEditingController(text: widget.user?.identityCardNumberDisplay);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppTextFormField(
        formKey: widget.formKey,
        label: 'Full Name',
        controller: nameController,
        fieldKey: AppFormFieldKey.nameKey,
        hint: 'eg. John Doe',
      ),
      AppTextFormField(
        formKey: widget.formKey,
        label: 'User ID',
        isEnabled: !(widget.disabledFields.contains(DisabledField.myKadNumber)),
        controller: documentNumberController,
        fieldKey: AppFormFieldKey.documentNumberKey,
        keyboardType: const TextInputType.numberWithOptions(signed: true),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        hint: 'eg. 123456789012',
      ),
      AppDatePickerFormField(
        formKey: widget.formKey,
        label: 'Date of Birth',
        initialValue: widget.user.dobDisplay,
        isEnabled: !(widget.disabledFields.contains(DisabledField.dob)),
      )
    ]);
  }
}
