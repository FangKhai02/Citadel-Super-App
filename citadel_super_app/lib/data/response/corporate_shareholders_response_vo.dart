// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/corporate_shareholder_base_vo.dart';
import '../vo/corporate_shareholder_base_vo.dart';


part 'corporate_shareholders_response_vo.freezed.dart';
part 'corporate_shareholders_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateShareholdersResponseVo with _$CorporateShareholdersResponseVo {
  CorporateShareholdersResponseVo._();

  factory CorporateShareholdersResponseVo({
     String? code,
     String? message,
     List<CorporateShareholderBaseVo>? draftShareholders,
     List<CorporateShareholderBaseVo>? mappedShareholders,
    
  }) = _CorporateShareholdersResponseVo;
  
  factory CorporateShareholdersResponseVo.fromJson(Map<String, dynamic> json) => _$CorporateShareholdersResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "draftShareholders" : CorporateShareholderBaseVo.toExampleApiJson(),
  //   "mappedShareholders" : CorporateShareholderBaseVo.toExampleApiJson(),
  //   
  // };
}