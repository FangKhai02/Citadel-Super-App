// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_identity_details_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientIdentityDetailsRequestVoImpl
    _$$ClientIdentityDetailsRequestVoImplFromJson(Map<String, dynamic> json) =>
        _$ClientIdentityDetailsRequestVoImpl(
          fullName: json['fullName'] as String?,
          identityCardNumber: json['identityCardNumber'] as String?,
          dob: (json['dob'] as num?)?.toInt(),
          identityDocumentType: json['identityDocumentType'] as String?,
          identityCardFrontImage: json['identityCardFrontImage'] as String?,
          identityCardBackImage: json['identityCardBackImage'] as String?,
          gender: json['gender'] as String?,
          nationality: json['nationality'] as String?,
        );

Map<String, dynamic> _$$ClientIdentityDetailsRequestVoImplToJson(
        _$ClientIdentityDetailsRequestVoImpl instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'identityCardNumber': instance.identityCardNumber,
      'dob': instance.dob,
      'identityDocumentType': instance.identityDocumentType,
      'identityCardFrontImage': instance.identityCardFrontImage,
      'identityCardBackImage': instance.identityCardBackImage,
      'gender': instance.gender,
      'nationality': instance.nationality,
    };
