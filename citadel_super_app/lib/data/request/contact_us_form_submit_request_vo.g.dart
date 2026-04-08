// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_us_form_submit_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContactUsFormSubmitRequestVoImpl _$$ContactUsFormSubmitRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ContactUsFormSubmitRequestVoImpl(
      name: json['name'] as String?,
      mobileCountryCode: json['mobileCountryCode'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      email: json['email'] as String?,
      reason: json['reason'] as String?,
      remark: json['remark'] as String?,
    );

Map<String, dynamic> _$$ContactUsFormSubmitRequestVoImplToJson(
        _$ContactUsFormSubmitRequestVoImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobileCountryCode': instance.mobileCountryCode,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
      'reason': instance.reason,
      'remark': instance.remark,
    };
