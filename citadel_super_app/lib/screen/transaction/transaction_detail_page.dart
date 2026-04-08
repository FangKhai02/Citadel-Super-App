import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/vo/transaction_vo.dart';
import 'package:citadel_super_app/extension/transaction_extension.dart';
import 'package:citadel_super_app/project_widget/app_info_text.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionDetailPage extends HookWidget {
  final TransactionVo transaction;

  const TransactionDetailPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return CitadelBackground(
        backgroundType: BackgroundType.blueToOrange2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CitadelAppBar(
              title: 'Transactions Details',
            ),
            gapHeight16,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transaction.titleDisplay, style: AppTextStyle.header2),
                  gapHeight16,
                  Text(
                    transaction.amountDisplay,
                    style: AppTextStyle.bigNumber.copyWith(
                      color: transaction.getTransactionColor,
                    ),
                  ),
                  gapHeight48,
                  AppInfoContainer(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppInfoText(
                          'Trust Product Name', transaction.productNameDisplay),
                      gapHeight24,
                      AppInfoText('Agreement Number',
                          transaction.agreementNumberDisplay),
                      gapHeight24,
                      if (transaction.trusteeFee != null &&
                          transaction.trusteeFee! > 0) ...[
                        AppInfoText('Trustee Fee Applied',
                            transaction.trusteeFeeDisplay),
                        gapHeight24,
                      ],
                      AppInfoText('Transaction Date',
                          transaction.transactionDateDisplay),
                      gapHeight24,
                      AppInfoText('Bank Name', transaction.bankNameDisplay),
                      gapHeight24,
                      AppInfoText(
                          'Transaction ID', transaction.transactionIdDisplay),
                      gapHeight24,
                      AppInfoText('Status', transaction.statusDisplay),
                    ],
                  )),
                  gapHeight80,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w)
                        .copyWith(bottom: 16.h),
                    child: AppTextButton(
                      title: 'Report issue',
                      onTap: () {},
                      textStyle: AppTextStyle.action,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
