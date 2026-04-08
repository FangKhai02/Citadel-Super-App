// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'niu_apply_document_vo.freezed.dart';
part 'niu_apply_document_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class NiuApplyDocumentVo with _$NiuApplyDocumentVo {
  NiuApplyDocumentVo._();

  factory NiuApplyDocumentVo({
     String? filename, 
     String? signature, 
    
  }) = _NiuApplyDocumentVo;
  
  factory NiuApplyDocumentVo.fromJson(Map<String, dynamic> json) => _$NiuApplyDocumentVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "filename" : 'string',
  //   "signature" : 'string',
  //   
  // };
}