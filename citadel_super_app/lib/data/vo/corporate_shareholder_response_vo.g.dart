// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_shareholder_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateShareholderResponseVoImpl
    _$$CorporateShareholderResponseVoImplFromJson(Map<String, dynamic> json) =>
        _$CorporateShareholderResponseVoImpl(
          id: (json['id'] as num?)?.toInt(),
          name: json['name'] as String?,
          percentageOfShareholdings:
              (json['percentageOfShareholdings'] as num?)?.toDouble(),
          mobileCountryCode: json['mobileCountryCode'] as String?,
          mobileNumber: json['mobileNumber'] as String?,
          email: json['email'] as String?,
          address: json['address'] as String?,
          postcode: json['postcode'] as String?,
          city: json['city'] as String?,
          state: json['state'] as String?,
          country: json['country'] as String?,
        );

Map<String, dynamic> _$$CorporateShareholderResponseVoImplToJson(
        _$CorporateShareholderResponseVoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'percentageOfShareholdings': instance.percentageOfShareholdings,
      'mobileCountryCode': instance.mobileCountryCode,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
      'address': instance.address,
      'postcode': instance.postcode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
    };
