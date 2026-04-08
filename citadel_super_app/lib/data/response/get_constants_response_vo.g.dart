// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_constants_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetConstantsResponseVoImpl _$$GetConstantsResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$GetConstantsResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      constants: (json['constants'] as List<dynamic>?)
          ?.map((e) => ConstantVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$GetConstantsResponseVoImplToJson(
        _$GetConstantsResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'constants': instance.constants,
    };
