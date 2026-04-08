// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/corporate_beneficiary_base_vo.dart';


part 'corporate_beneficiaries_response_vo.freezed.dart';
part 'corporate_beneficiaries_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateBeneficiariesResponseVo with _$CorporateBeneficiariesResponseVo {
  CorporateBeneficiariesResponseVo._();

  factory CorporateBeneficiariesResponseVo({
     String? code,
     String? message,
     List<CorporateBeneficiaryBaseVo>? corporateBeneficiaries,
    
  }) = _CorporateBeneficiariesResponseVo;
  
  factory CorporateBeneficiariesResponseVo.fromJson(Map<String, dynamic> json) => _$CorporateBeneficiariesResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "corporateBeneficiaries" : CorporateBeneficiaryBaseVo.toExampleApiJson(),
  //   
  // };
}