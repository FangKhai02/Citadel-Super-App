// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_documents_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateDocumentsResponseVoImpl _$$CorporateDocumentsResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateDocumentsResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      corporateDocuments: (json['corporateDocuments'] as List<dynamic>?)
          ?.map((e) => CorporateDocumentsVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CorporateDocumentsResponseVoImplToJson(
        _$CorporateDocumentsResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'corporateDocuments': instance.corporateDocuments,
    };
