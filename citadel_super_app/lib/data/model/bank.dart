import 'package:citadel_super_app/data/vo/bank_details_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_bank_details_vo.dart';

class CommonBankDetails {
  int? id;
  String? bankName;
  String? bankAccountNumber;
  String? bankAccountHolderName;
  String? bankAddress;
  String? bankPostcode;
  String? bankCity;
  String? bankState;
  String? bankCountry;
  String? swiftCode;
  String? bankAccountProofFile;

  CommonBankDetails(
      {this.id,
      this.bankName,
      this.bankAccountNumber,
      this.bankAccountHolderName,
      this.bankAddress,
      this.bankPostcode,
      this.bankCity,
      this.bankState,
      this.bankCountry,
      this.swiftCode,
      this.bankAccountProofFile});

  factory CommonBankDetails.fromClientBankDetails(BankDetailsVo vo) {
    return CommonBankDetails(
        id: vo.id,
        bankName: vo.bankName,
        bankAccountNumber: vo.bankAccountNumber,
        bankAccountHolderName: vo.bankAccountHolderName,
        bankAddress: vo.bankAddress,
        bankPostcode: vo.bankPostcode,
        bankCity: vo.bankCity,
        bankState: vo.bankState,
        bankCountry: vo.bankCountry,
        swiftCode: vo.swiftCode,
        bankAccountProofFile: vo.bankAccountProofFile);
  }

  factory CommonBankDetails.fromCorporateBankDetails(
      CorporateBankDetailsVo vo) {
    return CommonBankDetails(
        id: vo.id,
        bankName: vo.bankName,
        bankAccountNumber: vo.bankAccountNumber,
        bankAccountHolderName: vo.bankAccountHolderName,
        bankAddress: vo.bankAddress,
        bankPostcode: vo.bankPostcode,
        bankCity: vo.bankCity,
        bankState: vo.bankState,
        bankCountry: vo.bankCountry,
        swiftCode: vo.swiftCode,
        bankAccountProofFile: vo.bankAccountProofFile);
  }

  String getFullBankAddress() {
    final List<String> addressComponents = [
      bankAddress ?? '',
      bankPostcode ?? '',
      bankCity ?? '',
      bankState ?? '',
      bankCountry ?? '',
    ];

    return addressComponents
        .where((component) => component.isNotEmpty)
        .join(', ');
  }
}
