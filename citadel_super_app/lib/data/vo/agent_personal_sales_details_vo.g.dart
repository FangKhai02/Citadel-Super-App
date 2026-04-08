// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_personal_sales_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentPersonalSalesDetailsVoImpl _$$AgentPersonalSalesDetailsVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgentPersonalSalesDetailsVoImpl(
      productOrderType: json['productOrderType'] as String?,
      clientName: json['clientName'] as String?,
      clientId: json['clientId'] as String?,
      code: json['code'] as String?,
      agreementFileName: json['agreementFileName'] as String?,
      purchasedAmount: (json['purchasedAmount'] as num?)?.toDouble(),
      productStatus: json['productStatus'] as String?,
      commissionPercentage: (json['commissionPercentage'] as num?)?.toDouble(),
      commissionAmount: (json['commissionAmount'] as num?)?.toDouble(),
      calculatedDate: (json['calculatedDate'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$AgentPersonalSalesDetailsVoImplToJson(
        _$AgentPersonalSalesDetailsVoImpl instance) =>
    <String, dynamic>{
      'productOrderType': instance.productOrderType,
      'clientName': instance.clientName,
      'clientId': instance.clientId,
      'code': instance.code,
      'agreementFileName': instance.agreementFileName,
      'purchasedAmount': instance.purchasedAmount,
      'productStatus': instance.productStatus,
      'commissionPercentage': instance.commissionPercentage,
      'commissionAmount': instance.commissionAmount,
      'calculatedDate': instance.calculatedDate,
    };
