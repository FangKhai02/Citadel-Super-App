// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankDetailsImpl _$$BankDetailsImplFromJson(Map<String, dynamic> json) =>
    _$BankDetailsImpl(
      appUser: json['appUser'] == null
          ? null
          : AppUser.fromJson(json['appUser'] as Map<String, dynamic>),
      bankName: json['bankName'] as String?,
      accountNumber: json['accountNumber'] as String?,
      accountHolderName: json['accountHolderName'] as String?,
      bankAddress: json['bankAddress'] as String?,
      postcode: json['postcode'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      swiftCode: json['swiftCode'] as String?,
      bankAccountProofKey: json['bankAccountProofKey'] as String?,
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$$BankDetailsImplToJson(_$BankDetailsImpl instance) =>
    <String, dynamic>{
      'appUser': instance.appUser,
      'bankName': instance.bankName,
      'accountNumber': instance.accountNumber,
      'accountHolderName': instance.accountHolderName,
      'bankAddress': instance.bankAddress,
      'postcode': instance.postcode,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'swiftCode': instance.swiftCode,
      'bankAccountProofKey': instance.bankAccountProofKey,
      'isDeleted': instance.isDeleted,
    };
