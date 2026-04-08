import 'package:citadel_super_app/data/model/fund/bank.dart';
import 'package:citadel_super_app/data/model/fund/beneficiary.dart';
import 'package:citadel_super_app/data/model/fund/fund.dart';
import 'package:citadel_super_app/data/model/fund/payment.dart';
import 'package:citadel_super_app/data/model/fund/roi.dart';

class PurchaseFund {
  Fund? fund;
  double? investAmount;
  Bank? bankChoosen;
  Roi? roi;
  List<Beneficiary> beneficiaries = const [];
  List<Beneficiary> subsBeneficiaries = const [];
  Payment? payment;

  PurchaseFund({
    this.fund,
    this.investAmount,
    this.bankChoosen,
    this.roi,
    this.beneficiaries = const [],
    this.subsBeneficiaries = const [],
    this.payment,
  });

  PurchaseFund copyWith({
    Fund? fund,
    double? investAmount,
    Bank? bankChoosen,
    Roi? roi,
    List<Beneficiary>? beneficiaries,
    List<Beneficiary>? subsBeneficiaries,
    Payment? payment,
  }) {
    return PurchaseFund(
      fund: fund ?? this.fund,
      investAmount: investAmount ?? this.investAmount,
      bankChoosen: bankChoosen ?? this.bankChoosen,
      roi: roi ?? this.roi,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      subsBeneficiaries: subsBeneficiaries ?? this.subsBeneficiaries,
      payment: payment ?? this.payment,
    );
  }
}
