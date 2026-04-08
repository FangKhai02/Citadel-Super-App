// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_dividend_payout_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentDividendPayoutVoImpl _$$AgentDividendPayoutVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgentDividendPayoutVoImpl(
      dividendPayoutId: json['dividendPayoutId'] as String?,
      productName: json['productName'] as String?,
      productCode: json['productCode'] as String?,
      dividendAmount: (json['dividendAmount'] as num?)?.toInt(),
      dividendPayoutDate: (json['dividendPayoutDate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AgentDividendPayoutVoImplToJson(
        _$AgentDividendPayoutVoImpl instance) =>
    <String, dynamic>{
      'dividendPayoutId': instance.dividendPayoutId,
      'productName': instance.productName,
      'productCode': instance.productCode,
      'dividendAmount': instance.dividendAmount,
      'dividendPayoutDate': instance.dividendPayoutDate,
    };
