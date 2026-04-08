// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_bank_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreateBankResponseVoImpl _$$CreateBankResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateBankResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      bankDetails: json['bankDetails'] == null
          ? null
          : BankDetailsVo.fromJson(json['bankDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CreateBankResponseVoImplToJson(
        _$CreateBankResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'bankDetails': instance.bankDetails,
    };
