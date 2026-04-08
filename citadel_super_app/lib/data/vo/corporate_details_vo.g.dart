// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateDetailsVoImpl _$$CorporateDetailsVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateDetailsVoImpl(
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
      corporateAddressDetails: json['corporateAddressDetails'] == null
          ? null
          : CorporateAddressDetailsVo.fromJson(
              json['corporateAddressDetails'] as Map<String, dynamic>),
      contactName: json['contactName'] as String?,
      contactIsMyself: json['contactIsMyself'] as bool?,
      contactDesignation: json['contactDesignation'] as String?,
      contactCountryCode: json['contactCountryCode'] as String?,
      contactMobileNumber: json['contactMobileNumber'] as String?,
      contactEmail: json['contactEmail'] as String?,
    );

Map<String, dynamic> _$$CorporateDetailsVoImplToJson(
        _$CorporateDetailsVoImpl instance) =>
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
      'corporateAddressDetails': instance.corporateAddressDetails,
      'contactName': instance.contactName,
      'contactIsMyself': instance.contactIsMyself,
      'contactDesignation': instance.contactDesignation,
      'contactCountryCode': instance.contactCountryCode,
      'contactMobileNumber': instance.contactMobileNumber,
      'contactEmail': instance.contactEmail,
    };
