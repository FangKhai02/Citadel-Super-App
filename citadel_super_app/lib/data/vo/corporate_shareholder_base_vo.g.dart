// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_shareholder_base_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateShareholderBaseVoImpl _$$CorporateShareholderBaseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateShareholderBaseVoImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      percentageOfShareholdings:
          (json['percentageOfShareholdings'] as num?)?.toDouble(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$CorporateShareholderBaseVoImplToJson(
        _$CorporateShareholderBaseVoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'percentageOfShareholdings': instance.percentageOfShareholdings,
      'status': instance.status,
    };
