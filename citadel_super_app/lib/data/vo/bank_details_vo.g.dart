// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankDetailsVoImpl _$$BankDetailsVoImplFromJson(Map<String, dynamic> json) =>
    _$BankDetailsVoImpl(
      id: (json['id'] as num?)?.toInt(),
      bankName: json['bankName'] as String?,
      bankAccountNumber: json['bankAccountNumber'] as String?,
      bankAccountHolderName: json['bankAccountHolderName'] as String?,
      bankAddress: json['bankAddress'] as String?,
      bankPostcode: json['bankPostcode'] as String?,
      bankCity: json['bankCity'] as String?,
      bankState: json['bankState'] as String?,
      bankCountry: json['bankCountry'] as String?,
      swiftCode: json['swiftCode'] as String?,
      bankAccountProofFile: json['bankAccountProofFile'] as String?,
    );

Map<String, dynamic> _$$BankDetailsVoImplToJson(_$BankDetailsVoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bankName': instance.bankName,
      'bankAccountNumber': instance.bankAccountNumber,
      'bankAccountHolderName': instance.bankAccountHolderName,
      'bankAddress': instance.bankAddress,
      'bankPostcode': instance.bankPostcode,
      'bankCity': instance.bankCity,
      'bankState': instance.bankState,
      'bankCountry': instance.bankCountry,
      'swiftCode': instance.swiftCode,
      'bankAccountProofFile': instance.bankAccountProofFile,
    };
