// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_share_holder_add_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateShareHolderAddVoImpl _$$CorporateShareHolderAddVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateShareHolderAddVoImpl(
      id: (json['id'] as num?)?.toInt(),
      percentageOfShareholdings:
          (json['percentageOfShareholdings'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$CorporateShareHolderAddVoImplToJson(
        _$CorporateShareHolderAddVoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'percentageOfShareholdings': instance.percentageOfShareholdings,
    };
