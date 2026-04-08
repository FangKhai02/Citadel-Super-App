// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_beneficiary_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FundBeneficiaryDetailsVoImpl _$$FundBeneficiaryDetailsVoImplFromJson(
        Map<String, dynamic> json) =>
    _$FundBeneficiaryDetailsVoImpl(
      beneficiaryId: (json['beneficiaryId'] as num?)?.toInt(),
      beneficiaryName: json['beneficiaryName'] as String?,
      relationship: json['relationship'] as String?,
      distributionPercentage:
          (json['distributionPercentage'] as num?)?.toDouble(),
      subBeneficiaries: (json['subBeneficiaries'] as List<dynamic>?)
          ?.map((e) =>
              FundBeneficiaryDetailsVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FundBeneficiaryDetailsVoImplToJson(
        _$FundBeneficiaryDetailsVoImpl instance) =>
    <String, dynamic>{
      'beneficiaryId': instance.beneficiaryId,
      'beneficiaryName': instance.beneficiaryName,
      'relationship': instance.relationship,
      'distributionPercentage': instance.distributionPercentage,
      'subBeneficiaries': instance.subBeneficiaries,
    };
