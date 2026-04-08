// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_bank_details_edit_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateBankDetailsEditRequestVoImpl
    _$$CorporateBankDetailsEditRequestVoImplFromJson(
            Map<String, dynamic> json) =>
        _$CorporateBankDetailsEditRequestVoImpl(
          corporateBankDetailsId:
              (json['corporateBankDetailsId'] as num?)?.toInt(),
          bankName: json['bankName'] as String?,
          accountNumber: json['accountNumber'] as String?,
          accountHolderName: json['accountHolderName'] as String?,
          bankAddress: json['bankAddress'] as String?,
          postcode: json['postcode'] as String?,
          city: json['city'] as String?,
          state: json['state'] as String?,
          country: json['country'] as String?,
          swiftCode: json['swiftCode'] as String?,
          bankAccountProofFile: json['bankAccountProofFile'] as String?,
        );

Map<String, dynamic> _$$CorporateBankDetailsEditRequestVoImplToJson(
        _$CorporateBankDetailsEditRequestVoImpl instance) =>
    <String, dynamic>{
      'corporateBankDetailsId': instance.corporateBankDetailsId,
      'bankName': instance.bankName,
      'accountNumber': instance.accountNumber,
      'accountHolderName': instance.accountHolderName,
      'bankAddress': instance.bankAddress,
      'postcode': instance.postcode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'swiftCode': instance.swiftCode,
      'bankAccountProofFile': instance.bankAccountProofFile,
    };
