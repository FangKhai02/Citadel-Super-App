// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/app_user.dart';


part 'bank_details.freezed.dart';
part 'bank_details.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class BankDetails with _$BankDetails {
  BankDetails._();

  factory BankDetails({
     AppUser? appUser, 
     String? bankName, 
     String? accountNumber, 
     String? accountHolderName, 
     String? bankAddress, 
     String? postcode, 
     String? city, 
     String? state, 
     String? country, 
     String? swiftCode, 
     String? bankAccountProofKey, 
     bool? isDeleted, 
    
  }) = _BankDetails;
  
  factory BankDetails.fromJson(Map<String, dynamic> json) => _$BankDetailsFromJson(json);

  // To form example request for API test
  static Map<String, dynamic> toExampleApiJson() => {
    'appUser' : AppUser.toExampleApiJson(),
    'bankName' : 'string',
    'accountNumber' : 'string',
    'accountHolderName' : 'string',
    'bankAddress' : 'string',
    'postcode' : 'string',
    'city' : 'string',
    'state' : 'string',
    'country' : 'string',
    'swiftCode' : 'string',
    'bankAccountProofKey' : 'string',
    'isDeleted' : false,
    
  };
}