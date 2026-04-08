// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'rollover_agreeement_request_vo.freezed.dart';
part 'rollover_agreeement_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class RolloverAgreeementRequestVo with _$RolloverAgreeementRequestVo {
  RolloverAgreeementRequestVo._();

  factory RolloverAgreeementRequestVo({
     String? digitalSignature,
    
  }) = _RolloverAgreeementRequestVo;
  
  factory RolloverAgreeementRequestVo.fromJson(Map<String, dynamic> json) => _$RolloverAgreeementRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'digitalSignature' : 'string',
  //   
  // };
}