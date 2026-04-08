// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_profile_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientProfileResponseVoImpl _$$ClientProfileResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientProfileResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      clientId: json['clientId'] as String?,
      personalDetails: json['personalDetails'] == null
          ? null
          : ClientPersonalDetailsVo.fromJson(
              json['personalDetails'] as Map<String, dynamic>),
      employmentDetails: json['employmentDetails'] == null
          ? null
          : ClientEmploymentDetailsVo.fromJson(
              json['employmentDetails'] as Map<String, dynamic>),
      wealthSourceDetails: json['wealthSourceDetails'] == null
          ? null
          : ClientWealthSourceDetailsVo.fromJson(
              json['wealthSourceDetails'] as Map<String, dynamic>),
      agentDetails: json['agentDetails'] == null
          ? null
          : ClientAgentDetailsVo.fromJson(
              json['agentDetails'] as Map<String, dynamic>),
      pepDeclaration: json['pepDeclaration'] == null
          ? null
          : PepDeclarationVo.fromJson(
              json['pepDeclaration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ClientProfileResponseVoImplToJson(
        _$ClientProfileResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'clientId': instance.clientId,
      'personalDetails': instance.personalDetails,
      'employmentDetails': instance.employmentDetails,
      'wealthSourceDetails': instance.wealthSourceDetails,
      'agentDetails': instance.agentDetails,
      'pepDeclaration': instance.pepDeclaration,
    };
