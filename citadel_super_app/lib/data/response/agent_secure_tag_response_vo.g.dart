// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_secure_tag_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentSecureTagResponseVoImpl _$$AgentSecureTagResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgentSecureTagResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      secureTag: json['secureTag'] == null
          ? null
          : AgentSecureTagVo.fromJson(
              json['secureTag'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AgentSecureTagResponseVoImplToJson(
        _$AgentSecureTagResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'secureTag': instance.secureTag,
    };
