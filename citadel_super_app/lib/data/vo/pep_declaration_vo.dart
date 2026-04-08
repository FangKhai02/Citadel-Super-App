// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/pep_declaration_options_vo.dart';


part 'pep_declaration_vo.freezed.dart';
part 'pep_declaration_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class PepDeclarationVo with _$PepDeclarationVo {
  PepDeclarationVo._();

  factory PepDeclarationVo({
     bool? isPep, 
     PepDeclarationOptionsVo? pepDeclarationOptions, 
    
  }) = _PepDeclarationVo;
  
  factory PepDeclarationVo.fromJson(Map<String, dynamic> json) => _$PepDeclarationVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "isPep" : false,
  //   "pepDeclarationOptions" : PepDeclarationOptionsVo.toExampleApiJson(),
  //   
  // };
}