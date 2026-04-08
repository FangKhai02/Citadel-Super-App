// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_product_order_commission_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentProductOrderCommissionDetailsVoImpl
    _$$AgentProductOrderCommissionDetailsVoImplFromJson(
            Map<String, dynamic> json) =>
        _$AgentProductOrderCommissionDetailsVoImpl(
          earningType: json['earningType'] as String?,
          commissionAmount: (json['commissionAmount'] as num?)?.toDouble(),
          calculatedDate: (json['calculatedDate'] as num?)?.toInt(),
          productCode: json['productCode'] as String?,
          productName: json['productName'] as String?,
          agreementName: json['agreementName'] as String?,
          transactionDate: (json['transactionDate'] as num?)?.toInt(),
          bankName: json['bankName'] as String?,
          transactionId: json['transactionId'] as String?,
          status: json['status'] as String?,
        );

Map<String, dynamic> _$$AgentProductOrderCommissionDetailsVoImplToJson(
        _$AgentProductOrderCommissionDetailsVoImpl instance) =>
    <String, dynamic>{
      'earningType': instance.earningType,
      'commissionAmount': instance.commissionAmount,
      'calculatedDate': instance.calculatedDate,
      'productCode': instance.productCode,
      'productName': instance.productName,
      'agreementName': instance.agreementName,
      'transactionDate': instance.transactionDate,
      'bankName': instance.bankName,
      'transactionId': instance.transactionId,
      'status': instance.status,
    };
