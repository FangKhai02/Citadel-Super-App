import 'dart:math';

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/vo/transaction_vo.dart';
import 'package:citadel_super_app/project_widget/button/app_text_button.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/screen/transaction/component/transaction_record.dart';
import 'package:citadel_super_app/screen/transaction/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyTransactionWidget extends HookConsumerWidget {
  final List<TransactionVo> transactions;
  const MyTransactionWidget({super.key, required this.transactions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget noTransaction() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Transactions',
            style: AppTextStyle.header2,
          ),
          gapHeight16,
          AppInfoContainer(
            child: Text(
              'You have no placements yet.',
              style: AppTextStyle.description,
            ),
          ),
        ],
      );
    }

    Widget transactionList(List<TransactionVo> transactions) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'My Transactions',
                  style: AppTextStyle.header2,
                ),
              ),
              AppTextButton(
                title: 'View More',
                onTap: () {
                  Navigator.pushNamed(context, CustomRouter.transaction,
                      arguments: TransactionPage(transactions: transactions));
                },
              ),
            ],
          ),
          gapHeight16,
          AppInfoContainer(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            color: AppColor.cyan.withOpacity(0.2),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: min(transactions.length, 3),
              itemBuilder: (BuildContext context, int index) {
                return TransactionRecord(
                  showStatusIndicator: false,
                  transaction: transactions[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: AppColor.white.withOpacity(0.2),
                );
              },
            ),
          ),
        ],
      );
    }

    return transactions.isEmpty
        ? noTransaction()
        : transactionList(transactions);
  }
}
