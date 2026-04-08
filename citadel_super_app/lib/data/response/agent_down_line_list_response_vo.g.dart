// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_down_line_list_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentDownLineListResponseVoImpl _$$AgentDownLineListResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgentDownLineListResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      agentDownLineList: (json['agentDownLineList'] as List<dynamic>?)
          ?.map((e) => AgentVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AgentDownLineListResponseVoImplToJson(
        _$AgentDownLineListResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'agentDownLineList': instance.agentDownLineList,
    };
