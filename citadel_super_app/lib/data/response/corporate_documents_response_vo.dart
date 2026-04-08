// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/corporate_documents_vo.dart';


part 'corporate_documents_response_vo.freezed.dart';
part 'corporate_documents_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateDocumentsResponseVo with _$CorporateDocumentsResponseVo {
  CorporateDocumentsResponseVo._();

  factory CorporateDocumentsResponseVo({
     String? code,
     String? message,
     List<CorporateDocumentsVo>? corporateDocuments,
    
  }) = _CorporateDocumentsResponseVo;
  
  factory CorporateDocumentsResponseVo.fromJson(Map<String, dynamic> json) => _$CorporateDocumentsResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "corporateDocuments" : CorporateDocumentsVo.toExampleApiJson(),
  //   
  // };
}