// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResetPasswordRequestVoImpl _$$ResetPasswordRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ResetPasswordRequestVoImpl(
      email: json['email'] as String?,
      password: json['password'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$$ResetPasswordRequestVoImplToJson(
        _$ResetPasswordRequestVoImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'token': instance.token,
    };
