// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/agency_agent_vo.dart';


part 'agency_agents_response_vo.freezed.dart';
part 'agency_agents_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgencyAgentsResponseVo with _$AgencyAgentsResponseVo {
  AgencyAgentsResponseVo._();

  factory AgencyAgentsResponseVo({
     String? code,
     String? message,
     List<AgencyAgentVo>? agentsList,
    
  }) = _AgencyAgentsResponseVo;
  
  factory AgencyAgentsResponseVo.fromJson(Map<String, dynamic> json) => _$AgencyAgentsResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "agentsList" : AgencyAgentVo.toExampleApiJson(),
  //   
  // };
}