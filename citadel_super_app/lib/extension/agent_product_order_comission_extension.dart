import 'dart:ui';

import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/data/vo/agent_earning_vo.dart';
import 'package:citadel_super_app/extension/int_extension.dart';

extension AgentProductOrderComissionExtension on AgentEarningVo {
  String get earningTypeDisplay => earningType ?? '';

  String get comissionAmountDisplay {
    if (commissionAmount == null) return '';
    // final sign = transactionTypeEnum == TransactionType.dividend ? '+' : '-';
    final sign = "+";
    return '$sign RM ${commissionAmount!.toInt().thousandSeparator()}';
  }

  Color get getTransactionColor =>
      // transactionTypeEnum == TransactionType.dividend
      //     ?
      AppColor.mint;
  // : AppColor.errorRed;

  String get productNameDisplay => productCode ?? '';

  String get agreementNameDisplay => agreementNumber ?? '';

  String get bankNameDisplay => bankName ?? '';

  String get transactionIdDisplay => transactionId ?? '';

  String get transactionDateDisplay {
    if (transactionDate == null) return '-';

    return transactionDate.toDDMMMYYYhhmmWithSpace;
  }

  String get statusDisplay => status ?? '';
}
