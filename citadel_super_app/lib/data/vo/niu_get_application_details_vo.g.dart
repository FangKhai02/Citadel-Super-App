// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'niu_get_application_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NiuGetApplicationDetailsVoImpl _$$NiuGetApplicationDetailsVoImplFromJson(
        Map<String, dynamic> json) =>
    _$NiuGetApplicationDetailsVoImpl(
      applicationType: json['applicationType'] as String?,
      amountRequested: (json['amountRequested'] as num?)?.toInt(),
      requestedOn: json['requestedOn'] as String?,
      name: json['name'] as String?,
      documentNumber: json['documentNumber'] as String?,
      fullAddress: json['fullAddress'] as String?,
      fullMobileNumber: json['fullMobileNumber'] as String?,
      email: json['email'] as String?,
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => NiuGetDocumentVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$NiuGetApplicationDetailsVoImplToJson(
        _$NiuGetApplicationDetailsVoImpl instance) =>
    <String, dynamic>{
      'applicationType': instance.applicationType,
      'amountRequested': instance.amountRequested,
      'requestedOn': instance.requestedOn,
      'name': instance.name,
      'documentNumber': instance.documentNumber,
      'fullAddress': instance.fullAddress,
      'fullMobileNumber': instance.fullMobileNumber,
      'email': instance.email,
      'documents': instance.documents,
    };
