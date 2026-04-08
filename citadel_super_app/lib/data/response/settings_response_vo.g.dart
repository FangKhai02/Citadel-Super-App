// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsResponseVoImpl _$$SettingsResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$SettingsResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      settings: (json['settings'] as List<dynamic>?)
          ?.map((e) => SettingsItemVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$SettingsResponseVoImplToJson(
        _$SettingsResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'settings': instance.settings,
    };
