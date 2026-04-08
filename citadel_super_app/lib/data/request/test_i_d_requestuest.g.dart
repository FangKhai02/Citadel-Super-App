// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_i_d_requestuest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TestIDRequestuestImpl _$$TestIDRequestuestImplFromJson(
        Map<String, dynamic> json) =>
    _$TestIDRequestuestImpl(
      longIds: (json['longIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$$TestIDRequestuestImplToJson(
        _$TestIDRequestuestImpl instance) =>
    <String, dynamic>{
      'longIds': instance.longIds,
    };
