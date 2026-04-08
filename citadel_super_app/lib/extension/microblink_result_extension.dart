// DEPRECATED: Microblink is no longer used
// This extension is kept for backward compatibility during migration
// New code should use KycDocumentNotifier directly

import 'package:citadel_super_app/data/model/address.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/data/state/postcode_state.dart';
import 'package:citadel_super_app/data/state/microblink_result_state.dart';
import 'package:citadel_super_app/data/vo/client_personal_details_vo.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/main.dart';

// Legacy extension for backward compatibility
extension MicroblinkResultExtension on BlinkIdMultiSideRecognizerResult? {
  ClientPersonalDetailsVo get getResultAsClientPersonalDetails =>
      ClientPersonalDetailsVo(
          name: nameFormatted(),
          identityCardNumber: this?.documentNumber ?? '',
          dob: dobInEpoch,
          address: addressStreet,
          postcode: addressPostcode,
          city: addressCity,
          state: addressState,
          country: addressCountry,
          nationality: nationalityFormatted(),
          gender: genderFormatted());

  String get frontImage => this?.fullDocumentFrontImage ?? '';
  String get backImage => this?.fullDocumentBackImage ?? '';

  int? get dobInEpoch => this?.dateOfBirth?.millisecondsSinceEpoch;

  String get addressStreet => '';

  String get addressPostcode => '';

  String get addressCity => '';

  String get addressState => '';

  String get addressCountry => '';

  String nameFormatted() => this?.name ?? '';
  String genderFormatted() => this?.gender ?? '';
  String nationalityFormatted() => this?.nationality ?? '';
  String docTypeConstant() => this?.documentType ?? '';
}
