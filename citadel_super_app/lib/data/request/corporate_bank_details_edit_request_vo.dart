// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_bank_details_edit_request_vo.freezed.dart';
part 'corporate_bank_details_edit_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateBankDetailsEditRequestVo with _$CorporateBankDetailsEditRequestVo {
  CorporateBankDetailsEditRequestVo._();

  factory CorporateBankDetailsEditRequestVo({
     int? corporateBankDetailsId,
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
    
  }) = _CorporateBankDetailsEditRequestVo;
  
  factory CorporateBankDetailsEditRequestVo.fromJson(Map<String, dynamic> json) => _$CorporateBankDetailsEditRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'corporateBankDetailsId' : 0,
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