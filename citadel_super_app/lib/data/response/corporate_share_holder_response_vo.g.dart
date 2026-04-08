// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_share_holder_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateShareHolderResponseVoImpl
    _$$CorporateShareHolderResponseVoImplFromJson(Map<String, dynamic> json) =>
        _$CorporateShareHolderResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          corporateShareholder: json['corporateShareholder'] == null
              ? null
              : CorporateShareholderVo.fromJson(
                  json['corporateShareholder'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$CorporateShareHolderResponseVoImplToJson(
        _$CorporateShareHolderResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'corporateShareholder': instance.corporateShareholder,
    };
