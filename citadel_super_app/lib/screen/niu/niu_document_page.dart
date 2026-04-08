import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/model/document.dart';
import 'package:citadel_super_app/data/state/niu_application_state.dart';
import 'package:citadel_super_app/data/vo/niu_apply_document_vo.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/document/app_upload_document_widget.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NiuDocumentPage extends HookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();

  NiuDocumentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerAsPersonal =
        ref.read(niuApplicationProvider).applicationType == 'PERSONAL';
    final niuApplicationNotifier = ref.watch(niuApplicationProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        formKey.currentState?.validateFormButton();
      });
      return;
    }, []);

    Widget descriptionText() {
      return registerAsPersonal
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. MyKad',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '2. Sales & Purchase Agreement',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '3. Photocopy of Land Title/s',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '4. Latest Quit Rent and Assessment',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '5. Latest 6 months Bank Statement',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '6. Existing Fire Insurance',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '7. Valuation Report (if any)',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '8. Consent of Credit Checking',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '9. Other relevant documents',
                  style: AppTextStyle.description,
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1. Director's MyKad",
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '2. Certified true copy Memorandum and Articles of Association (M & A)',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  "3. CTC copy of Company Registration (Section 15, 17 (Form 9), 28 (Form 13), 46 (Form 44), 58 (Form 49), 68 (Annual Return), 51 & 78 (Form 24) and 105 (Form 32A)) (whichever applicable)",
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '4. Sales and Purchase Agreement',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  "5. Photocopy of Land Title/s",
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '6. Latest Quit Rent and Assessment',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '7. Latest 6 months Bank Statement',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '8. Existing Fire Insurance',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '9. Valuation Report (if any)',
                  style: AppTextStyle.description,
                ),
                Text(
                  '10. Latest 3 Years Audited Accounts/ Latest Management Accounts',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '11. Projected Cashflow',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '12. Company Profile',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '13. Collection Trend – for new contracts received from the same Contract Awarder',
                  style: AppTextStyle.description,
                ),
                gapHeight8,
                Text(
                  '14. Other relevant documents – Contracts Awarded, Creditors/ Debtors Aging etc',
                  style: AppTextStyle.description,
                ),
              ],
            );
    }

    return CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: const CitadelAppBar(title: 'NIU Application'),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: AppForm(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Documents Required', style: AppTextStyle.header1),
                gapHeight32,
                descriptionText(),
                gapHeight32,
                AppUploadDocumentWidget(
                  formKey: formKey,
                  fieldKey: AppFormFieldKey.proofDocKey,
                  label: '',
                  minFile: 2,
                  maxFile: registerAsPersonal ? 9 : 14,
                ),
                gapHeight48,
                PrimaryButton(
                  key: const Key(AppFormFieldKey.primaryButtonValidateKey),
                  title: 'Confirm',
                  onTap: () async {
                    await formKey.currentState?.validate(onSuccess: (formData) {
                      final docList = (formData[AppFormFieldKey.proofDocKey]
                          as List<Document>);

                      final companyProofList = docList
                          .map((doc) => NiuApplyDocumentVo(
                                filename: doc.fileName,
                                signature: doc.base64EncodeStr,
                              ))
                          .toList();

                      niuApplicationNotifier.setDocuments(companyProofList);

                      Navigator.pushNamed(context, CustomRouter.niuSign);
                    });
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
