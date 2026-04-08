// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_employment_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientEmploymentDetailsVoImpl _$$ClientEmploymentDetailsVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientEmploymentDetailsVoImpl(
      employmentType: json['employmentType'] as String?,
      employerName: json['employerName'] as String?,
      industryType: json['industryType'] as String?,
      jobTitle: json['jobTitle'] as String?,
      employerAddress: json['employerAddress'] as String?,
      employerPostcode: json['employerPostcode'] as String?,
      employerCity: json['employerCity'] as String?,
      employerState: json['employerState'] as String?,
      employerCountry: json['employerCountry'] as String?,
    );

Map<String, dynamic> _$$ClientEmploymentDetailsVoImplToJson(
        _$ClientEmploymentDetailsVoImpl instance) =>
    <String, dynamic>{
      'employmentType': instance.employmentType,
      'employerName': instance.employerName,
      'industryType': instance.industryType,
      'jobTitle': instance.jobTitle,
      'employerAddress': instance.employerAddress,
      'employerPostcode': instance.employerPostcode,
      'employerCity': instance.employerCity,
      'employerState': instance.employerState,
      'employerCountry': instance.employerCountry,
    };
