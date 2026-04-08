// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'niu_get_document_vo.freezed.dart';
part 'niu_get_document_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class NiuGetDocumentVo with _$NiuGetDocumentVo {
  NiuGetDocumentVo._();

  factory NiuGetDocumentVo({
     String? filename, 
     String? url, 
    
  }) = _NiuGetDocumentVo;
  
  factory NiuGetDocumentVo.fromJson(Map<String, dynamic> json) => _$NiuGetDocumentVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "filename" : 'string',
  //   "url" : 'string',
  //   
  // };
}