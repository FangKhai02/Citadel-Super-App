// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/agent_down_line_commission_vo.dart';


part 'agent_down_line_commission_response_vo.freezed.dart';
part 'agent_down_line_commission_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentDownLineCommissionResponseVo with _$AgentDownLineCommissionResponseVo {
  AgentDownLineCommissionResponseVo._();

  factory AgentDownLineCommissionResponseVo({
     String? code,
     String? message,
     List<AgentDownLineCommissionVo>? downLineCommissionList,
    
  }) = _AgentDownLineCommissionResponseVo;
  
  factory AgentDownLineCommissionResponseVo.fromJson(Map<String, dynamic> json) => _$AgentDownLineCommissionResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "downLineCommissionList" : AgentDownLineCommissionVo.toExampleApiJson(),
  //   
  // };
}