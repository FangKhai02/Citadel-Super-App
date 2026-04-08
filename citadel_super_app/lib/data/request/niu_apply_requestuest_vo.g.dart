// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'niu_apply_requestuest_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NiuApplyRequestuestVoImpl _$$NiuApplyRequestuestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$NiuApplyRequestuestVoImpl(
      amountRequested: (json['amountRequested'] as num?)?.toInt(),
      tenure: json['tenure'] as String?,
      applicationType: json['applicationType'] as String?,
      name: json['name'] as String?,
      documentNumber: json['documentNumber'] as String?,
      address: json['address'] as String?,
      postcode: json['postcode'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      mobileCountryCode: json['mobileCountryCode'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      email: json['email'] as String?,
      natureOfBusiness: json['natureOfBusiness'] as String?,
      purposeOfAdvances: json['purposeOfAdvances'] as String?,
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => NiuApplyDocumentVo.fromJson(e as Map<String, dynamic>))
          .toList(),
      firstSignee: json['firstSignee'] == null
          ? null
          : NiuApplySigneeVo.fromJson(
              json['firstSignee'] as Map<String, dynamic>),
      secondSignee: json['secondSignee'] == null
          ? null
          : NiuApplySigneeVo.fromJson(
              json['secondSignee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$NiuApplyRequestuestVoImplToJson(
        _$NiuApplyRequestuestVoImpl instance) =>
    <String, dynamic>{
      'amountRequested': instance.amountRequested,
      'tenure': instance.tenure,
      'applicationType': instance.applicationType,
      'name': instance.name,
      'documentNumber': instance.documentNumber,
      'address': instance.address,
      'postcode': instance.postcode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'mobileCountryCode': instance.mobileCountryCode,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
      'natureOfBusiness': instance.natureOfBusiness,
      'purposeOfAdvances': instance.purposeOfAdvances,
      'documents': instance.documents,
      'firstSignee': instance.firstSignee,
      'secondSignee': instance.secondSignee,
    };
