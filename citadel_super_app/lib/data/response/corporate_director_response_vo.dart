// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/client_personal_details_vo.dart';
import '../vo/pep_declaration_vo.dart';


part 'corporate_director_response_vo.freezed.dart';
part 'corporate_director_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class CorporateDirectorResponseVo with _$CorporateDirectorResponseVo {
  CorporateDirectorResponseVo._();

  factory CorporateDirectorResponseVo({
     String? code,
     String? message,
     ClientPersonalDetailsVo? personalDetails,
     PepDeclarationVo? pepInfo,
    
  }) = _CorporateDirectorResponseVo;
  
  factory CorporateDirectorResponseVo.fromJson(Map<String, dynamic> json) => _$CorporateDirectorResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "personalDetails" : ClientPersonalDetailsVo.toExampleApiJson(),
  //   "pepInfo" : PepDeclarationVo.toExampleApiJson(),
  //   
  // };
}