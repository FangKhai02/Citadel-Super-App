// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_agents_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgencyAgentsResponseVoImpl _$$AgencyAgentsResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgencyAgentsResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      agentsList: (json['agentsList'] as List<dynamic>?)
          ?.map((e) => AgencyAgentVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AgencyAgentsResponseVoImplToJson(
        _$AgencyAgentsResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'agentsList': instance.agentsList,
    };
