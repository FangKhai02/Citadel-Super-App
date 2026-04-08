// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/corporate_guardian_vo.dart';


part 'corporate_beneficiary_base_vo.freezed.dart';
part 'corporate_beneficiary_base_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateBeneficiaryBaseVo with _$CorporateBeneficiaryBaseVo {
  CorporateBeneficiaryBaseVo._();

  factory CorporateBeneficiaryBaseVo({
     int? corporateBeneficiaryId, 
     String? fullName, 
     String? relationshipToSettlor, 
     String? relationshipToGuardian, 
     bool? isUnderAge, 
     CorporateGuardianVo? corporateGuardianVo, 
    
  }) = _CorporateBeneficiaryBaseVo;
  
  factory CorporateBeneficiaryBaseVo.fromJson(Map<String, dynamic> json) => _$CorporateBeneficiaryBaseVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "corporateBeneficiaryId" : 0,
  //   "fullName" : 'string',
  //   "relationshipToSettlor" : 'string',
  //   "relationshipToGuardian" : 'string',
  //   "isUnderAge" : false,
  //   "corporateGuardianVo" : CorporateGuardianVo.toExampleApiJson(),
  //   
  // };
}