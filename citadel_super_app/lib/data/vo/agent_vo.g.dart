// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentVoImpl _$$AgentVoImplFromJson(Map<String, dynamic> json) =>
    _$AgentVoImpl(
      agentId: json['agentId'] as String?,
      agentName: json['agentName'] as String?,
      referralCode: json['referralCode'] as String?,
      agentRole: json['agentRole'] as String?,
      agentType: json['agentType'] as String?,
      agencyId: json['agencyId'] as String?,
      agencyName: json['agencyName'] as String?,
      recruitManagerId: json['recruitManagerId'] as String?,
      recruitManagerName: json['recruitManagerName'] as String?,
      joinedDate: (json['joinedDate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AgentVoImplToJson(_$AgentVoImpl instance) =>
    <String, dynamic>{
      'agentId': instance.agentId,
      'agentName': instance.agentName,
      'referralCode': instance.referralCode,
      'agentRole': instance.agentRole,
      'agentType': instance.agentType,
      'agencyId': instance.agencyId,
      'agencyName': instance.agencyName,
      'recruitManagerId': instance.recruitManagerId,
      'recruitManagerName': instance.recruitManagerName,
      'joinedDate': instance.joinedDate,
    };
