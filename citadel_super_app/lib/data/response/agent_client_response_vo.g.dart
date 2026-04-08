// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_client_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentClientResponseVoImpl _$$AgentClientResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgentClientResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      totalClients: (json['totalClients'] as num?)?.toInt(),
      totalNewClients: (json['totalNewClients'] as num?)?.toInt(),
      clients: (json['clients'] as List<dynamic>?)
          ?.map((e) => AgentClientVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AgentClientResponseVoImplToJson(
        _$AgentClientResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'totalClients': instance.totalClients,
      'totalNewClients': instance.totalNewClients,
      'clients': instance.clients,
    };
