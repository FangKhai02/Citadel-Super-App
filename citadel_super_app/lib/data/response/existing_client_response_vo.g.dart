// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'existing_client_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExistingClientResponseVoImpl _$$ExistingClientResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ExistingClientResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      identityDetails: json['identityDetails'] == null
          ? null
          : ClientIdentityDetailsRequestVo.fromJson(
              json['identityDetails'] as Map<String, dynamic>),
      personalDetails: json['personalDetails'] == null
          ? null
          : ClientPersonalDetailsRequestVo.fromJson(
              json['personalDetails'] as Map<String, dynamic>),
      selfieImage: json['selfieImage'] as String?,
      pepDeclaration: json['pepDeclaration'] == null
          ? null
          : PepDeclarationVo.fromJson(
              json['pepDeclaration'] as Map<String, dynamic>),
      employmentDetails: json['employmentDetails'] == null
          ? null
          : EmploymentDetailsVo.fromJson(
              json['employmentDetails'] as Map<String, dynamic>),
      digitalSignature: json['digitalSignature'] as String?,
      agentReferralCode: json['agentReferralCode'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$$ExistingClientResponseVoImplToJson(
        _$ExistingClientResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'identityDetails': instance.identityDetails,
      'personalDetails': instance.personalDetails,
      'selfieImage': instance.selfieImage,
      'pepDeclaration': instance.pepDeclaration,
      'employmentDetails': instance.employmentDetails,
      'digitalSignature': instance.digitalSignature,
      'agentReferralCode': instance.agentReferralCode,
      'password': instance.password,
    };
