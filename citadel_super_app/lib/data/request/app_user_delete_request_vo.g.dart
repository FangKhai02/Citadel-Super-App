// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_delete_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserDeleteRequestVoImpl _$$AppUserDeleteRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AppUserDeleteRequestVoImpl(
      name: json['name'] as String?,
      mobileCountryCode: json['mobileCountryCode'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      reason: json['reason'] as String?,
      pin: json['pin'] as String?,
    );

Map<String, dynamic> _$$AppUserDeleteRequestVoImplToJson(
        _$AppUserDeleteRequestVoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobileCountryCode': instance.mobileCountryCode,
      'mobileNumber': instance.mobileNumber,
      'reason': instance.reason,
      'pin': instance.pin,
    };
