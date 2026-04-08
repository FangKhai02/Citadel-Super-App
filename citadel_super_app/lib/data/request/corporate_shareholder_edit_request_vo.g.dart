// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_shareholder_edit_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateShareholderEditRequestVoImpl
    _$$CorporateShareholderEditRequestVoImplFromJson(
            Map<String, dynamic> json) =>
        _$CorporateShareholderEditRequestVoImpl(
          corporateShareholderId:
              (json['corporateShareholderId'] as num?)?.toInt(),
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

Map<String, dynamic> _$$CorporateShareholderEditRequestVoImplToJson(
        _$CorporateShareholderEditRequestVoImpl instance) =>
    <String, dynamic>{
      'corporateShareholderId': instance.corporateShareholderId,
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
