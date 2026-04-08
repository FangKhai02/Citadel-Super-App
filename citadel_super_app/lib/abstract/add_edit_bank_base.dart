import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/bank.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/document/app_upload_document_widget.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/bank_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class AddEditBankBase extends HookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();
  final Function(
          BuildContext context, WidgetRef ref, GlobalKey<AppFormState> formKey)
      onCreate;
  final Function(
          BuildContext context, WidgetRef ref, GlobalKey<AppFormState> formKey)
      onEdit;
  final Function(
          BuildContext context, WidgetRef ref, GlobalKey<AppFormState> formKey)
      onDelete;
  final Function(WidgetRef ref) onRefreshBank;

  bool get isEdit => bank != null;

  final CommonBankDetails? bank;

  AddEditBankBase(
      {super.key,
      required this.onCreate,
      this.bank,
      required this.onDelete,
      required this.onEdit,
      required this.onRefreshBank});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState!.validateFormButton();
      });
      return;
    }, []);
    return PopScope(
      onPopInvoked: (bool didPop) {
        if (didPop) {
          ScaffoldMessenger.of(context).clearSnackBars();
        }
      },
      child: CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        onRefresh: () async {
          onRefreshBank.call(ref);
        },
        appBar: CitadelAppBar(
          title: bank != null ? 'Edit your details' : 'Purchase Trust Product',
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AppForm(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bank != null ? 'Edit Bank' : 'New Bank Details',
                    style: AppTextStyle.header1),
                gapHeight32,
                BankDetailsForm(
                  formKey: formKey,
                  bank: bank,
                ),
                gapHeight16,
                AppUploadDocumentWidget(
                  formKey: formKey,
                  fieldKey: AppFormFieldKey.proofDocKey,
                  type: DocumentType.bankHeaderProof,
                  label: 'Bank Header Proof',
                  initialFiles: (bank?.bankAccountProofFile ?? '').isEmpty
                      ? []
                      : [NetworkFile(url: bank?.bankAccountProofFile ?? '')],
                ),
                gapHeight48,
                PrimaryButton(
                  key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                  onTap: () => isEdit
                      ? onEdit.call(context, ref, formKey)
                      : onCreate(context, ref, formKey),
                  title: isEdit ? 'Update' : 'Confirm',
                ),
                gapHeight16,
                if (bank != null)
                  AppTextButton(
                    title: 'Delete this bank',
                    textStyle:
                        AppTextStyle.action.copyWith(color: AppColor.errorRed),
                    onTap: () => onDelete(context, ref, formKey),
                  ),
                gapHeight16,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
