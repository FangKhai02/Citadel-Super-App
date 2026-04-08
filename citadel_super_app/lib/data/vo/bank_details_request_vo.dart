// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'bank_details_request_vo.freezed.dart';
part 'bank_details_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class BankDetailsRequestVo with _$BankDetailsRequestVo {
  BankDetailsRequestVo._();

  factory BankDetailsRequestVo({
     String? bankName, 
     String? accountNumber, 
     String? accountHolderName, 
     String? bankAddress, 
     String? postcode, 
     String? city, 
     String? state, 
     String? country, 
     String? swiftCode, 
     String? bankAccountProofFile, 
    
  }) = _BankDetailsRequestVo;
  
  factory BankDetailsRequestVo.fromJson(Map<String, dynamic> json) => _$BankDetailsRequestVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "bankName" : 'string',
  //   "accountNumber" : 'string',
  //   "accountHolderName" : 'string',
  //   "bankAddress" : 'string',
  //   "postcode" : 'string',
  //   "city" : 'string',
  //   "state" : 'string',
  //   "country" : 'string',
  //   "swiftCode" : 'string',
  //   "bankAccountProofFile" : 'string',
  //   
  // };
}