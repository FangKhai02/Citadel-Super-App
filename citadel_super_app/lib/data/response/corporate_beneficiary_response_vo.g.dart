// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_beneficiary_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateBeneficiaryResponseVoImpl
    _$$CorporateBeneficiaryResponseVoImplFromJson(Map<String, dynamic> json) =>
        _$CorporateBeneficiaryResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          corporateBeneficiary: json['corporateBeneficiary'] == null
              ? null
              : CorporateBeneficiaryVo.fromJson(
                  json['corporateBeneficiary'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$CorporateBeneficiaryResponseVoImplToJson(
        _$CorporateBeneficiaryResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'corporateBeneficiary': instance.corporateBeneficiary,
    };
