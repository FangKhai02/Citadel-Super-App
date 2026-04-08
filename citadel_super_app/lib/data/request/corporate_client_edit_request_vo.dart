// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_client_edit_request_vo.freezed.dart';
part 'corporate_client_edit_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateClientEditRequestVo with _$CorporateClientEditRequestVo {
  CorporateClientEditRequestVo._();

  factory CorporateClientEditRequestVo({
     String? annualIncomeDeclaration,
     String? sourceOfIncome,
    
  }) = _CorporateClientEditRequestVo;
  
  factory CorporateClientEditRequestVo.fromJson(Map<String, dynamic> json) => _$CorporateClientEditRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'annualIncomeDeclaration' : 'string',
  //   'sourceOfIncome' : 'string',
  //   
  // };
}