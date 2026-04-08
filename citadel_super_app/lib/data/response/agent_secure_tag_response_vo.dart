// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/agent_secure_tag_vo.dart';


part 'agent_secure_tag_response_vo.freezed.dart';
part 'agent_secure_tag_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentSecureTagResponseVo with _$AgentSecureTagResponseVo {
  AgentSecureTagResponseVo._();

  factory AgentSecureTagResponseVo({
     String? code,
     String? message,
     AgentSecureTagVo? secureTag,
    
  }) = _AgentSecureTagResponseVo;
  
  factory AgentSecureTagResponseVo.fromJson(Map<String, dynamic> json) => _$AgentSecureTagResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "secureTag" : AgentSecureTagVo.toExampleApiJson(),
  //   
  // };
}