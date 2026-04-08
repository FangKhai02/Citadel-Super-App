// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_bank_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateBankDetailsVoImpl _$$CorporateBankDetailsVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CorporateBankDetailsVoImpl(
      id: (json['id'] as num?)?.toInt(),
      bankName: json['bankName'] as String?,
      bankAccountHolderName: json['bankAccountHolderName'] as String?,
      bankAccountNumber: json['bankAccountNumber'] as String?,
      bankAddress: json['bankAddress'] as String?,
      bankPostcode: json['bankPostcode'] as String?,
      bankCity: json['bankCity'] as String?,
      bankState: json['bankState'] as String?,
      bankCountry: json['bankCountry'] as String?,
      swiftCode: json['swiftCode'] as String?,
      bankAccountProofFile: json['bankAccountProofFile'] as String?,
    );

Map<String, dynamic> _$$CorporateBankDetailsVoImplToJson(
        _$CorporateBankDetailsVoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bankName': instance.bankName,
      'bankAccountHolderName': instance.bankAccountHolderName,
      'bankAccountNumber': instance.bankAccountNumber,
      'bankAddress': instance.bankAddress,
      'bankPostcode': instance.bankPostcode,
      'bankCity': instance.bankCity,
      'bankState': instance.bankState,
      'bankCountry': instance.bankCountry,
      'swiftCode': instance.swiftCode,
      'bankAccountProofFile': instance.bankAccountProofFile,
    };
