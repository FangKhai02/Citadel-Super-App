import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/data/vo/pep_declaration_options_vo.dart';
import 'package:citadel_super_app/project_widget/document/app_upload_document_widget.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PepDetailsWidget extends HookConsumerWidget {
  final GlobalKey<AppFormState> formKey;
  final String relationship;
  final PepDeclarationOptionsVo? pepDetail;

  const PepDetailsWidget(
      {super.key,
      required this.formKey,
      required this.relationship,
      this.pepDetail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppForm(
      child: Column(
        children: [
          if (relationship != 'SELF')
            AppTextFormField(
              label:
                  'Full Name of ${relationship == 'FAMILY' ? 'Immediate Family' : 'Close Associate'}',
              fieldKey: AppFormFieldKey.immediateFamilyNameKey,
              initialValue: pepDetail?.name ?? '',
            ),
          AppTextFormField(
              key: const Key('current position'),
              formKey: formKey,
              label: 'Current Postition / Designation',
              initialValue: pepDetail?.position ?? '',
              fieldKey: AppFormFieldKey.designationKey),
          AppTextFormField(
              key: const Key('Organisation'),
              formKey: formKey,
              label: 'Organisation / Entity',
              initialValue: pepDetail?.organization ?? '',
              fieldKey: AppFormFieldKey.organisationKey),
          gapHeight16,
          if (pepDetail?.supportingDocument != null) ...[
            AppUploadDocumentWidget(
              formKey: formKey,
              fieldKey: AppFormFieldKey.proofDocKey,
              initialFiles: [
                NetworkFile(url: pepDetail?.supportingDocument ?? '')
              ],
              label: 'Supporting Document',
            ),
          ] else ...[
            AppUploadDocumentWidget(
              formKey: formKey,
              fieldKey: AppFormFieldKey.proofDocKey,
              label: 'Supporting Document',
            ),
          ]
        ],
      ),
    );
  }
}
