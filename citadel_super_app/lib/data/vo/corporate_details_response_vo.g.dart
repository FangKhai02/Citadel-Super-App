// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_details_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateDetailsResponseVoImpl _$$CorporateDetailsResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateDetailsResponseVoImpl(
      entityName: json['entityName'] as String?,
      entityType: json['entityType'] as String?,
      registrationNumber: json['registrationNumber'] as String?,
      dateIncorporate: (json['dateIncorporate'] as num?)?.toInt(),
      placeIncorporate: json['placeIncorporate'] as String?,
      businessType: json['businessType'] as String?,
      registeredAddress: json['registeredAddress'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postcode: json['postcode'] as String?,
      country: json['country'] as String?,
      businessAddress: json['businessAddress'] as String?,
      businessPostcode: json['businessPostcode'] as String?,
      businessCity: json['businessCity'] as String?,
      businessState: json['businessState'] as String?,
      businessCountry: json['businessCountry'] as String?,
      contactName: json['contactName'] as String?,
      contactDesignation: json['contactDesignation'] as String?,
      contactCountryCode: json['contactCountryCode'] as String?,
      contactMobileNumber: json['contactMobileNumber'] as String?,
      contactEmail: json['contactEmail'] as String?,
    );

Map<String, dynamic> _$$CorporateDetailsResponseVoImplToJson(
        _$CorporateDetailsResponseVoImpl instance) =>
    <String, dynamic>{
      'entityName': instance.entityName,
      'entityType': instance.entityType,
      'registrationNumber': instance.registrationNumber,
      'dateIncorporate': instance.dateIncorporate,
      'placeIncorporate': instance.placeIncorporate,
      'businessType': instance.businessType,
      'registeredAddress': instance.registeredAddress,
      'city': instance.city,
      'state': instance.state,
      'postcode': instance.postcode,
      'country': instance.country,
      'businessAddress': instance.businessAddress,
      'businessPostcode': instance.businessPostcode,
      'businessCity': instance.businessCity,
      'businessState': instance.businessState,
      'businessCountry': instance.businessCountry,
      'contactName': instance.contactName,
      'contactDesignation': instance.contactDesignation,
      'contactCountryCode': instance.contactCountryCode,
      'contactMobileNumber': instance.contactMobileNumber,
      'contactEmail': instance.contactEmail,
    };
