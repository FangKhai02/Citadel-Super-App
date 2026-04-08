// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_beneficiary_creation_request_vo.freezed.dart';
part 'corporate_beneficiary_creation_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateBeneficiaryCreationRequestVo with _$CorporateBeneficiaryCreationRequestVo {
  CorporateBeneficiaryCreationRequestVo._();

  factory CorporateBeneficiaryCreationRequestVo({
     String? relationshipToSettlor,
     String? fullName,
     String? identityCardNumber,
     int? dob,
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
     String? documentType,
     String? identityCardFrontImage,
     String? identityCardBackImage,
    
  }) = _CorporateBeneficiaryCreationRequestVo;
  
  factory CorporateBeneficiaryCreationRequestVo.fromJson(Map<String, dynamic> json) => _$CorporateBeneficiaryCreationRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'relationshipToSettlor' : 'string',
  //   'fullName' : 'string',
  //   'identityCardNumber' : 'string',
  //   'dob' : 0,
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
  //   'documentType' : 'string',
  //   'identityCardFrontImage' : 'string',
  //   'identityCardBackImage' : 'string',
  //   
  // };
}