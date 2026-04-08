// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_client_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentClientVoImpl _$$AgentClientVoImplFromJson(Map<String, dynamic> json) =>
    _$AgentClientVoImpl(
      clientType: json['clientType'] as String?,
      name: json['name'] as String?,
      clientId: json['clientId'] as String?,
      joinedDate: (json['joinedDate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AgentClientVoImplToJson(_$AgentClientVoImpl instance) =>
    <String, dynamic>{
      'clientType': instance.clientType,
      'name': instance.name,
      'clientId': instance.clientId,
      'joinedDate': instance.joinedDate,
    };
