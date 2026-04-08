// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_documents_vo.freezed.dart';
part 'corporate_documents_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateDocumentsVo with _$CorporateDocumentsVo {
  CorporateDocumentsVo._();

  factory CorporateDocumentsVo({
     int? id, 
     String? fileName, 
     String? file, 
    
  }) = _CorporateDocumentsVo;
  
  factory CorporateDocumentsVo.fromJson(Map<String, dynamic> json) => _$CorporateDocumentsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "id" : 0,
  //   "fileName" : 'string',
  //   "file" : 'string',
  //   
  // };
}