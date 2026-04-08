// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/agent_client_vo.dart';


part 'agent_client_response_vo.freezed.dart';
part 'agent_client_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentClientResponseVo with _$AgentClientResponseVo {
  AgentClientResponseVo._();

  factory AgentClientResponseVo({
     String? code,
     String? message,
     int? totalClients,
     int? totalNewClients,
     List<AgentClientVo>? clients,
    
  }) = _AgentClientResponseVo;
  
  factory AgentClientResponseVo.fromJson(Map<String, dynamic> json) => _$AgentClientResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "totalClients" : 0,
  //   "totalNewClients" : 0,
  //   "clients" : AgentClientVo.toExampleApiJson(),
  //   
  // };
}