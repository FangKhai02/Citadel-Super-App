// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'niu_get_application_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NiuGetApplicationResponseVoImpl _$$NiuGetApplicationResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$NiuGetApplicationResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      applications: (json['applications'] as List<dynamic>?)
          ?.map((e) =>
              NiuGetApplicationDetailsVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$NiuGetApplicationResponseVoImplToJson(
        _$NiuGetApplicationResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'applications': instance.applications,
    };
