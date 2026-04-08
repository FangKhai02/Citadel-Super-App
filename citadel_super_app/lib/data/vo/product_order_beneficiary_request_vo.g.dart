// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_order_beneficiary_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductOrderBeneficiaryRequestVoImpl
    _$$ProductOrderBeneficiaryRequestVoImplFromJson(
            Map<String, dynamic> json) =>
        _$ProductOrderBeneficiaryRequestVoImpl(
          beneficiaryId: (json['beneficiaryId'] as num?)?.toInt(),
          distributionPercentage:
              (json['distributionPercentage'] as num?)?.toDouble(),
          subBeneficiaries: (json['subBeneficiaries'] as List<dynamic>?)
              ?.map((e) => ProductOrderBeneficiaryRequestVo.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$ProductOrderBeneficiaryRequestVoImplToJson(
        _$ProductOrderBeneficiaryRequestVoImpl instance) =>
    <String, dynamic>{
      'beneficiaryId': instance.beneficiaryId,
      'distributionPercentage': instance.distributionPercentage,
      'subBeneficiaries': instance.subBeneficiaries,
    };
