// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_documents_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateDocumentsVoImpl _$$CorporateDocumentsVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateDocumentsVoImpl(
      id: (json['id'] as num?)?.toInt(),
      fileName: json['fileName'] as String?,
      file: json['file'] as String?,
    );

Map<String, dynamic> _$$CorporateDocumentsVoImplToJson(
        _$CorporateDocumentsVoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'file': instance.file,
    };
