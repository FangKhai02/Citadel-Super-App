// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_address_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateAddressDetailsVoImpl _$$CorporateAddressDetailsVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateAddressDetailsVoImpl(
      isDifferentRegisteredAddress:
          json['isDifferentRegisteredAddress'] as bool?,
      businessAddress: json['businessAddress'] as String?,
      businessPostcode: json['businessPostcode'] as String?,
      businessCity: json['businessCity'] as String?,
      businessState: json['businessState'] as String?,
      businessCountry: json['businessCountry'] as String?,
    );

Map<String, dynamic> _$$CorporateAddressDetailsVoImplToJson(
        _$CorporateAddressDetailsVoImpl instance) =>
    <String, dynamic>{
      'isDifferentRegisteredAddress': instance.isDifferentRegisteredAddress,
      'businessAddress': instance.businessAddress,
      'businessPostcode': instance.businessPostcode,
      'businessCity': instance.businessCity,
      'businessState': instance.businessState,
      'businessCountry': instance.businessCountry,
    };
