// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'bank_details_vo.freezed.dart';
part 'bank_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class BankDetailsVo with _$BankDetailsVo {
  BankDetailsVo._();

  factory BankDetailsVo({
     int? id, 
     String? bankName, 
     String? bankAccountNumber, 
     String? bankAccountHolderName, 
     String? bankAddress, 
     String? bankPostcode, 
     String? bankCity, 
     String? bankState, 
     String? bankCountry, 
     String? swiftCode, 
     String? bankAccountProofFile, 
    
  }) = _BankDetailsVo;
  
  factory BankDetailsVo.fromJson(Map<String, dynamic> json) => _$BankDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "id" : 0,
  //   "bankName" : 'string',
  //   "bankAccountNumber" : 'string',
  //   "bankAccountHolderName" : 'string',
  //   "bankAddress" : 'string',
  //   "bankPostcode" : 'string',
  //   "bankCity" : 'string',
  //   "bankState" : 'string',
  //   "bankCountry" : 'string',
  //   "swiftCode" : 'string',
  //   "bankAccountProofFile" : 'string',
  //   
  // };
}