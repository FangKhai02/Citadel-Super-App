// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guardian_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GuardianVoImpl _$$GuardianVoImplFromJson(Map<String, dynamic> json) =>
    _$GuardianVoImpl(
      id: (json['id'] as num?)?.toInt(),
      fullName: json['fullName'] as String?,
      icPassport: json['icPassport'] as String?,
      dob: (json['dob'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      nationality: json['nationality'] as String?,
      address: json['address'] as String?,
      postcode: json['postcode'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      residentialStatus: json['residentialStatus'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      mobileCountryCode: json['mobileCountryCode'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      email: json['email'] as String?,
      identityDocumentType: json['identityDocumentType'] as String?,
      identityCardFrontImageKey: json['identityCardFrontImageKey'] as String?,
      identityCardBackImageKey: json['identityCardBackImageKey'] as String?,
      addressProofKey: json['addressProofKey'] as String?,
      relationshipToBeneficiary: json['relationshipToBeneficiary'] as String?,
    );

Map<String, dynamic> _$$GuardianVoImplToJson(_$GuardianVoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'icPassport': instance.icPassport,
      'dob': instance.dob,
      'gender': instance.gender,
      'nationality': instance.nationality,
      'address': instance.address,
      'postcode': instance.postcode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'residentialStatus': instance.residentialStatus,
      'maritalStatus': instance.maritalStatus,
      'mobileCountryCode': instance.mobileCountryCode,
      'mobileNumber': instance.mobileNumber,
      'email': instance.email,
      'identityDocumentType': instance.identityDocumentType,
      'identityCardFrontImageKey': instance.identityCardFrontImageKey,
      'identityCardBackImageKey': instance.identityCardBackImageKey,
      'addressProofKey': instance.addressProofKey,
      'relationshipToBeneficiary': instance.relationshipToBeneficiary,
    };
