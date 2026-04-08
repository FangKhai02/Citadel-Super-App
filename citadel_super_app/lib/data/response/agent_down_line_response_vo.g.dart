// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_down_line_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentDownLineResponseVoImpl _$$AgentDownLineResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgentDownLineResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      totalDownLine: (json['totalDownLine'] as num?)?.toInt(),
      newRecruitThisMonth: (json['newRecruitThisMonth'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AgentDownLineResponseVoImplToJson(
        _$AgentDownLineResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'totalDownLine': instance.totalDownLine,
      'newRecruitThisMonth': instance.newRecruitThisMonth,
    };
