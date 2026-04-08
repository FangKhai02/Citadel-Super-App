// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'individual_beneficiary_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IndividualBeneficiaryVoImpl _$$IndividualBeneficiaryVoImplFromJson(
        Map<String, dynamic> json) =>
    _$IndividualBeneficiaryVoImpl(
      individualBeneficiaryId:
          (json['individualBeneficiaryId'] as num?)?.toInt(),
      identityDocumentType: json['identityDocumentType'] as String?,
      identityCardFrontImageKey: json['identityCardFrontImageKey'] as String?,
      identityCardBackImageKey: json['identityCardBackImageKey'] as String?,
      relationshipToSettlor: json['relationshipToSettlor'] as String?,
      relationshipToGuardian: json['relationshipToGuardian'] as String?,
      fullName: json['fullName'] as String?,
      identityCardNumber: json['identityCardNumber'] as String?,
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
      isUnderAge: json['isUnderAge'] as bool?,
      guardian: json['guardian'] == null
          ? null
          : GuardianVo.fromJson(json['guardian'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$IndividualBeneficiaryVoImplToJson(
        _$IndividualBeneficiaryVoImpl instance) =>
    <String, dynamic>{
      'individualBeneficiaryId': instance.individualBeneficiaryId,
      'identityDocumentType': instance.identityDocumentType,
      'identityCardFrontImageKey': instance.identityCardFrontImageKey,
      'identityCardBackImageKey': instance.identityCardBackImageKey,
      'relationshipToSettlor': instance.relationshipToSettlor,
      'relationshipToGuardian': instance.relationshipToGuardian,
      'fullName': instance.fullName,
      'identityCardNumber': instance.identityCardNumber,
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
      'isUnderAge': instance.isUnderAge,
      'guardian': instance.guardian,
    };
