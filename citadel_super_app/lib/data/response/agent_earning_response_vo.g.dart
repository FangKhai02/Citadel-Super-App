// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_earning_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentEarningResponseVoImpl _$$AgentEarningResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgentEarningResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      earningDetails: (json['earningDetails'] as List<dynamic>?)
          ?.map((e) => AgentEarningVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AgentEarningResponseVoImplToJson(
        _$AgentEarningResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'earningDetails': instance.earningDetails,
    };
