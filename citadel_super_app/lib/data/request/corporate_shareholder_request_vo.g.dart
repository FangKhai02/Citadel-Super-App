// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_shareholder_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateShareholderRequestVoImpl
    _$$CorporateShareholderRequestVoImplFromJson(Map<String, dynamic> json) =>
        _$CorporateShareholderRequestVoImpl(
          name: json['name'] as String?,
          identityCardNumber: json['identityCardNumber'] as String?,
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
          identityDocumentType: json['identityDocumentType'] as String?,
          identityCardFrontImage: json['identityCardFrontImage'] as String?,
          identityCardBackImage: json['identityCardBackImage'] as String?,
          pepDeclaration: json['pepDeclaration'] == null
              ? null
              : PepDeclarationVo.fromJson(
                  json['pepDeclaration'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$CorporateShareholderRequestVoImplToJson(
        _$CorporateShareholderRequestVoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'identityCardNumber': instance.identityCardNumber,
      'percentageOfShareholdings': instance.percentageOfShareholdings,
      'mobileCountryCode': instance.mobileCountryCode,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
      'address': instance.address,
      'postcode': instance.postcode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'identityDocumentType': instance.identityDocumentType,
      'identityCardFrontImage': instance.identityCardFrontImage,
      'identityCardBackImage': instance.identityCardBackImage,
      'pepDeclaration': instance.pepDeclaration,
    };
