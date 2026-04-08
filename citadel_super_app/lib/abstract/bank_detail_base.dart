import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/bank.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/project_widget/app_info_text.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/secondary_button.dart';
import 'package:citadel_super_app/project_widget/document/app_document_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseBankDetail extends HookConsumerWidget {
  final CommonBankDetails bankAccount;
  final Function(BuildContext context, WidgetRef ref) onTap;
  final bool allowEdit;
  const BaseBankDetail(
      {super.key,
      required this.bankAccount,
      required this.onTap,
      this.allowEdit = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CitadelBackground(
      appBar: const CitadelAppBar(
        title: 'Bank Details',
      ),
      backgroundType: BackgroundType.darkToBright2,
      child: SizedBox(
        height: 1.sh,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppInfoText(
                        "Bank Name", bankAccount.bankName.defaultDisplay),
                    gapHeight16,
                    AppInfoText("Bank Account Number",
                        bankAccount.bankAccountNumber.defaultDisplay),
                    gapHeight16,
                    AppInfoText("Account Holder Name",
                        bankAccount.bankAccountHolderName.defaultDisplay),
                    gapHeight16,
                    AppInfoText("Bank Address",
                        bankAccount.getFullBankAddress().defaultDisplay),
                    gapHeight16,
                    AppInfoText(
                        "SWIFT Code", bankAccount.swiftCode.defaultDisplay),
                    gapHeight16,
                    Text(
                      'Bank Header Proof',
                      style: AppTextStyle.label,
                    ),
                    if (bankAccount.bankAccountProofFile != null) ...[
                      gapHeight8,
                      AppDocumentWidget(
                        file:
                            NetworkFile(url: bankAccount.bankAccountProofFile!),
                        onDelete: () {},
                        viewOnly: true,
                      ),
                    ],
                    gapHeight64,
                    Visibility(
                      visible: allowEdit,
                      child: SecondaryButton(
                          title: "Edit", onTap: () => onTap(context, ref)),
                    ),
                    gapHeight64,
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
