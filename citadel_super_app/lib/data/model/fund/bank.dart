import 'dart:io';

import 'package:citadel_super_app/data/model/address.dart';

class Bank {
  final String holderName;
  final String bankName;
  final String number;
  final Address bankAddress;
  final String swiftCode;
  final File? bankHeader;

  Bank(
      {this.holderName = '',
      this.bankName = '',
      this.number = '',
      this.swiftCode = '',
      File? bankHeader,
      Address? address})
      : bankAddress = address ?? const Address(),
        bankHeader = bankHeader ?? File('');

  Bank copyWith(
      {String? holderName,
      String? bankName,
      String? number,
      Address? bankAddress,
      String? swiftCode,
      File? bankHeader}) {
    return Bank(
      holderName: holderName ?? this.holderName,
      bankName: bankName ?? this.bankName,
      number: number ?? this.number,
      address: bankAddress ?? this.bankAddress,
      swiftCode: swiftCode ?? this.swiftCode,
      bankHeader: bankHeader ?? this.bankHeader,
    );
  }

  Bank.fromJson(dynamic json)
      : holderName = json['holderName'] ?? '',
        bankName = json['bankName'] ?? '',
        number = json['number'] ?? '',
        bankAddress = Address.fromJson(json['bankAddress'] ?? {}),
        swiftCode = json['swiftCode'] ?? '',
        bankHeader = json['bankHeader'] ?? File('');
}
