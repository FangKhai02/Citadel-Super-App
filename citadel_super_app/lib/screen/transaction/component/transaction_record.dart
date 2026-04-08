import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/vo/transaction_vo.dart';
import 'package:citadel_super_app/extension/transaction_extension.dart';
import 'package:citadel_super_app/screen/fund/component/transaction_status_indicator.dart';
import 'package:citadel_super_app/screen/transaction/transaction_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionRecord extends HookWidget {
  final bool showStatusIndicator;
  final TransactionVo transaction;

  const TransactionRecord(
      {super.key, this.showStatusIndicator = true, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.pushNamed(
          context,
          CustomRouter.transactionDetail,
          arguments: TransactionDetailPage(transaction: transaction),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.titleDisplay,
                    style: AppTextStyle.bodyText,
                  ),
                  gapHeight4,
                  Text(
                    transaction.productNameDisplay,
                    style: AppTextStyle.caption,
                  ),
                  gapHeight4,
                  Text(
                    transaction.transactionIdDisplay,
                    style: AppTextStyle.caption,
                  ),
                  Text(
                    transaction.transactionDateDisplay,
                    style: AppTextStyle.caption,
                  ),
                ],
              ),
            ),
            gapWidth16,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (showStatusIndicator) ...[
                  TransactionStatusIndicator(
                      status: transaction.transactionStatusEnum),
                  gapHeight16,
                ],
                Text(
                  transaction.amountDisplay,
                  style: AppTextStyle.header3.copyWith(
                    color: transaction.getTransactionColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
