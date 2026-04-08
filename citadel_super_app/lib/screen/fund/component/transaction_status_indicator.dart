import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/transaction/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionStatusIndicator extends HookWidget {
  final TransactionStatus status;

  const TransactionStatusIndicator({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: getStatusColor(status),
            shape: BoxShape.circle,
          ),
        ),
        gapWidth8,
        Text(
          getStatusDisplay(status),
          style: AppTextStyle.description,
        ),
      ],
    );
  }
}

Color getStatusColor(TransactionStatus status) {
  switch (status) {
    case TransactionStatus.completed:
      return AppColor.green;
    case TransactionStatus.success:
      return AppColor.green;
    case TransactionStatus.pending:
      return AppColor.brightBlue;
    case TransactionStatus.inReview:
      return AppColor.yellow;
    case TransactionStatus.failed:
      return AppColor.errorRed;
    case TransactionStatus.rejected:
      return AppColor.errorRed;
    case TransactionStatus.draft:
      return AppColor.orange;
    case TransactionStatus.active:
      return AppColor.brightBlue;
    case TransactionStatus.cancelled:
      return AppColor.errorRed;
    case TransactionStatus.expired:
      return AppColor.errorRed;
    case TransactionStatus.invalid:
      return AppColor.errorRed;
    case TransactionStatus.unknown:
      return AppColor.lineGray;
    case TransactionStatus.open:
      return AppColor.darkBlue;
    case TransactionStatus.reversed:
      return AppColor.green;
    case TransactionStatus.processing:
      return Colors.grey;
    default:
      return Colors.grey;
  }
}

String getStatusDisplay(TransactionStatus status) {
  switch (status) {
    case TransactionStatus.completed:
      return 'COMPLETED';
    case TransactionStatus.success:
      return 'SUCCESS';
    case TransactionStatus.pending:
      return 'PENDING';
    case TransactionStatus.failed:
      return 'FAILED';
    case TransactionStatus.cancelled:
      return 'CANCELLED';
    case TransactionStatus.expired:
      return 'EXPIRED';
    case TransactionStatus.invalid:
      return 'INVALID';
    case TransactionStatus.unknown:
      return 'UNKNOWN';
    case TransactionStatus.open:
      return 'OPEN';
    case TransactionStatus.reversed:
      return 'REVERSED';
    case TransactionStatus.processing:
      return 'PROCESSING';
    case TransactionStatus.inReview:
      return 'IN REVIEW';
    case TransactionStatus.draft:
      return 'DRAFT';
    case TransactionStatus.active:
      return 'ACTIVE';
    case TransactionStatus.approved:
      return 'APPROVED';
    case TransactionStatus.rejected:
      return 'REJECTED';
  }
}
