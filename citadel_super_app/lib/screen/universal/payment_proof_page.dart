import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/state/product_state.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/button/secondary_button.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/project_widget/document/app_document_widget.dart';
import 'package:citadel_super_app/project_widget/document/app_upload_document_widget.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentProofPage extends StatefulHookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();
  final String productCode;
  final bool showSaveDraftButton;
  final List<dynamic>? proofList;
  final Function(List<dynamic>)? onConfirm;
  final Function(List<dynamic>)? onSaveDraft;

  PaymentProofPage(
      {super.key,
      required this.productCode,
      this.showSaveDraftButton = false,
      this.proofList = const [],
      required this.onConfirm,
      this.onSaveDraft});

  @override
  PaymentProofPageState createState() => PaymentProofPageState();
}

class PaymentProofPageState extends ConsumerState<PaymentProofPage> {
  late List<dynamic> _proofList;

  @override
  void initState() {
    super.initState();
    _proofList = List.from(widget.proofList ?? []);
  }

  @override
  Widget build(BuildContext context) {
    final productBankDetails =
        ref.watch(productBankDetailsFutureProvider(widget.productCode));
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.formKey.currentState!.validateFormButton();
      });
      return;
    }, []);

    return AppForm(
      key: widget.formKey,
      child: CitadelBackground(
          backgroundType: BackgroundType.darkToBright2,
          appBar: const CitadelAppBar(title: 'Payment'),
          bottomNavigationBar: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimaryButton(
                    title: 'Confirm',
                    onTap: () async {
                      await widget.formKey.currentState!.validate(
                          onSuccess: (formData) async {
                        _proofList =
                            formData[AppFormFieldKey.proofDocKey] ?? [];
                        if (widget.onConfirm != null) {
                          widget.onConfirm!(_proofList);
                        } else {
                          Navigator.pop(context);
                        }
                      });
                    }),
                if (widget.showSaveDraftButton)
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: SecondaryButton(
                      title: 'Save draft & upload later',
                      onTap: () async {
                        if (widget.onSaveDraft != null) {
                          await widget.onSaveDraft!(_proofList);
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  )
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment via Manual Transfer',
                  style: AppTextStyle.header1,
                ),
                gapHeight32,
                Text(
                  'Bank Transfer to',
                  style: AppTextStyle.header3,
                ),
                gapHeight8,
                AppInfoContainer(
                    child: productBankDetails.maybeWhen(data: (data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.bankName ?? '-',
                        style: AppTextStyle.header3,
                      ),
                      gapHeight8,
                      Text(data.bankAccountName ?? '-',
                          style: AppTextStyle.description),
                      gapHeight8,
                      Text(
                        data.bankAccountNumber ?? '-',
                        style: AppTextStyle.description,
                      ),
                    ],
                  );
                }, orElse: () {
                  return const Center(child: CircularProgressIndicator());
                })),
                gapHeight32,
                Text(
                  'Upload the payment receipt(s) as a proof of payment',
                  style: AppTextStyle.description,
                ),
                gapHeight32,
                AppUploadDocumentWidget(
                  formKey: widget.formKey,
                  type: DocumentType.paymentReceipt,
                  fieldKey: AppFormFieldKey.proofDocKey,
                  label: 'Payment Receipt',
                  maxFile: 10,
                ),
                gapHeight32,
                if (_proofList.isNotEmpty) _submittedDoc(),
              ],
            ),
          )),
    );
  }

  Widget _submittedDoc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Receipt (up to 10 files)',
          style: AppTextStyle.label,
        ),
        gapHeight8,
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _proofList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: AppDocumentWidget(
                file: _proofList[index],
                onDelete: () {
                  setState(() {
                    _proofList.removeAt(index);
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
