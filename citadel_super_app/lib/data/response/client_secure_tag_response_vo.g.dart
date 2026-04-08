// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_secure_tag_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientSecureTagResponseVoImpl _$$ClientSecureTagResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientSecureTagResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      secureTag: json['secureTag'] == null
          ? null
          : ClientSecureTagVo.fromJson(
              json['secureTag'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ClientSecureTagResponseVoImplToJson(
        _$ClientSecureTagResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'secureTag': instance.secureTag,
    };
