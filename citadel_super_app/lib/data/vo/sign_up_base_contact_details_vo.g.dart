// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_base_contact_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignUpBaseContactDetailsVoImpl _$$SignUpBaseContactDetailsVoImplFromJson(
        Map<String, dynamic> json) =>
    _$SignUpBaseContactDetailsVoImpl(
      address: json['address'] as String?,
      postcode: json['postcode'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      correspondingAddress: json['correspondingAddress'] == null
          ? null
          : CorrespondingAddress.fromJson(
              json['correspondingAddress'] as Map<String, dynamic>),
      mobileCountryCode: json['mobileCountryCode'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      email: json['email'] as String?,
      proofOfAddressFile: json['proofOfAddressFile'] as String?,
    );

Map<String, dynamic> _$$SignUpBaseContactDetailsVoImplToJson(
        _$SignUpBaseContactDetailsVoImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'postcode': instance.postcode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'correspondingAddress': instance.correspondingAddress,
      'mobileCountryCode': instance.mobileCountryCode,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
      'proofOfAddressFile': instance.proofOfAddressFile,
    };
