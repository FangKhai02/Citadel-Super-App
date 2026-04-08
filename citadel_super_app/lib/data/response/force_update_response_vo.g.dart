// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'force_update_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ForceUpdateResponseVoImpl _$$ForceUpdateResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ForceUpdateResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      updateRequired: json['updateRequired'] as bool?,
      updateLink: json['updateLink'] as String?,
    );

Map<String, dynamic> _$$ForceUpdateResponseVoImplToJson(
        _$ForceUpdateResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'updateRequired': instance.updateRequired,
      'updateLink': instance.updateLink,
    };
