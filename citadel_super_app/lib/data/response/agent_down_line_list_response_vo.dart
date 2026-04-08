// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/agent_vo.dart';


part 'agent_down_line_list_response_vo.freezed.dart';
part 'agent_down_line_list_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentDownLineListResponseVo with _$AgentDownLineListResponseVo {
  AgentDownLineListResponseVo._();

  factory AgentDownLineListResponseVo({
     String? code,
     String? message,
     List<AgentVo>? agentDownLineList,
    
  }) = _AgentDownLineListResponseVo;
  
  factory AgentDownLineListResponseVo.fromJson(Map<String, dynamic> json) => _$AgentDownLineListResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "agentDownLineList" : AgentVo.toExampleApiJson(),
  //   
  // };
}