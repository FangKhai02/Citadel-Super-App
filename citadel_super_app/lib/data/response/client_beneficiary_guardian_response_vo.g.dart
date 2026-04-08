// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_beneficiary_guardian_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientBeneficiaryGuardianResponseVoImpl
    _$$ClientBeneficiaryGuardianResponseVoImplFromJson(
            Map<String, dynamic> json) =>
        _$ClientBeneficiaryGuardianResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          beneficiaries: (json['beneficiaries'] as List<dynamic>?)
              ?.map((e) =>
                  IndividualBeneficiaryVo.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$ClientBeneficiaryGuardianResponseVoImplToJson(
        _$ClientBeneficiaryGuardianResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'beneficiaries': instance.beneficiaries,
    };
