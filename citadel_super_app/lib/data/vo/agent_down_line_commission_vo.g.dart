// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_down_line_commission_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentDownLineCommissionVoImpl _$$AgentDownLineCommissionVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgentDownLineCommissionVoImpl(
      productCode: json['productCode'] as String?,
      commissionList: (json['commissionList'] as List<dynamic>?)
          ?.map((e) => AgentDownLineProductOrderCommissionDetailsVo.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AgentDownLineCommissionVoImplToJson(
        _$AgentDownLineCommissionVoImpl instance) =>
    <String, dynamic>{
      'productCode': instance.productCode,
      'commissionList': instance.commissionList,
    };
