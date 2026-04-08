// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_guardian_creation_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateGuardianCreationRequestVoImpl
    _$$CorporateGuardianCreationRequestVoImplFromJson(
            Map<String, dynamic> json) =>
        _$CorporateGuardianCreationRequestVoImpl(
          corporateBeneficiaryId:
              (json['corporateBeneficiaryId'] as num?)?.toInt(),
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
          identityDocumentType: json['identityDocumentType'] as String?,
          identityCardFrontImage: json['identityCardFrontImage'] as String?,
          identityCardBackImage: json['identityCardBackImage'] as String?,
          relationshipToGuardian: json['relationshipToGuardian'] as String?,
        );

Map<String, dynamic> _$$CorporateGuardianCreationRequestVoImplToJson(
        _$CorporateGuardianCreationRequestVoImpl instance) =>
    <String, dynamic>{
      'corporateBeneficiaryId': instance.corporateBeneficiaryId,
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
      'identityDocumentType': instance.identityDocumentType,
      'identityCardFrontImage': instance.identityCardFrontImage,
      'identityCardBackImage': instance.identityCardBackImage,
      'relationshipToGuardian': instance.relationshipToGuardian,
    };
