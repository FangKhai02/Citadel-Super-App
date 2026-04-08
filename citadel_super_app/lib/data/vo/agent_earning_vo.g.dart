// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_earning_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentEarningVoImpl _$$AgentEarningVoImplFromJson(Map<String, dynamic> json) =>
    _$AgentEarningVoImpl(
      earningType: json['earningType'] as String?,
      commissionAmount: (json['commissionAmount'] as num?)?.toDouble(),
      productCode: json['productCode'] as String?,
      agreementNumber: json['agreementNumber'] as String?,
      transactionDate: (json['transactionDate'] as num?)?.toInt(),
      bankName: json['bankName'] as String?,
      transactionId: json['transactionId'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$AgentEarningVoImplToJson(
        _$AgentEarningVoImpl instance) =>
    <String, dynamic>{
      'earningType': instance.earningType,
      'commissionAmount': instance.commissionAmount,
      'productCode': instance.productCode,
      'agreementNumber': instance.agreementNumber,
      'transactionDate': instance.transactionDate,
      'bankName': instance.bankName,
      'transactionId': instance.transactionId,
      'status': instance.status,
    };
