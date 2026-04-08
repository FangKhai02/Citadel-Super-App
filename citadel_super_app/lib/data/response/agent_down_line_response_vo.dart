// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agent_down_line_response_vo.freezed.dart';
part 'agent_down_line_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentDownLineResponseVo with _$AgentDownLineResponseVo {
  AgentDownLineResponseVo._();

  factory AgentDownLineResponseVo({
     String? code,
     String? message,
     int? totalDownLine,
     int? newRecruitThisMonth,
    
  }) = _AgentDownLineResponseVo;
  
  factory AgentDownLineResponseVo.fromJson(Map<String, dynamic> json) => _$AgentDownLineResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "totalDownLine" : 0,
  //   "newRecruitThisMonth" : 0,
  //   
  // };
}