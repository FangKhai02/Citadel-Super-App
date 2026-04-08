// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_director_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateDirectorResponseVoImpl _$$CorporateDirectorResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateDirectorResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      personalDetails: json['personalDetails'] == null
          ? null
          : ClientPersonalDetailsVo.fromJson(
              json['personalDetails'] as Map<String, dynamic>),
      pepInfo: json['pepInfo'] == null
          ? null
          : PepDeclarationVo.fromJson(json['pepInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CorporateDirectorResponseVoImplToJson(
        _$CorporateDirectorResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'personalDetails': instance.personalDetails,
      'pepInfo': instance.pepInfo,
    };
