// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_user_details_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientUserDetailsRequestVoImpl _$$ClientUserDetailsRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientUserDetailsRequestVoImpl(
      fullName: json['fullName'] as String?,
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
      identityCardImage: json['identityCardImage'] as String?,
      idType: json['idType'] as String?,
      gender: json['gender'] as String?,
      nationality: json['nationality'] as String?,
      residentialStatus: json['residentialStatus'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      agentReferralCode: json['agentReferralCode'] as String?,
    );

Map<String, dynamic> _$$ClientUserDetailsRequestVoImplToJson(
        _$ClientUserDetailsRequestVoImpl instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
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
      'identityCardImage': instance.identityCardImage,
      'idType': instance.idType,
      'gender': instance.gender,
      'nationality': instance.nationality,
      'residentialStatus': instance.residentialStatus,
      'maritalStatus': instance.maritalStatus,
      'agentReferralCode': instance.agentReferralCode,
    };
