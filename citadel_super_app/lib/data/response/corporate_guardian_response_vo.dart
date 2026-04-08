// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/corporate_guardian_base_vo.dart';


part 'corporate_guardian_response_vo.freezed.dart';
part 'corporate_guardian_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateGuardianResponseVo with _$CorporateGuardianResponseVo {
  CorporateGuardianResponseVo._();

  factory CorporateGuardianResponseVo({
     CorporateGuardianBaseVo? corporateGuardian,
    
  }) = _CorporateGuardianResponseVo;
  
  factory CorporateGuardianResponseVo.fromJson(Map<String, dynamic> json) => _$CorporateGuardianResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "corporateGuardian" : CorporateGuardianBaseVo.toExampleApiJson(),
  //   
  // };
}