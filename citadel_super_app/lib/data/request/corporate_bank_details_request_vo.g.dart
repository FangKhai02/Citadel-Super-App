// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_bank_details_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateBankDetailsRequestVoImpl
    _$$CorporateBankDetailsRequestVoImplFromJson(Map<String, dynamic> json) =>
        _$CorporateBankDetailsRequestVoImpl(
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

Map<String, dynamic> _$$CorporateBankDetailsRequestVoImplToJson(
        _$CorporateBankDetailsRequestVoImpl instance) =>
    <String, dynamic>{
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
