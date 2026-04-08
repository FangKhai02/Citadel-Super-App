// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_guardian_vo.freezed.dart';
part 'corporate_guardian_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateGuardianVo with _$CorporateGuardianVo {
  CorporateGuardianVo._();

  factory CorporateGuardianVo({
     int? corporateGuardianId, 
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
    
  }) = _CorporateGuardianVo;
  
  factory CorporateGuardianVo.fromJson(Map<String, dynamic> json) => _$CorporateGuardianVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "corporateGuardianId" : 0,
  //   "fullName" : 'string',
  //   "identityCardNumber" : 'string',
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
  //   "identityCardFrontImage" : 'string',
  //   "identityCardBackImage" : 'string',
  //   
  // };
}