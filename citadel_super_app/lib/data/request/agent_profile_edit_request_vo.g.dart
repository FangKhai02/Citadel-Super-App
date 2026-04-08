// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_profile_edit_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentProfileEditRequestVoImpl _$$AgentProfileEditRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgentProfileEditRequestVoImpl(
      address: json['address'] as String?,
      postcode: json['postcode'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      mobileCountryCode: json['mobileCountryCode'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$AgentProfileEditRequestVoImplToJson(
        _$AgentProfileEditRequestVoImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'postcode': instance.postcode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'mobileCountryCode': instance.mobileCountryCode,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
    };
