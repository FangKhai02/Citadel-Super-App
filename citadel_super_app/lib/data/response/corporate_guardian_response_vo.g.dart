// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_guardian_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateGuardianResponseVoImpl _$$CorporateGuardianResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateGuardianResponseVoImpl(
      corporateGuardian: json['corporateGuardian'] == null
          ? null
          : CorporateGuardianBaseVo.fromJson(
              json['corporateGuardian'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CorporateGuardianResponseVoImplToJson(
        _$CorporateGuardianResponseVoImpl instance) =>
    <String, dynamic>{
      'corporateGuardian': instance.corporateGuardian,
    };
