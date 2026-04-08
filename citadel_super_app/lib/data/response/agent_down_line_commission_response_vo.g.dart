// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_down_line_commission_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentDownLineCommissionResponseVoImpl
    _$$AgentDownLineCommissionResponseVoImplFromJson(
            Map<String, dynamic> json) =>
        _$AgentDownLineCommissionResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          downLineCommissionList: (json['downLineCommissionList']
                  as List<dynamic>?)
              ?.map((e) =>
                  AgentDownLineCommissionVo.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$AgentDownLineCommissionResponseVoImplToJson(
        _$AgentDownLineCommissionResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'downLineCommissionList': instance.downLineCommissionList,
    };
