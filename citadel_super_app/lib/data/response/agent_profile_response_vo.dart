// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/agent_personal_details_vo.dart';
import '../vo/agent_vo.dart';


part 'agent_profile_response_vo.freezed.dart';
part 'agent_profile_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentProfileResponseVo with _$AgentProfileResponseVo {
  AgentProfileResponseVo._();

  factory AgentProfileResponseVo({
     String? code,
     String? message,
     AgentPersonalDetailsVo? personalDetails,
     AgentVo? agentDetails,
    
  }) = _AgentProfileResponseVo;
  
  factory AgentProfileResponseVo.fromJson(Map<String, dynamic> json) => _$AgentProfileResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "personalDetails" : AgentPersonalDetailsVo.toExampleApiJson(),
  //   "agentDetails" : AgentVo.toExampleApiJson(),
  //   
  // };
}