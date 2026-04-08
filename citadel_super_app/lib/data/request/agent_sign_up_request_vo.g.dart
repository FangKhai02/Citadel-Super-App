// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_sign_up_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentSignUpRequestVoImpl _$$AgentSignUpRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgentSignUpRequestVoImpl(
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
      bankDetails: json['bankDetails'] == null
          ? null
          : BankDetailsRequestVo.fromJson(
              json['bankDetails'] as Map<String, dynamic>),
      digitalSignature: json['digitalSignature'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$$AgentSignUpRequestVoImplToJson(
        _$AgentSignUpRequestVoImpl instance) =>
    <String, dynamic>{
      'identityDetails': instance.identityDetails,
      'contactDetails': instance.contactDetails,
      'selfieImage': instance.selfieImage,
      'agencyDetails': instance.agencyDetails,
      'bankDetails': instance.bankDetails,
      'digitalSignature': instance.digitalSignature,
      'password': instance.password,
    };
