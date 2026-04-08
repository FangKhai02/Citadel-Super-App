// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pep_declaration_options_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PepDeclarationOptionsVoImpl _$$PepDeclarationOptionsVoImplFromJson(
        Map<String, dynamic> json) =>
    _$PepDeclarationOptionsVoImpl(
      relationship: json['relationship'] as String?,
      name: json['name'] as String?,
      position: json['position'] as String?,
      organization: json['organization'] as String?,
      supportingDocument: json['supportingDocument'] as String?,
    );

Map<String, dynamic> _$$PepDeclarationOptionsVoImplToJson(
        _$PepDeclarationOptionsVoImpl instance) =>
    <String, dynamic>{
      'relationship': instance.relationship,
      'name': instance.name,
      'position': instance.position,
      'organization': instance.organization,
      'supportingDocument': instance.supportingDocument,
    };
