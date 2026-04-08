// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_bank_details_vo.freezed.dart';
part 'corporate_bank_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class CorporateBankDetailsVo with _$CorporateBankDetailsVo {
  CorporateBankDetailsVo._();

  factory CorporateBankDetailsVo({
     int? id, 
     String? bankName, 
     String? bankAccountHolderName, 
     String? bankAccountNumber, 
     String? bankAddress, 
     String? bankPostcode, 
     String? bankCity, 
     String? bankState, 
     String? bankCountry, 
     String? swiftCode, 
     String? bankAccountProofFile, 
    
  }) = _CorporateBankDetailsVo;
  
  factory CorporateBankDetailsVo.fromJson(Map<String, dynamic> json) => _$CorporateBankDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "id" : 0,
  //   "bankName" : 'string',
  //   "bankAccountHolderName" : 'string',
  //   "bankAccountNumber" : 'string',
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