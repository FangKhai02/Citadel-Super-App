// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_profile_edit_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientProfileEditRequestVoImpl _$$ClientProfileEditRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientProfileEditRequestVoImpl(
      name: json['name'] as String?,
      address: json['address'] as String?,
      postcode: json['postcode'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      correspondingAddress: json['correspondingAddress'] == null
          ? null
          : CorrespondingAddress.fromJson(
              json['correspondingAddress'] as Map<String, dynamic>),
      residentialStatus: json['residentialStatus'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      mobileCountryCode: json['mobileCountryCode'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      email: json['email'] as String?,
      employmentDetails: json['employmentDetails'] == null
          ? null
          : EmploymentDetailsVo.fromJson(
              json['employmentDetails'] as Map<String, dynamic>),
      nationality: json['nationality'] as String?,
      annualIncomeDeclaration: json['annualIncomeDeclaration'] as String?,
      sourceOfIncome: json['sourceOfIncome'] as String?,
    );

Map<String, dynamic> _$$ClientProfileEditRequestVoImplToJson(
        _$ClientProfileEditRequestVoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'postcode': instance.postcode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'correspondingAddress': instance.correspondingAddress,
      'residentialStatus': instance.residentialStatus,
      'maritalStatus': instance.maritalStatus,
      'mobileCountryCode': instance.mobileCountryCode,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
      'employmentDetails': instance.employmentDetails,
      'nationality': instance.nationality,
      'annualIncomeDeclaration': instance.annualIncomeDeclaration,
      'sourceOfIncome': instance.sourceOfIncome,
    };
