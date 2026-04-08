// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_list_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgencyListResponseVoImpl _$$AgencyListResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgencyListResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      agencyList: (json['agencyList'] as List<dynamic>?)
          ?.map((e) => AgencyVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AgencyListResponseVoImplToJson(
        _$AgencyListResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'agencyList': instance.agencyList,
    };
