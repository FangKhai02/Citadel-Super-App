// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agent_pin_request_vo.freezed.dart';
part 'agent_pin_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentPinRequestVo with _$AgentPinRequestVo {
  AgentPinRequestVo._();

  factory AgentPinRequestVo({
     String? newPin,
     String? oldPin,
    
  }) = _AgentPinRequestVo;
  
  factory AgentPinRequestVo.fromJson(Map<String, dynamic> json) => _$AgentPinRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'newPin' : 'string',
  //   'oldPin' : 'string',
  //   
  // };
}