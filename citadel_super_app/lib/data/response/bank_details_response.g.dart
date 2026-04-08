// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankDetailsResponseImpl _$$BankDetailsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BankDetailsResponseImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      bankDetails: (json['bankDetails'] as List<dynamic>?)
          ?.map((e) => BankDetailsVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BankDetailsResponseImplToJson(
        _$BankDetailsResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'bankDetails': instance.bankDetails,
    };
