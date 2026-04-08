import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/user_contact_form.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/user_info_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../data/vo/client_personal_details_vo.dart';

enum DisabledField {
  dob,
  name,
  email,
  myKadNumber;
}

class UserDetailsForm extends HookWidget {
  final GlobalKey<AppFormState> formKey;
  final ClientPersonalDetailsVo? user;
  final List<DisabledField> disabledFields;

  const UserDetailsForm({
    super.key,
    required this.formKey,
    this.user,
    this.disabledFields = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      UserInfoForm(
          formKey: formKey, user: user, disabledFields: disabledFields),
      UserContactForm(
          formKey: formKey, user: user, disabledFields: disabledFields),
    ]);
  }
}
