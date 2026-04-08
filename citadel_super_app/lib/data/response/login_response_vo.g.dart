// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginResponseVoImpl _$$LoginResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      apiKey: json['apiKey'] as String?,
      hasPin: json['hasPin'] as bool?,
      userType: json['userType'] as String?,
    );

Map<String, dynamic> _$$LoginResponseVoImplToJson(
        _$LoginResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'apiKey': instance.apiKey,
      'hasPin': instance.hasPin,
      'userType': instance.userType,
    };
