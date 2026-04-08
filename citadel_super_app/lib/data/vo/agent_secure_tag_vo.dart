// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agent_secure_tag_vo.freezed.dart';
part 'agent_secure_tag_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentSecureTagVo with _$AgentSecureTagVo {
  AgentSecureTagVo._();

  factory AgentSecureTagVo({
     String? status, 
     String? clientName, 
     String? clientId, 
     String? token, 
    
  }) = _AgentSecureTagVo;
  
  factory AgentSecureTagVo.fromJson(Map<String, dynamic> json) => _$AgentSecureTagVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "status" : 'string',
  //   "clientName" : 'string',
  //   "clientId" : 'string',
  //   "token" : 'string',
  //   
  // };
}