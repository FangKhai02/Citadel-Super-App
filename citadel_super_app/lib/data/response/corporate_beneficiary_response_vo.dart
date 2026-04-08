// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/corporate_beneficiary_vo.dart';


part 'corporate_beneficiary_response_vo.freezed.dart';
part 'corporate_beneficiary_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateBeneficiaryResponseVo with _$CorporateBeneficiaryResponseVo {
  CorporateBeneficiaryResponseVo._();

  factory CorporateBeneficiaryResponseVo({
     String? code,
     String? message,
     CorporateBeneficiaryVo? corporateBeneficiary,
    
  }) = _CorporateBeneficiaryResponseVo;
  
  factory CorporateBeneficiaryResponseVo.fromJson(Map<String, dynamic> json) => _$CorporateBeneficiaryResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "corporateBeneficiary" : CorporateBeneficiaryVo.toExampleApiJson(),
  //   
  // };
}