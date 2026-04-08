import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/data/model/niu_apply_signee.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/project_widget/form/app_date_picker_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/base_form_field.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/user_details_form.dart';
import 'package:citadel_super_app/screen/universal/component/signature_container.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignAuthoriesWidget extends BaseFormField {
  final GlobalKey<AppFormState> formKey;
  final List<DisabledField> disabledFields;
  final int index;

  const SignAuthoriesWidget({
    super.key,
    required this.formKey,
    required this.index,
    this.disabledFields = const [],
    required super.label,
    required super.fieldKey,
  });

  @override
  SignWidgetState createState() => SignWidgetState();
}

class SignWidgetState extends BaseFormFieldState<SignAuthoriesWidget> {
  late final TextEditingController nameController;
  late final TextEditingController documentNumberController;
  late final TextEditingController dateController;
  late SignatureController signatureController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    documentNumberController = TextEditingController();
    dateController = TextEditingController();
    signatureController = SignatureController(penColor: AppColor.labelBlack);
  }

  @override
  void dispose() {
    nameController.dispose();
    documentNumberController.dispose();
    dateController.dispose();
    signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SignatureContainer(
          formKey: widget.formKey,
          signatureController: signatureController,
          label: widget.label,
        ),
        gapHeight16,
        AppTextFormField(
          formKey: widget.formKey,
          label: '${widget.label} Name',
          controller: nameController,
          fieldKey: AppFormFieldKey.nameKey,
          hint: 'eg. John Doe',
        ),
        gapHeight16,
        AppTextFormField(
          formKey: widget.formKey,
          label: 'User ID',
          controller: documentNumberController,
          fieldKey: AppFormFieldKey.documentNumberKey,
          hint: 'eg. 123456789012',
        ),
        AppDatePickerFormField(
          formKey: widget.formKey,
          label: 'Date',
          controller: dateController,
          fieldKey: AppFormFieldKey.signeeDateKey,
        )
      ],
    );
  }

  @override
  NiuApplySignee? onSaved() {
    if (signatureController.isEmpty) return null;

    final signatureBytes = signatureController.toPngBytes();

    return NiuApplySignee(
      fullName: nameController.text,
      nric: documentNumberController.text,
      signatureBytes: signatureBytes,
      signedDate: dateController.text.getEpochTime(),
    );
  }

  @override
  bool validate() {
    return nameController.text.isNotEmpty &&
        documentNumberController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        signatureController.value.isNotEmpty;
  }
}
