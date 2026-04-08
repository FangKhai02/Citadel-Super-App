// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_beneficiaries_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateBeneficiariesResponseVoImpl
    _$$CorporateBeneficiariesResponseVoImplFromJson(
            Map<String, dynamic> json) =>
        _$CorporateBeneficiariesResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          corporateBeneficiaries:
              (json['corporateBeneficiaries'] as List<dynamic>?)
                  ?.map((e) => CorporateBeneficiaryBaseVo.fromJson(
                      e as Map<String, dynamic>))
                  .toList(),
        );

Map<String, dynamic> _$$CorporateBeneficiariesResponseVoImplToJson(
        _$CorporateBeneficiariesResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'corporateBeneficiaries': instance.corporateBeneficiaries,
    };
