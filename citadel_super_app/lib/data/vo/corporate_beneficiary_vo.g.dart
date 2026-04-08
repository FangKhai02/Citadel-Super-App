// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_beneficiary_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateBeneficiaryVoImpl _$$CorporateBeneficiaryVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateBeneficiaryVoImpl(
      corporateBeneficiaryId: (json['corporateBeneficiaryId'] as num?)?.toInt(),
      fullName: json['fullName'] as String?,
      relationshipToSettlor: json['relationshipToSettlor'] as String?,
      relationshipToGuardian: json['relationshipToGuardian'] as String?,
      isUnderAge: json['isUnderAge'] as bool?,
      corporateGuardianVo: json['corporateGuardianVo'] == null
          ? null
          : CorporateGuardianVo.fromJson(
              json['corporateGuardianVo'] as Map<String, dynamic>),
      identityCardNumber: json['identityCardNumber'] as String?,
      identityDocumentType: json['identityDocumentType'] as String?,
      identityCardFrontImageKey: json['identityCardFrontImageKey'] as String?,
      identityCardBackImageKey: json['identityCardBackImageKey'] as String?,
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
    );

Map<String, dynamic> _$$CorporateBeneficiaryVoImplToJson(
        _$CorporateBeneficiaryVoImpl instance) =>
    <String, dynamic>{
      'corporateBeneficiaryId': instance.corporateBeneficiaryId,
      'fullName': instance.fullName,
      'relationshipToSettlor': instance.relationshipToSettlor,
      'relationshipToGuardian': instance.relationshipToGuardian,
      'isUnderAge': instance.isUnderAge,
      'corporateGuardianVo': instance.corporateGuardianVo,
      'identityCardNumber': instance.identityCardNumber,
      'identityDocumentType': instance.identityDocumentType,
      'identityCardFrontImageKey': instance.identityCardFrontImageKey,
      'identityCardBackImageKey': instance.identityCardBackImageKey,
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
    };
