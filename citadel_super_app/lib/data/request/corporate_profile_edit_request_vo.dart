// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_profile_edit_request_vo.freezed.dart';
part 'corporate_profile_edit_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class CorporateProfileEditRequestVo with _$CorporateProfileEditRequestVo {
  CorporateProfileEditRequestVo._();

  factory CorporateProfileEditRequestVo({
     String? annualIncomeDeclaration,
     String? sourceOfIncome,
    
  }) = _CorporateProfileEditRequestVo;
  
  factory CorporateProfileEditRequestVo.fromJson(Map<String, dynamic> json) => _$CorporateProfileEditRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'annualIncomeDeclaration' : 'string',
  //   'sourceOfIncome' : 'string',
  //   
  // };
}