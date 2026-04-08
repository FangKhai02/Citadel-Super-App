// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'client_guardian_creation_request_vo.freezed.dart';
part 'client_guardian_creation_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class ClientGuardianCreationRequestVo with _$ClientGuardianCreationRequestVo {
  ClientGuardianCreationRequestVo._();

  factory ClientGuardianCreationRequestVo({
     int? beneficiaryId,
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
     String? identityCardFrontImage,
     String? identityCardBackImage,
     String? addressProofKey,
     String? relationshipToGuardian,
    
  }) = _ClientGuardianCreationRequestVo;
  
  factory ClientGuardianCreationRequestVo.fromJson(Map<String, dynamic> json) => _$ClientGuardianCreationRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'beneficiaryId' : 0,
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
  //   'identityCardFrontImage' : 'string',
  //   'identityCardBackImage' : 'string',
  //   'addressProofKey' : 'string',
  //   'relationshipToGuardian' : 'string',
  //   
  // };
}