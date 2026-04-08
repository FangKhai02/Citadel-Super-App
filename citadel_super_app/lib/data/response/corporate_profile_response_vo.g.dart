// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_profile_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateProfileResponseVoImpl _$$CorporateProfileResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateProfileResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      corporateClient: json['corporateClient'] == null
          ? null
          : CorporateClientVo.fromJson(
              json['corporateClient'] as Map<String, dynamic>),
      corporateDetails: json['corporateDetails'] == null
          ? null
          : CorporateDetailsVo.fromJson(
              json['corporateDetails'] as Map<String, dynamic>),
      corporateDocuments: (json['corporateDocuments'] as List<dynamic>?)
          ?.map((e) => CorporateDocumentsVo.fromJson(e as Map<String, dynamic>))
          .toList(),
      bindedCorporateShareholders: (json['bindedCorporateShareholders']
              as List<dynamic>?)
          ?.map((e) =>
              CorporateShareholderBaseVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CorporateProfileResponseVoImplToJson(
        _$CorporateProfileResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'corporateClient': instance.corporateClient,
      'corporateDetails': instance.corporateDetails,
      'corporateDocuments': instance.corporateDocuments,
      'bindedCorporateShareholders': instance.bindedCorporateShareholders,
    };
