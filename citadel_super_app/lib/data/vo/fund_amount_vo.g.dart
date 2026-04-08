// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fund_amount_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FundAmountVoImpl _$$FundAmountVoImplFromJson(Map<String, dynamic> json) =>
    _$FundAmountVoImpl(
      amount: (json['amount'] as num?)?.toDouble(),
      dividend: (json['dividend'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$FundAmountVoImplToJson(_$FundAmountVoImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'dividend': instance.dividend,
    };
