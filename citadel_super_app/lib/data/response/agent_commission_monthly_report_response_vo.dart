// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agent_commission_monthly_report_response_vo.freezed.dart';
part 'agent_commission_monthly_report_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentCommissionMonthlyReportResponseVo with _$AgentCommissionMonthlyReportResponseVo {
  AgentCommissionMonthlyReportResponseVo._();

  factory AgentCommissionMonthlyReportResponseVo({
     String? code,
     String? message,
     String? agentCommissionMonthlyReport,
    
  }) = _AgentCommissionMonthlyReportResponseVo;
  
  factory AgentCommissionMonthlyReportResponseVo.fromJson(Map<String, dynamic> json) => _$AgentCommissionMonthlyReportResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "agentCommissionMonthlyReport" : 'string',
  //   
  // };
}