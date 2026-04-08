// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_bank_details_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductBankDetailsResponseVoImpl _$$ProductBankDetailsResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductBankDetailsResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      bankName: json['bankName'] as String?,
      bankAccountName: json['bankAccountName'] as String?,
      bankAccountNumber: json['bankAccountNumber'] as String?,
    );

Map<String, dynamic> _$$ProductBankDetailsResponseVoImplToJson(
        _$ProductBankDetailsResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'bankName': instance.bankName,
      'bankAccountName': instance.bankAccountName,
      'bankAccountNumber': instance.bankAccountNumber,
    };
