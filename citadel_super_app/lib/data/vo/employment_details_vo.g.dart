// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employment_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmploymentDetailsVoImpl _$$EmploymentDetailsVoImplFromJson(
        Map<String, dynamic> json) =>
    _$EmploymentDetailsVoImpl(
      employmentType: json['employmentType'] as String?,
      employerName: json['employerName'] as String?,
      industryType: json['industryType'] as String?,
      jobTitle: json['jobTitle'] as String?,
      employerAddress: json['employerAddress'] as String?,
      postcode: json['postcode'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$$EmploymentDetailsVoImplToJson(
        _$EmploymentDetailsVoImpl instance) =>
    <String, dynamic>{
      'employmentType': instance.employmentType,
      'employerName': instance.employerName,
      'industryType': instance.industryType,
      'jobTitle': instance.jobTitle,
      'employerAddress': instance.employerAddress,
      'postcode': instance.postcode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
    };
