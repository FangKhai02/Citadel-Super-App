// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_client_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateClientResponseVoImpl _$$CorporateClientResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateClientResponseVoImpl(
      id: (json['id'] as num?)?.toInt(),
      profilePicture: json['profilePicture'] as String?,
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
      annualIncomeDeclaration: json['annualIncomeDeclaration'] as String?,
      sourceOfIncome: json['sourceOfIncome'] as String?,
    );

Map<String, dynamic> _$$CorporateClientResponseVoImplToJson(
        _$CorporateClientResponseVoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profilePicture': instance.profilePicture,
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
      'annualIncomeDeclaration': instance.annualIncomeDeclaration,
      'sourceOfIncome': instance.sourceOfIncome,
    };
