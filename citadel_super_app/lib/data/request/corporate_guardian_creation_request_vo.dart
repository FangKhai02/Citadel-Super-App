// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_guardian_creation_request_vo.freezed.dart';
part 'corporate_guardian_creation_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateGuardianCreationRequestVo with _$CorporateGuardianCreationRequestVo {
  CorporateGuardianCreationRequestVo._();

  factory CorporateGuardianCreationRequestVo({
     int? corporateBeneficiaryId,
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
     String? identityDocumentType,
     String? identityCardFrontImage,
     String? identityCardBackImage,
     String? relationshipToGuardian,
    
  }) = _CorporateGuardianCreationRequestVo;
  
  factory CorporateGuardianCreationRequestVo.fromJson(Map<String, dynamic> json) => _$CorporateGuardianCreationRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'corporateBeneficiaryId' : 0,
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
  //   'identityDocumentType' : 'string',
  //   'identityCardFrontImage' : 'string',
  //   'identityCardBackImage' : 'string',
  //   'relationshipToGuardian' : 'string',
  //   
  // };
}