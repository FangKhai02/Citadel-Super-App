// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'guardian_vo.freezed.dart';
part 'guardian_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class GuardianVo with _$GuardianVo {
  GuardianVo._();

  factory GuardianVo({
     int? id, 
     String? fullName, 
     String? icPassport, 
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
     String? identityCardFrontImageKey, 
     String? identityCardBackImageKey, 
     String? addressProofKey, 
     String? relationshipToBeneficiary, 
    
  }) = _GuardianVo;
  
  factory GuardianVo.fromJson(Map<String, dynamic> json) => _$GuardianVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "id" : 0,
  //   "fullName" : 'string',
  //   "icPassport" : 'string',
  //   "dob" : 0,
  //   "gender" : 'string',
  //   "nationality" : 'string',
  //   "address" : 'string',
  //   "postcode" : 'string',
  //   "city" : 'string',
  //   "state" : 'string',
  //   "country" : 'string',
  //   "residentialStatus" : 'string',
  //   "maritalStatus" : 'string',
  //   "mobileCountryCode" : 'string',
  //   "mobileNumber" : 'string',
  //   "email" : 'string',
  //   "identityDocumentType" : 'string',
  //   "identityCardFrontImageKey" : 'string',
  //   "identityCardBackImageKey" : 'string',
  //   "addressProofKey" : 'string',
  //   "relationshipToBeneficiary" : 'string',
  //   
  // };
}