// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_guardian_base_vo.freezed.dart';
part 'corporate_guardian_base_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateGuardianBaseVo with _$CorporateGuardianBaseVo {
  CorporateGuardianBaseVo._();

  factory CorporateGuardianBaseVo({
     int? corporateGuardianId, 
     String? fullName, 
    
  }) = _CorporateGuardianBaseVo;
  
  factory CorporateGuardianBaseVo.fromJson(Map<String, dynamic> json) => _$CorporateGuardianBaseVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "corporateGuardianId" : 0,
  //   "fullName" : 'string',
  //   
  // };
}