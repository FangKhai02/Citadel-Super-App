// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agents_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentsResponseVoImpl _$$AgentsResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgentsResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      agentsList: (json['agentsList'] as List<dynamic>?)
          ?.map((e) => AgentVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AgentsResponseVoImplToJson(
        _$AgentsResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'agentsList': instance.agentsList,
    };
