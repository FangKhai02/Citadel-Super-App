// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/corporate_guardian_base_vo.dart';


part 'corporate_beneficiary_create_response_vo.freezed.dart';
part 'corporate_beneficiary_create_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateBeneficiaryCreateResponseVo with _$CorporateBeneficiaryCreateResponseVo {
  CorporateBeneficiaryCreateResponseVo._();

  factory CorporateBeneficiaryCreateResponseVo({
     String? code,
     String? message,
     bool? isUnderAge,
     int? corporateBeneficiaryId,
     CorporateGuardianBaseVo? corporateGuardianBaseVo,
    
  }) = _CorporateBeneficiaryCreateResponseVo;
  
  factory CorporateBeneficiaryCreateResponseVo.fromJson(Map<String, dynamic> json) => _$CorporateBeneficiaryCreateResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "isUnderAge" : false,
  //   "corporateBeneficiaryId" : 0,
  //   "corporateGuardianBaseVo" : CorporateGuardianBaseVo.toExampleApiJson(),
  //   
  // };
}