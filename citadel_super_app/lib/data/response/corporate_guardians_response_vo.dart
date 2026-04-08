// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/corporate_guardian_base_vo.dart';


part 'corporate_guardians_response_vo.freezed.dart';
part 'corporate_guardians_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateGuardiansResponseVo with _$CorporateGuardiansResponseVo {
  CorporateGuardiansResponseVo._();

  factory CorporateGuardiansResponseVo({
     String? code,
     String? message,
     List<CorporateGuardianBaseVo>? corporateGuardians,
    
  }) = _CorporateGuardiansResponseVo;
  
  factory CorporateGuardiansResponseVo.fromJson(Map<String, dynamic> json) => _$CorporateGuardiansResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "corporateGuardians" : CorporateGuardianBaseVo.toExampleApiJson(),
  //   
  // };
}