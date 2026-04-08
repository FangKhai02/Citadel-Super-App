// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agency_agent_vo.freezed.dart';
part 'agency_agent_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgencyAgentVo with _$AgencyAgentVo {
  AgencyAgentVo._();

  factory AgencyAgentVo({
     String? agentId, 
     String? agentName, 
    
  }) = _AgencyAgentVo;
  
  factory AgencyAgentVo.fromJson(Map<String, dynamic> json) => _$AgencyAgentVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "agentId" : 'string',
  //   "agentName" : 'string',
  //   
  // };
}