// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_pep_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientPepResponseVoImpl _$$ClientPepResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientPepResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      pepDeclaration: json['pepDeclaration'] == null
          ? null
          : PepDeclarationVo.fromJson(
              json['pepDeclaration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ClientPepResponseVoImplToJson(
        _$ClientPepResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'pepDeclaration': instance.pepDeclaration,
    };
