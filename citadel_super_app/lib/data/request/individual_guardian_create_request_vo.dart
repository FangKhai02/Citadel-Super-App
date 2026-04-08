// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'individual_guardian_create_request_vo.freezed.dart';
part 'individual_guardian_create_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class IndividualGuardianCreateRequestVo with _$IndividualGuardianCreateRequestVo {
  IndividualGuardianCreateRequestVo._();

  factory IndividualGuardianCreateRequestVo({
     int? beneficiaryId,
     String? relationshipToGuardian,
     String? relationshipToBeneficiary,
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
    
  }) = _IndividualGuardianCreateRequestVo;
  
  factory IndividualGuardianCreateRequestVo.fromJson(Map<String, dynamic> json) => _$IndividualGuardianCreateRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'beneficiaryId' : 0,
  //   'relationshipToGuardian' : 'string',
  //   'relationshipToBeneficiary' : 'string',
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
  //   
  // };
}