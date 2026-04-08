// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/agent_vo.dart';


part 'agents_response_vo.freezed.dart';
part 'agents_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class AgentsResponseVo with _$AgentsResponseVo {
  AgentsResponseVo._();

  factory AgentsResponseVo({
     String? code,
     String? message,
     List<AgentVo>? agentsList,
    
  }) = _AgentsResponseVo;
  
  factory AgentsResponseVo.fromJson(Map<String, dynamic> json) => _$AgentsResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "agentsList" : AgentVo.toExampleApiJson(),
    
  // };
}