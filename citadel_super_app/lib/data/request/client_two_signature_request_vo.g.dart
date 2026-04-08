// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_two_signature_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientTwoSignatureRequestVoImpl _$$ClientTwoSignatureRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientTwoSignatureRequestVoImpl(
      uniqueIdentifier: json['uniqueIdentifier'] as String?,
      signatureImage: json['signatureImage'] as String?,
      name: json['name'] as String?,
      idNumber: json['idNumber'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$$ClientTwoSignatureRequestVoImplToJson(
        _$ClientTwoSignatureRequestVoImpl instance) =>
    <String, dynamic>{
      'uniqueIdentifier': instance.uniqueIdentifier,
      'signatureImage': instance.signatureImage,
      'name': instance.name,
      'idNumber': instance.idNumber,
      'role': instance.role,
    };
