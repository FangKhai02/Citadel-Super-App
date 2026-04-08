// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_client_user_details_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateClientUserDetailsRequestVoImpl
    _$$CorporateClientUserDetailsRequestVoImplFromJson(
            Map<String, dynamic> json) =>
        _$CorporateClientUserDetailsRequestVoImpl(
          name: json['name'] as String?,
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
          identityCardFrontImageKey:
              json['identityCardFrontImageKey'] as String?,
          identityCardBackImageKey: json['identityCardBackImageKey'] as String?,
        );

Map<String, dynamic> _$$CorporateClientUserDetailsRequestVoImplToJson(
        _$CorporateClientUserDetailsRequestVoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
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
      'identityCardFrontImageKey': instance.identityCardFrontImageKey,
      'identityCardBackImageKey': instance.identityCardBackImageKey,
    };
