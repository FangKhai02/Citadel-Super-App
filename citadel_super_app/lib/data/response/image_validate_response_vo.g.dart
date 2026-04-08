// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_validate_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageValidateResponseVoImpl _$$ImageValidateResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ImageValidateResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      valid: json['valid'] as bool?,
      confidence: (json['confidence'] as num?)?.toDouble(),
      livenessScore: (json['livenessScore'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ImageValidateResponseVoImplToJson(
        _$ImageValidateResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'valid': instance.valid,
      'confidence': instance.confidence,
      'livenessScore': instance.livenessScore,
    };
