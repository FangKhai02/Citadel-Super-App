// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_pin_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientPinRequestVoImpl _$$ClientPinRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientPinRequestVoImpl(
      newPin: json['newPin'] as String?,
      oldPin: json['oldPin'] as String?,
    );

Map<String, dynamic> _$$ClientPinRequestVoImplToJson(
        _$ClientPinRequestVoImpl instance) =>
    <String, dynamic>{
      'newPin': instance.newPin,
      'oldPin': instance.oldPin,
    };
