// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/corporate_documents_vo.dart';


part 'corporate_documents_request_vo.freezed.dart';
part 'corporate_documents_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateDocumentsRequestVo with _$CorporateDocumentsRequestVo {
  CorporateDocumentsRequestVo._();

  factory CorporateDocumentsRequestVo({
     List<CorporateDocumentsVo>? corporateDocuments,
    
  }) = _CorporateDocumentsRequestVo;
  
  factory CorporateDocumentsRequestVo.fromJson(Map<String, dynamic> json) => _$CorporateDocumentsRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'corporateDocuments' : CorporateDocumentsVo.toExampleApiJson(),
  //   
  // };
}