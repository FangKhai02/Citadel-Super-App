// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_beneficiary_create_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateBeneficiaryCreateResponseVoImpl
    _$$CorporateBeneficiaryCreateResponseVoImplFromJson(
            Map<String, dynamic> json) =>
        _$CorporateBeneficiaryCreateResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          isUnderAge: json['isUnderAge'] as bool?,
          corporateBeneficiaryId:
              (json['corporateBeneficiaryId'] as num?)?.toInt(),
          corporateGuardianBaseVo: json['corporateGuardianBaseVo'] == null
              ? null
              : CorporateGuardianBaseVo.fromJson(
                  json['corporateGuardianBaseVo'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$CorporateBeneficiaryCreateResponseVoImplToJson(
        _$CorporateBeneficiaryCreateResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'isUnderAge': instance.isUnderAge,
      'corporateBeneficiaryId': instance.corporateBeneficiaryId,
      'corporateGuardianBaseVo': instance.corporateGuardianBaseVo,
    };
