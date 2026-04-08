// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_total_sales_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentTotalSalesResponseVoImpl _$$AgentTotalSalesResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgentTotalSalesResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      totalSalesAmount: json['totalSalesAmount'] as String?,
      percentageDifference: json['percentageDifference'] as String?,
      currentQuarterStartDate:
          (json['currentQuarterStartDate'] as num?)?.toInt(),
      currentQuarterEndDate: (json['currentQuarterEndDate'] as num?)?.toInt(),
      paymentMethod: json['paymentMethod'] as String?,
      totalProductsSold: (json['totalProductsSold'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AgentTotalSalesResponseVoImplToJson(
        _$AgentTotalSalesResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'totalSalesAmount': instance.totalSalesAmount,
      'percentageDifference': instance.percentageDifference,
      'currentQuarterStartDate': instance.currentQuarterStartDate,
      'currentQuarterEndDate': instance.currentQuarterEndDate,
      'paymentMethod': instance.paymentMethod,
      'totalProductsSold': instance.totalProductsSold,
    };
