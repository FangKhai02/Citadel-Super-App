// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_user_delete_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WebUserDeleteRequestVoImpl _$$WebUserDeleteRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$WebUserDeleteRequestVoImpl(
      email: json['email'] as String?,
      password: json['password'] as String?,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$$WebUserDeleteRequestVoImplToJson(
        _$WebUserDeleteRequestVoImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'reason': instance.reason,
    };
