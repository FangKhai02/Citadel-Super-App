// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionResponseVoImpl _$$TransactionResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => TransactionVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TransactionResponseVoImplToJson(
        _$TransactionResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'transactions': instance.transactions,
    };
