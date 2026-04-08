import 'dart:ui';

import 'package:citadel_super_app/app_folder/app_color.dart';

enum TransactionType {
  withdrawal('Withdrawal'),
  dividend('Dividends'),
  placingFund('Placing Fund');

  final String value;

  const TransactionType(this.value);

  String get name => value;
}

class Transaction {
  String? fundName;
  String? bankName;
  String? transactionId;
  String? status;
  double? amount;
  DateTime? date;
  TransactionType? type;

  Transaction({
    this.fundName,
    this.bankName,
    this.transactionId,
    this.status,
    this.amount,
    this.date,
    this.type,
  });

  Transaction copyWith({
    String? fundName,
    String? bankName,
    String? transactionId,
    String? status,
    double? amount,
    DateTime? date,
    TransactionType? type,
  }) {
    return Transaction(
      fundName: fundName ?? this.fundName,
      bankName: bankName ?? this.bankName,
      transactionId: transactionId ?? this.transactionId,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
    );
  }

  String get transactionAmount {
    String displayValue = '';

    if (type == TransactionType.withdrawal) {
      displayValue = '- RM ${amount?.toStringAsFixed(2)}';
    } else {
      displayValue = '+ RM ${amount?.toStringAsFixed(2)}';
    }
    return displayValue;
  }

  Color get getTransactionAmountColor =>
      type == TransactionType.withdrawal ? AppColor.errorRed : AppColor.mint;
}
