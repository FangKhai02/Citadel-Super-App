// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_agent_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientAgentDetailsVoImpl _$$ClientAgentDetailsVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientAgentDetailsVoImpl(
      agentName: json['agentName'] as String?,
      agentReferralCode: json['agentReferralCode'] as String?,
      agentId: json['agentId'] as String?,
      agencyName: json['agencyName'] as String?,
      agencyId: json['agencyId'] as String?,
      agentCountryCode: json['agentCountryCode'] as String?,
      agentMobileNumber: json['agentMobileNumber'] as String?,
    );

Map<String, dynamic> _$$ClientAgentDetailsVoImplToJson(
        _$ClientAgentDetailsVoImpl instance) =>
    <String, dynamic>{
      'agentName': instance.agentName,
      'agentReferralCode': instance.agentReferralCode,
      'agentId': instance.agentId,
      'agencyName': instance.agencyName,
      'agencyId': instance.agencyId,
      'agentCountryCode': instance.agentCountryCode,
      'agentMobileNumber': instance.agentMobileNumber,
    };
