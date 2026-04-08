// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_personal_details_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientPersonalDetailsRequestVoImpl
    _$$ClientPersonalDetailsRequestVoImplFromJson(Map<String, dynamic> json) =>
        _$ClientPersonalDetailsRequestVoImpl(
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
          maritalStatus: json['maritalStatus'] as String?,
          residentialStatus: json['residentialStatus'] as String?,
          agentReferralCode: json['agentReferralCode'] as String?,
        );

Map<String, dynamic> _$$ClientPersonalDetailsRequestVoImplToJson(
        _$ClientPersonalDetailsRequestVoImpl instance) =>
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
      'maritalStatus': instance.maritalStatus,
      'residentialStatus': instance.residentialStatus,
      'agentReferralCode': instance.agentReferralCode,
    };
