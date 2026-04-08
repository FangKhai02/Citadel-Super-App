// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/pep_declaration_vo.dart';


part 'corporate_shareholder_pep_response_vo.freezed.dart';
part 'corporate_shareholder_pep_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateShareholderPepResponseVo with _$CorporateShareholderPepResponseVo {
  CorporateShareholderPepResponseVo._();

  factory CorporateShareholderPepResponseVo({
     String? code,
     String? message,
     PepDeclarationVo? pepDeclaration,
    
  }) = _CorporateShareholderPepResponseVo;
  
  factory CorporateShareholderPepResponseVo.fromJson(Map<String, dynamic> json) => _$CorporateShareholderPepResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "pepDeclaration" : PepDeclarationVo.toExampleApiJson(),
  //   
  // };
}