// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_compare_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FaceCompareResponseVoImpl _$$FaceCompareResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$FaceCompareResponseVoImpl(
      verified: json['verified'] as bool?,
      score: (json['score'] as num?)?.toDouble(),
      message: json['message'] as String?,
      degraded: json['degraded'] as bool?,
    );

Map<String, dynamic> _$$FaceCompareResponseVoImplToJson(
        _$FaceCompareResponseVoImpl instance) =>
    <String, dynamic>{
      'verified': instance.verified,
      'score': instance.score,
      'message': instance.message,
      'degraded': instance.degraded,
    };
