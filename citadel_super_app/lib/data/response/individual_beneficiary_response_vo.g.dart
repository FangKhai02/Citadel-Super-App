// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individual_beneficiary_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IndividualBeneficiaryResponseVoImpl
    _$$IndividualBeneficiaryResponseVoImplFromJson(Map<String, dynamic> json) =>
        _$IndividualBeneficiaryResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          isUnderAge: json['isUnderAge'] as bool?,
          guardianVo: json['guardianVo'] == null
              ? null
              : GuardianVo.fromJson(json['guardianVo'] as Map<String, dynamic>),
          individualBeneficiaryId:
              (json['individualBeneficiaryId'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$IndividualBeneficiaryResponseVoImplToJson(
        _$IndividualBeneficiaryResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'isUnderAge': instance.isUnderAge,
      'guardianVo': instance.guardianVo,
      'individualBeneficiaryId': instance.individualBeneficiaryId,
    };
