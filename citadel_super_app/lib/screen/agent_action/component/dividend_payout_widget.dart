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

class ClientTransactionsWidget extends HookConsumerWidget {
  final List<TransactionVo> clientTransactions;
  final String? clientId;
  final bool showStatusIndicator;

  const ClientTransactionsWidget(
      {super.key,
      this.showStatusIndicator = true,
      this.clientId,
      required this.clientTransactions});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget noDividend() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dividend Payouts',
            style: AppTextStyle.header2,
          ),
          gapHeight16,
          AppInfoContainer(
              child: Text(
            'You have no dividend payout yet.',
            style: AppTextStyle.description,
          )),
        ],
      );
    }

    Widget dividendPayoutList() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                'Dividend Payouts',
                style: AppTextStyle.header2,
              )),
              AppTextButton(
                  title: 'View More',
                  onTap: () {
                    Navigator.pushNamed(context, CustomRouter.transaction,
                        arguments: TransactionPage(
                          transactions: clientTransactions,
                          pageTitle: 'Dividend Payouts',
                        ));
                  })
            ],
          ),
          gapHeight16,
          AppInfoContainer(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            color: AppColor.cyan.withOpacity(0.2),
            child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: min(clientTransactions.length, 3),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) {
                  return Divider(
                    color: AppColor.white.withOpacity(0.2),
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  final transaction = clientTransactions[index];

                  return TransactionRecord(
                    showStatusIndicator: false,
                    transaction: transaction,
                  );

                  // return Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 16.h),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //           child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(transaction.productNameDisplay,
                  //               style: AppTextStyle.bodyText),
                  //           gapHeight4,
                  //           Text(transaction.transactionIdDisplay,
                  //               style: AppTextStyle.caption),
                  //           gapHeight4,
                  //           Text(transaction.transactionDateDisplay,
                  //               style: AppTextStyle.description),
                  //         ],
                  //       )),
                  //       gapWidth16,
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.end,
                  //         children: [
                  //           if (showStatusIndicator)
                  //             TransactionStatusIndicator(
                  //                 status: transaction.transactionStatusEnum),
                  //           gapHeight16,
                  //           Text(
                  //             transaction.amountDisplay,
                  //             style: AppTextStyle.header3.copyWith(
                  //               color: transaction.getTransactionColor,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // );
                }),
          )
        ],
      );
    }

    return clientTransactions.isEmpty ? noDividend() : dividendPayoutList();
  }
}
