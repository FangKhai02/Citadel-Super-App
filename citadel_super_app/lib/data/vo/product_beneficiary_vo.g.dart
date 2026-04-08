// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_beneficiary_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductBeneficiaryVoImpl _$$ProductBeneficiaryVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductBeneficiaryVoImpl(
      beneficiaryId: (json['beneficiaryId'] as num?)?.toInt(),
      name: json['name'] as String?,
      distributionPercentage:
          (json['distributionPercentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ProductBeneficiaryVoImplToJson(
        _$ProductBeneficiaryVoImpl instance) =>
    <String, dynamic>{
      'beneficiaryId': instance.beneficiaryId,
      'name': instance.name,
      'distributionPercentage': instance.distributionPercentage,
    };
