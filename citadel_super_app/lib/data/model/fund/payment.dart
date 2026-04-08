import 'dart:io';

import 'package:citadel_super_app/data/vo/product_order_payment_details_vo.dart';

enum PaymentMethod {
  manualTransfer,
  onlineBanking,
}

enum PaymentStatus {
  pending,
  approved,
  rejected,
}

class Payment {
  PaymentMethod? paymentMethod;
  String? transactionId;
  String? bankName;
  List<File>? paymentProof;
  PaymentStatus? status;

  Payment(
      {this.paymentMethod,
      this.transactionId,
      this.bankName,
      this.paymentProof = const [],
      this.status});

  Payment copyWith(
      {PaymentMethod? paymentMethod,
      String? transactionId,
      String? bankName,
      List<File>? paymentProof,
      PaymentStatus? status}) {
    return Payment(
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionId: transactionId ?? this.transactionId,
      bankName: bankName ?? this.bankName,
      paymentProof: paymentProof ?? this.paymentProof,
      status: status ?? this.status,
    );
  }

  String get paymentMethodString {
    switch (paymentMethod) {
      case PaymentMethod.manualTransfer:
        return 'Manual Transfer';
      case PaymentMethod.onlineBanking:
        return 'Online Banking';
      default:
        return '';
    }
  }
}

extension PaymentMethodExtension on PaymentMethod {
  String get paymentMethodKey {
    switch (this) {
      case PaymentMethod.manualTransfer:
        return 'MANUAL_TRANSFER';
      case PaymentMethod.onlineBanking:
        return 'ONLINE_BANKING';
    }
  }
}

extension PaymentMethodKeyExtension on ProductOrderPaymentDetailsVo? {
  String get paymentMethodNameDisplay => this?.paymentMethod == 'ONLINE_BANKING'
      ? 'Online Banking'
      : 'Manual Transfer';
}
