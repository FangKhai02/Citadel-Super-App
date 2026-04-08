// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/guardian_vo.dart';


part 'individual_beneficiary_vo.freezed.dart';
part 'individual_beneficiary_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class IndividualBeneficiaryVo with _$IndividualBeneficiaryVo {
  IndividualBeneficiaryVo._();

  factory IndividualBeneficiaryVo({
     int? individualBeneficiaryId, 
     String? identityDocumentType, 
     String? identityCardFrontImageKey, 
     String? identityCardBackImageKey, 
     String? relationshipToSettlor, 
     String? relationshipToGuardian, 
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
     bool? isUnderAge, 
     GuardianVo? guardian, 
    
  }) = _IndividualBeneficiaryVo;
  
  factory IndividualBeneficiaryVo.fromJson(Map<String, dynamic> json) => _$IndividualBeneficiaryVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "individualBeneficiaryId" : 0,
  //   "identityDocumentType" : 'string',
  //   "identityCardFrontImageKey" : 'string',
  //   "identityCardBackImageKey" : 'string',
  //   "relationshipToSettlor" : 'string',
  //   "relationshipToGuardian" : 'string',
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
  //   "isUnderAge" : false,
  //   "guardian" : GuardianVo.toExampleApiJson(),
  //   
  // };
}