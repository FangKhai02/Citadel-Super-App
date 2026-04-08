// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_documents_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateDocumentsRequestVoImpl _$$CorporateDocumentsRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateDocumentsRequestVoImpl(
      corporateDocuments: (json['corporateDocuments'] as List<dynamic>?)
          ?.map((e) => CorporateDocumentsVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CorporateDocumentsRequestVoImplToJson(
        _$CorporateDocumentsRequestVoImpl instance) =>
    <String, dynamic>{
      'corporateDocuments': instance.corporateDocuments,
    };
