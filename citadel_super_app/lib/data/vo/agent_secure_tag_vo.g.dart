// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_secure_tag_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentSecureTagVoImpl _$$AgentSecureTagVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgentSecureTagVoImpl(
      status: json['status'] as String?,
      clientName: json['clientName'] as String?,
      clientId: json['clientId'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$$AgentSecureTagVoImplToJson(
        _$AgentSecureTagVoImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'clientName': instance.clientName,
      'clientId': instance.clientId,
      'token': instance.token,
    };
