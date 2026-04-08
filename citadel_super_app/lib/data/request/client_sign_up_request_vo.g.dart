// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_sign_up_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientSignUpRequestVoImpl _$$ClientSignUpRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientSignUpRequestVoImpl(
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
      password: json['password'] as String?,
    );

Map<String, dynamic> _$$ClientSignUpRequestVoImplToJson(
        _$ClientSignUpRequestVoImpl instance) =>
    <String, dynamic>{
      'identityDetails': instance.identityDetails,
      'personalDetails': instance.personalDetails,
      'selfieImage': instance.selfieImage,
      'pepDeclaration': instance.pepDeclaration,
      'employmentDetails': instance.employmentDetails,
      'digitalSignature': instance.digitalSignature,
      'password': instance.password,
    };
