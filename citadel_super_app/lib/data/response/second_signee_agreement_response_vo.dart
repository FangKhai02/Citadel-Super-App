// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'second_signee_agreement_response_vo.freezed.dart';
part 'second_signee_agreement_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class SecondSigneeAgreementResponseVo with _$SecondSigneeAgreementResponseVo {
  SecondSigneeAgreementResponseVo._();

  factory SecondSigneeAgreementResponseVo({
     String? code,
     String? message,
     String? link,
     String? html,
    
  }) = _SecondSigneeAgreementResponseVo;
  
  factory SecondSigneeAgreementResponseVo.fromJson(Map<String, dynamic> json) => _$SecondSigneeAgreementResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "link" : 'string',
  //   "html" : 'string',
  //   
  // };
}