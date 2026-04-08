// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_client_validate_two_request_vo.freezed.dart';
part 'corporate_client_validate_two_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class CorporateClientValidateTwoRequestVo with _$CorporateClientValidateTwoRequestVo {
  CorporateClientValidateTwoRequestVo._();

  factory CorporateClientValidateTwoRequestVo({
     String? annualIncomeDeclaration,
     String? sourceOfIncome,
     String? digitalSignature,
    
  }) = _CorporateClientValidateTwoRequestVo;
  
  factory CorporateClientValidateTwoRequestVo.fromJson(Map<String, dynamic> json) => _$CorporateClientValidateTwoRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'annualIncomeDeclaration' : 'string',
  //   'sourceOfIncome' : 'string',
  //   'digitalSignature' : 'string',
  //   
  // };
}