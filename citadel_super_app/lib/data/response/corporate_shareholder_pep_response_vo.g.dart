// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_shareholder_pep_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateShareholderPepResponseVoImpl
    _$$CorporateShareholderPepResponseVoImplFromJson(
            Map<String, dynamic> json) =>
        _$CorporateShareholderPepResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          pepDeclaration: json['pepDeclaration'] == null
              ? null
              : PepDeclarationVo.fromJson(
                  json['pepDeclaration'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$CorporateShareholderPepResponseVoImplToJson(
        _$CorporateShareholderPepResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'pepDeclaration': instance.pepDeclaration,
    };
