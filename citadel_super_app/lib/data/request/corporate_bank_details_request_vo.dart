// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_bank_details_request_vo.freezed.dart';
part 'corporate_bank_details_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateBankDetailsRequestVo with _$CorporateBankDetailsRequestVo {
  CorporateBankDetailsRequestVo._();

  factory CorporateBankDetailsRequestVo({
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
    
  }) = _CorporateBankDetailsRequestVo;
  
  factory CorporateBankDetailsRequestVo.fromJson(Map<String, dynamic> json) => _$CorporateBankDetailsRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'bankName' : 'string',
  //   'accountNumber' : 'string',
  //   'accountHolderName' : 'string',
  //   'bankAddress' : 'string',
  //   'postcode' : 'string',
  //   'city' : 'string',
  //   'state' : 'string',
  //   'country' : 'string',
  //   'swiftCode' : 'string',
  //   'bankAccountProofFile' : 'string',
  //   
  // };
}