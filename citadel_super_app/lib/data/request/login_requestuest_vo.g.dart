// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_requestuest_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestuestVoImpl _$$LoginRequestuestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$LoginRequestuestVoImpl(
      email: json['email'] as String?,
      password: json['password'] as String?,
      oneSignalSubscriptionId: json['oneSignalSubscriptionId'] as String?,
    );

Map<String, dynamic> _$$LoginRequestuestVoImplToJson(
        _$LoginRequestuestVoImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'oneSignalSubscriptionId': instance.oneSignalSubscriptionId,
    };
