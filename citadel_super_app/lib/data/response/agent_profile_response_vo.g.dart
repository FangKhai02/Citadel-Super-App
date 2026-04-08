// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_profile_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentProfileResponseVoImpl _$$AgentProfileResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgentProfileResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      personalDetails: json['personalDetails'] == null
          ? null
          : AgentPersonalDetailsVo.fromJson(
              json['personalDetails'] as Map<String, dynamic>),
      agentDetails: json['agentDetails'] == null
          ? null
          : AgentVo.fromJson(json['agentDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AgentProfileResponseVoImplToJson(
        _$AgentProfileResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'personalDetails': instance.personalDetails,
      'agentDetails': instance.agentDetails,
    };
