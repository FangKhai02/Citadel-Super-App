// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_personal_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentPersonalDetailsVoImpl _$$AgentPersonalDetailsVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgentPersonalDetailsVoImpl(
      name: json['name'] as String?,
      identityDocumentType: json['identityDocumentType'] as String?,
      identityCardNumber: json['identityCardNumber'] as String?,
      dob: (json['dob'] as num?)?.toInt(),
      address: json['address'] as String?,
      postcode: json['postcode'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      mobileCountryCode: json['mobileCountryCode'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      email: json['email'] as String?,
      profilePicture: json['profilePicture'] as String?,
    );

Map<String, dynamic> _$$AgentPersonalDetailsVoImplToJson(
        _$AgentPersonalDetailsVoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'identityDocumentType': instance.identityDocumentType,
      'identityCardNumber': instance.identityCardNumber,
      'dob': instance.dob,
      'address': instance.address,
      'postcode': instance.postcode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'mobileCountryCode': instance.mobileCountryCode,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
      'profilePicture': instance.profilePicture,
    };
