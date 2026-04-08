// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_down_line_product_order_commission_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentDownLineProductOrderCommissionDetailsVoImpl
    _$$AgentDownLineProductOrderCommissionDetailsVoImplFromJson(
            Map<String, dynamic> json) =>
        _$AgentDownLineProductOrderCommissionDetailsVoImpl(
          status: json['status'] as String?,
          agentName: json['agentName'] as String?,
          agentRole: json['agentRole'] as String?,
          commissionPercentage:
              (json['commissionPercentage'] as num?)?.toDouble(),
          commissionAmount: (json['commissionAmount'] as num?)?.toDouble(),
          calculatedDate: (json['calculatedDate'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$AgentDownLineProductOrderCommissionDetailsVoImplToJson(
        _$AgentDownLineProductOrderCommissionDetailsVoImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'agentName': instance.agentName,
      'agentRole': instance.agentRole,
      'commissionPercentage': instance.commissionPercentage,
      'commissionAmount': instance.commissionAmount,
      'calculatedDate': instance.calculatedDate,
    };
