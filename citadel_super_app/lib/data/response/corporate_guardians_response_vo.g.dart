// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_guardians_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateGuardiansResponseVoImpl _$$CorporateGuardiansResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateGuardiansResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      corporateGuardians: (json['corporateGuardians'] as List<dynamic>?)
          ?.map((e) =>
              CorporateGuardianBaseVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CorporateGuardiansResponseVoImplToJson(
        _$CorporateGuardiansResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'corporateGuardians': instance.corporateGuardians,
    };
