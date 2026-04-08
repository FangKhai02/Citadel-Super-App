// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_beneficiary_update_request_vo.freezed.dart';
part 'corporate_beneficiary_update_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateBeneficiaryUpdateRequestVo with _$CorporateBeneficiaryUpdateRequestVo {
  CorporateBeneficiaryUpdateRequestVo._();

  factory CorporateBeneficiaryUpdateRequestVo({
     String? relationshipToSettlor,
     String? relationshipToGuardian,
     String? fullName,
     String? gender,
     String? nationality,
     String? address,
     String? postcode,
     String? city,
     String? state,
     String? country,
     String? residentialStatus,
     String? maritalStatus,
     String? mobileCountryCode,
     String? mobileNumber,
     String? email,
    
  }) = _CorporateBeneficiaryUpdateRequestVo;
  
  factory CorporateBeneficiaryUpdateRequestVo.fromJson(Map<String, dynamic> json) => _$CorporateBeneficiaryUpdateRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'relationshipToSettlor' : 'string',
  //   'relationshipToGuardian' : 'string',
  //   'fullName' : 'string',
  //   'gender' : 'string',
  //   'nationality' : 'string',
  //   'address' : 'string',
  //   'postcode' : 'string',
  //   'city' : 'string',
  //   'state' : 'string',
  //   'country' : 'string',
  //   'residentialStatus' : 'string',
  //   'maritalStatus' : 'string',
  //   'mobileCountryCode' : 'string',
  //   'mobileNumber' : 'string',
  //   'email' : 'string',
  //   
  // };
}