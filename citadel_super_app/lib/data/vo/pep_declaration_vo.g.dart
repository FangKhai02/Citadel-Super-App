// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pep_declaration_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PepDeclarationVoImpl _$$PepDeclarationVoImplFromJson(
        Map<String, dynamic> json) =>
    _$PepDeclarationVoImpl(
      isPep: json['isPep'] as bool?,
      pepDeclarationOptions: json['pepDeclarationOptions'] == null
          ? null
          : PepDeclarationOptionsVo.fromJson(
              json['pepDeclarationOptions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PepDeclarationVoImplToJson(
        _$PepDeclarationVoImpl instance) =>
    <String, dynamic>{
      'isPep': instance.isPep,
      'pepDeclarationOptions': instance.pepDeclarationOptions,
    };
