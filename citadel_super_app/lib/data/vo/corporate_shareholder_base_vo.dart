// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_shareholder_base_vo.freezed.dart';
part 'corporate_shareholder_base_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateShareholderBaseVo with _$CorporateShareholderBaseVo {
  CorporateShareholderBaseVo._();

  factory CorporateShareholderBaseVo({
     int? id, 
     String? name, 
     double? percentageOfShareholdings, 
     String? status, 
    
  }) = _CorporateShareholderBaseVo;
  
  factory CorporateShareholderBaseVo.fromJson(Map<String, dynamic> json) => _$CorporateShareholderBaseVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "id" : 0,
  //   "name" : 'string',
  //   "percentageOfShareholdings" : 0,
  //   "status" : 'string',
  //   
  // };
}