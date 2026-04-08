// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_order_beneficiary_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductOrderBeneficiaryVoImpl _$$ProductOrderBeneficiaryVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductOrderBeneficiaryVoImpl(
      beneficiaryId: (json['beneficiaryId'] as num?)?.toInt(),
      distributionPercentage:
          (json['distributionPercentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ProductOrderBeneficiaryVoImplToJson(
        _$ProductOrderBeneficiaryVoImpl instance) =>
    <String, dynamic>{
      'beneficiaryId': instance.beneficiaryId,
      'distributionPercentage': instance.distributionPercentage,
    };
