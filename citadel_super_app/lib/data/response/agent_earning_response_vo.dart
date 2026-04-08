// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/agent_earning_vo.dart';


part 'agent_earning_response_vo.freezed.dart';
part 'agent_earning_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentEarningResponseVo with _$AgentEarningResponseVo {
  AgentEarningResponseVo._();

  factory AgentEarningResponseVo({
     String? code,
     String? message,
     List<AgentEarningVo>? earningDetails,
    
  }) = _AgentEarningResponseVo;
  
  factory AgentEarningResponseVo.fromJson(Map<String, dynamic> json) => _$AgentEarningResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "earningDetails" : AgentEarningVo.toExampleApiJson(),
  //   
  // };
}