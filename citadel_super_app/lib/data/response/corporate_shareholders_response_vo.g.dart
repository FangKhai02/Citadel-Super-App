// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_shareholders_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateShareholdersResponseVoImpl
    _$$CorporateShareholdersResponseVoImplFromJson(Map<String, dynamic> json) =>
        _$CorporateShareholdersResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          draftShareholders: (json['draftShareholders'] as List<dynamic>?)
              ?.map((e) => CorporateShareholderBaseVo.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          mappedShareholders: (json['mappedShareholders'] as List<dynamic>?)
              ?.map((e) => CorporateShareholderBaseVo.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$CorporateShareholdersResponseVoImplToJson(
        _$CorporateShareholdersResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'draftShareholders': instance.draftShareholders,
      'mappedShareholders': instance.mappedShareholders,
    };
