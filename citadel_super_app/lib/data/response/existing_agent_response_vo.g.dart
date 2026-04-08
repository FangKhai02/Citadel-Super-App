// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'existing_agent_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExistingAgentResponseVoImpl _$$ExistingAgentResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ExistingAgentResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      identityDetails: json['identityDetails'] == null
          ? null
          : SignUpBaseIdentityDetailsVo.fromJson(
              json['identityDetails'] as Map<String, dynamic>),
      contactDetails: json['contactDetails'] == null
          ? null
          : SignUpBaseContactDetailsVo.fromJson(
              json['contactDetails'] as Map<String, dynamic>),
      selfieImage: json['selfieImage'] as String?,
      agencyDetails: json['agencyDetails'] == null
          ? null
          : SignUpAgentAgencyDetailsRequestVo.fromJson(
              json['agencyDetails'] as Map<String, dynamic>),
      agencyCode: json['agencyCode'] as String?,
      bankDetails: json['bankDetails'] == null
          ? null
          : BankDetailsRequestVo.fromJson(
              json['bankDetails'] as Map<String, dynamic>),
      digitalSignature: json['digitalSignature'] as String?,
    );

Map<String, dynamic> _$$ExistingAgentResponseVoImplToJson(
        _$ExistingAgentResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'identityDetails': instance.identityDetails,
      'contactDetails': instance.contactDetails,
      'selfieImage': instance.selfieImage,
      'agencyDetails': instance.agencyDetails,
      'agencyCode': instance.agencyCode,
      'bankDetails': instance.bankDetails,
      'digitalSignature': instance.digitalSignature,
    };
