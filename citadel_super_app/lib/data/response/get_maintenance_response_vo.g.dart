// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_maintenance_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetMaintenanceResponseVoImpl _$$GetMaintenanceResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$GetMaintenanceResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      startDatetime: json['startDatetime'] as String?,
      endDatetime: json['endDatetime'] as String?,
    );

Map<String, dynamic> _$$GetMaintenanceResponseVoImplToJson(
        _$GetMaintenanceResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'startDatetime': instance.startDatetime,
      'endDatetime': instance.endDatetime,
    };
