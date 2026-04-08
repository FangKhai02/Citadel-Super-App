// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individual_guardian_update_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IndividualGuardianUpdateRequestVoImpl
    _$$IndividualGuardianUpdateRequestVoImplFromJson(
            Map<String, dynamic> json) =>
        _$IndividualGuardianUpdateRequestVoImpl(
          fullName: json['fullName'] as String?,
          gender: json['gender'] as String?,
          nationality: json['nationality'] as String?,
          address: json['address'] as String?,
          postcode: json['postcode'] as String?,
          city: json['city'] as String?,
          state: json['state'] as String?,
          country: json['country'] as String?,
          residentialStatus: json['residentialStatus'] as String?,
          maritalStatus: json['maritalStatus'] as String?,
          mobileCountryCode: json['mobileCountryCode'] as String?,
          mobileNumber: json['mobileNumber'] as String?,
          email: json['email'] as String?,
        );

Map<String, dynamic> _$$IndividualGuardianUpdateRequestVoImplToJson(
        _$IndividualGuardianUpdateRequestVoImpl instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'gender': instance.gender,
      'nationality': instance.nationality,
      'address': instance.address,
      'postcode': instance.postcode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'residentialStatus': instance.residentialStatus,
      'maritalStatus': instance.maritalStatus,
      'mobileCountryCode': instance.mobileCountryCode,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
    };
