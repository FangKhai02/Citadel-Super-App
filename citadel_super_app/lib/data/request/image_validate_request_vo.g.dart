// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_validate_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ImageValidateRequestVoImpl _$$ImageValidateRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ImageValidateRequestVoImpl(
      idPhoto: json['idPhoto'] as String?,
      selfie: json['selfie'] as String?,
      idNumber: json['idNumber'] as String?,
      confidence: (json['confidence'] as num?)?.toDouble(),
      livenessScore: (json['livenessScore'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ImageValidateRequestVoImplToJson(
        _$ImageValidateRequestVoImpl instance) =>
    <String, dynamic>{
      'idPhoto': instance.idPhoto,
      'selfie': instance.selfie,
      'idNumber': instance.idNumber,
      'confidence': instance.confidence,
      'livenessScore': instance.livenessScore,
    };
