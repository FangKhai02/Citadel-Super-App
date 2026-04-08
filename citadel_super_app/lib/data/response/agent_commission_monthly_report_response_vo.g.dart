// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_commission_monthly_report_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentCommissionMonthlyReportResponseVoImpl
    _$$AgentCommissionMonthlyReportResponseVoImplFromJson(
            Map<String, dynamic> json) =>
        _$AgentCommissionMonthlyReportResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          agentCommissionMonthlyReport:
              json['agentCommissionMonthlyReport'] as String?,
        );

Map<String, dynamic> _$$AgentCommissionMonthlyReportResponseVoImplToJson(
        _$AgentCommissionMonthlyReportResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'agentCommissionMonthlyReport': instance.agentCommissionMonthlyReport,
    };
