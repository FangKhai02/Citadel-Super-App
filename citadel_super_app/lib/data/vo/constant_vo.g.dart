// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constant_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConstantVoImpl _$$ConstantVoImplFromJson(Map<String, dynamic> json) =>
    _$ConstantVoImpl(
      category: json['category'] as String?,
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => KeyValueMapVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ConstantVoImplToJson(_$ConstantVoImpl instance) =>
    <String, dynamic>{
      'category': instance.category,
      'list': instance.list,
    };
