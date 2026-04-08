// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_base_identity_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignUpBaseIdentityDetailsVoImpl _$$SignUpBaseIdentityDetailsVoImplFromJson(
        Map<String, dynamic> json) =>
    _$SignUpBaseIdentityDetailsVoImpl(
      fullName: json['fullName'] as String?,
      identityCardNumber: json['identityCardNumber'] as String?,
      dob: (json['dob'] as num?)?.toInt(),
      identityDocumentType: json['identityDocumentType'] as String?,
      identityCardFrontImage: json['identityCardFrontImage'] as String?,
      identityCardBackImage: json['identityCardBackImage'] as String?,
    );

Map<String, dynamic> _$$SignUpBaseIdentityDetailsVoImplToJson(
        _$SignUpBaseIdentityDetailsVoImpl instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'identityCardNumber': instance.identityCardNumber,
      'dob': instance.dob,
      'identityDocumentType': instance.identityDocumentType,
      'identityCardFrontImage': instance.identityCardFrontImage,
      'identityCardBackImage': instance.identityCardBackImage,
    };
