// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agent_client_vo.freezed.dart';
part 'agent_client_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentClientVo with _$AgentClientVo {
  AgentClientVo._();

  factory AgentClientVo({
     String? clientType, 
     String? name, 
     String? clientId, 
     int? joinedDate, 
    
  }) = _AgentClientVo;
  
  factory AgentClientVo.fromJson(Map<String, dynamic> json) => _$AgentClientVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "clientType" : 'string',
  //   "name" : 'string',
  //   "clientId" : 'string',
  //   "joinedDate" : 0,
  //   
  // };
}