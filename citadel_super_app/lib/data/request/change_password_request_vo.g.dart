// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChangePasswordRequestVoImpl _$$ChangePasswordRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ChangePasswordRequestVoImpl(
      oldPassword: json['oldPassword'] as String?,
      newPassword: json['newPassword'] as String?,
    );

Map<String, dynamic> _$$ChangePasswordRequestVoImplToJson(
        _$ChangePasswordRequestVoImpl instance) =>
    <String, dynamic>{
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
    };
