// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_shareholder_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateShareholderVoImpl _$$CorporateShareholderVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateShareholderVoImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      percentageOfShareholdings:
          (json['percentageOfShareholdings'] as num?)?.toDouble(),
      status: json['status'] as String?,
      mobileCountryCode: json['mobileCountryCode'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      postcode: json['postcode'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      pepDeclaration: json['pepDeclaration'] == null
          ? null
          : PepDeclarationVo.fromJson(
              json['pepDeclaration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CorporateShareholderVoImplToJson(
        _$CorporateShareholderVoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'percentageOfShareholdings': instance.percentageOfShareholdings,
      'status': instance.status,
      'mobileCountryCode': instance.mobileCountryCode,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
      'address': instance.address,
      'postcode': instance.postcode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'pepDeclaration': instance.pepDeclaration,
    };
