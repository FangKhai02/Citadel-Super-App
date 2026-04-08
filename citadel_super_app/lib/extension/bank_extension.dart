import 'package:citadel_super_app/data/model/address.dart';
import 'package:citadel_super_app/data/model/bank.dart';

extension BanksExtension on CommonBankDetails {
  Address get addressObject => Address(
        street: bankAddress ?? '',
        state: bankState ?? '',
        city: bankCity ?? '',
        postCode: bankPostcode ?? '',
        country: bankCountry ?? '',
      );
}
