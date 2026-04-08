// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agreement_response_vo.freezed.dart';
part 'agreement_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgreementResponseVo with _$AgreementResponseVo {
  AgreementResponseVo._();

  factory AgreementResponseVo({
     String? code,
     String? message,
     String? link,
     String? html,
    
  }) = _AgreementResponseVo;
  
  factory AgreementResponseVo.fromJson(Map<String, dynamic> json) => _$AgreementResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "link" : 'string',
  //   "html" : 'string',
  //   
  // };
}