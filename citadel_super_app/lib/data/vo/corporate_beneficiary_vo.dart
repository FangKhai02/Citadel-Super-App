// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/corporate_guardian_vo.dart';


part 'corporate_beneficiary_vo.freezed.dart';
part 'corporate_beneficiary_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateBeneficiaryVo with _$CorporateBeneficiaryVo {
  CorporateBeneficiaryVo._();

  factory CorporateBeneficiaryVo({
     int? corporateBeneficiaryId, 
     String? fullName, 
     String? relationshipToSettlor, 
     String? relationshipToGuardian, 
     bool? isUnderAge, 
     CorporateGuardianVo? corporateGuardianVo, 
     String? identityCardNumber, 
     String? identityDocumentType, 
     String? identityCardFrontImageKey, 
     String? identityCardBackImageKey, 
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
    
  }) = _CorporateBeneficiaryVo;
  
  factory CorporateBeneficiaryVo.fromJson(Map<String, dynamic> json) => _$CorporateBeneficiaryVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "corporateBeneficiaryId" : 0,
  //   "fullName" : 'string',
  //   "relationshipToSettlor" : 'string',
  //   "relationshipToGuardian" : 'string',
  //   "isUnderAge" : false,
  //   "corporateGuardianVo" : CorporateGuardianVo.toExampleApiJson(),
  //   "identityCardNumber" : 'string',
  //   "identityDocumentType" : 'string',
  //   "identityCardFrontImageKey" : 'string',
  //   "identityCardBackImageKey" : 'string',
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
  //   
  // };
}