import 'dart:ui';

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/data/model/transaction/transaction_type.dart';
import 'package:citadel_super_app/data/vo/transaction_vo.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:intl/intl.dart';

extension TransactionDetailExtension on TransactionVo {
  String get amountDisplay {
    if (amount == null) return '';
    final sign = transactionTypeEnum == TransactionType.dividend ? '+' : '-';
    return '$sign RM ${amount!.toInt().thousandSeparator()}';
  }

  String get transactionDateDisplay {
    if (transactionDate == null) return '-';
    final formatter = DateFormat('dd MMM yyyy, hh:mm a');
    final dateTime = DateTime.fromMillisecondsSinceEpoch(transactionDate!);
    return formatter.format(dateTime);
  }

  String get statusDisplay => status?.replaceAll('_', ' ').toUpperCase() ?? '';

  String get titleDisplay => transactionTitle ?? '';

  String get productNameDisplay => productName ?? '';

  String get agreementNumberDisplay => agreementNumber ?? '';

  String get bankNameDisplay => bankName ?? '';

  String get transactionIdDisplay => transactionId ?? '';

  String get trusteeFeeDisplay {
    if (trusteeFee == null) return '';
    return 'RM ${trusteeFee!.toInt().thousandSeparator()}';
  }

  TransactionType get transactionTypeEnum {
    switch (transactionType?.toUpperCase()) {
      case 'DIVIDEND':
        return TransactionType.dividend;
      case 'PLACEMENT':
        return TransactionType.placement;
      default:
        return TransactionType.dividend;
    }
  }

  TransactionStatus get transactionStatusEnum {
    switch (status?.toUpperCase()) {
      case 'COMPLETED':
        return TransactionStatus.completed;
      case 'PENDING':
        return TransactionStatus.pending;
      case 'FAILED':
        return TransactionStatus.failed;
      case 'SUCCESS':
        return TransactionStatus.success;
      case 'CANCELLED':
        return TransactionStatus.cancelled;
      case 'EXPIRED':
        return TransactionStatus.expired;
      case 'INVALID':
        return TransactionStatus.invalid;
      case 'UNKNOWN':
        return TransactionStatus.unknown;
      case 'OPEN':
        return TransactionStatus.open;
      case 'REVERSED':
        return TransactionStatus.reversed;
      case 'PROCESSING':
        return TransactionStatus.processing;
      case 'IN_REVIEW':
        return TransactionStatus.inReview;
      case 'DRAFT':
        return TransactionStatus.draft;
      case 'ACTIVE':
        return TransactionStatus.active;
      case 'APPROVED':
        return TransactionStatus.approved;
      case 'REJECTED':
        return TransactionStatus.rejected;
      default:
        return TransactionStatus.unknown;
    }
  }

  Color get getTransactionColor =>
      transactionTypeEnum == TransactionType.dividend
          ? AppColor.mint
          : AppColor.errorRed;
}
