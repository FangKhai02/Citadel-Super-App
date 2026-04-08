// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_beneficiary_base_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateBeneficiaryBaseVoImpl _$$CorporateBeneficiaryBaseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateBeneficiaryBaseVoImpl(
      corporateBeneficiaryId: (json['corporateBeneficiaryId'] as num?)?.toInt(),
      fullName: json['fullName'] as String?,
      relationshipToSettlor: json['relationshipToSettlor'] as String?,
      relationshipToGuardian: json['relationshipToGuardian'] as String?,
      isUnderAge: json['isUnderAge'] as bool?,
      corporateGuardianVo: json['corporateGuardianVo'] == null
          ? null
          : CorporateGuardianVo.fromJson(
              json['corporateGuardianVo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CorporateBeneficiaryBaseVoImplToJson(
        _$CorporateBeneficiaryBaseVoImpl instance) =>
    <String, dynamic>{
      'corporateBeneficiaryId': instance.corporateBeneficiaryId,
      'fullName': instance.fullName,
      'relationshipToSettlor': instance.relationshipToSettlor,
      'relationshipToGuardian': instance.relationshipToGuardian,
      'isUnderAge': instance.isUnderAge,
      'corporateGuardianVo': instance.corporateGuardianVo,
    };
