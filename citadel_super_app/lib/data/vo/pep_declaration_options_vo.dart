// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'pep_declaration_options_vo.freezed.dart';
part 'pep_declaration_options_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class PepDeclarationOptionsVo with _$PepDeclarationOptionsVo {
  PepDeclarationOptionsVo._();

  factory PepDeclarationOptionsVo({
     String? relationship, 
     String? name, 
     String? position, 
     String? organization, 
     String? supportingDocument, 
    
  }) = _PepDeclarationOptionsVo;
  
  factory PepDeclarationOptionsVo.fromJson(Map<String, dynamic> json) => _$PepDeclarationOptionsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "relationship" : 'string',
  //   "name" : 'string',
  //   "position" : 'string',
  //   "organization" : 'string',
  //   "supportingDocument" : 'string',
  //   
  // };
}