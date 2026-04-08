// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_personal_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientPersonalDetailsVoImpl _$$ClientPersonalDetailsVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientPersonalDetailsVoImpl(
      name: json['name'] as String?,
      identityDocumentType: json['identityDocumentType'] as String?,
      identityCardNumber: json['identityCardNumber'] as String?,
      dob: (json['dob'] as num?)?.toInt(),
      address: json['address'] as String?,
      postcode: json['postcode'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      correspondingAddress: json['correspondingAddress'] == null
          ? null
          : CorrespondingAddress.fromJson(
              json['correspondingAddress'] as Map<String, dynamic>),
      nationality: json['nationality'] as String?,
      mobileCountryCode: json['mobileCountryCode'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      residentialStatus: json['residentialStatus'] as String?,
      profilePicture: json['profilePicture'] as String?,
    );

Map<String, dynamic> _$$ClientPersonalDetailsVoImplToJson(
        _$ClientPersonalDetailsVoImpl instance) =>
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
      'correspondingAddress': instance.correspondingAddress,
      'nationality': instance.nationality,
      'mobileCountryCode': instance.mobileCountryCode,
      'mobileNumber': instance.mobileNumber,
      'gender': instance.gender,
      'email': instance.email,
      'maritalStatus': instance.maritalStatus,
      'residentialStatus': instance.residentialStatus,
      'profilePicture': instance.profilePicture,
    };
