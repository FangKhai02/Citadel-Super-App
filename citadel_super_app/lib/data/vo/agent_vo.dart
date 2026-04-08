// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agent_vo.freezed.dart';
part 'agent_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentVo with _$AgentVo {
  AgentVo._();

  factory AgentVo({
     String? agentId, 
     String? agentName, 
     String? referralCode, 
     String? agentRole, 
     String? agentType, 
     String? agencyId, 
     String? agencyName, 
     String? recruitManagerId, 
     String? recruitManagerName, 
     int? joinedDate, 
    
  }) = _AgentVo;
  
  factory AgentVo.fromJson(Map<String, dynamic> json) => _$AgentVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "agentId" : 'string',
  //   "agentName" : 'string',
  //   "referralCode" : 'string',
  //   "agentRole" : 'string',
  //   "agentType" : 'string',
  //   "agencyId" : 'string',
  //   "agencyName" : 'string',
  //   "recruitManagerId" : 'string',
  //   "recruitManagerName" : 'string',
  //   "joinedDate" : 0,
  //   
  // };
}