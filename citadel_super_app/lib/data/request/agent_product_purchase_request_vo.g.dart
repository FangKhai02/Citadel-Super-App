// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_product_purchase_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentProductPurchaseRequestVoImpl
    _$$AgentProductPurchaseRequestVoImplFromJson(Map<String, dynamic> json) =>
        _$AgentProductPurchaseRequestVoImpl(
          productDetails: json['productDetails'] == null
              ? null
              : ProductPurchaseProductDetailsVo.fromJson(
                  json['productDetails'] as Map<String, dynamic>),
          clientBankId: (json['clientBankId'] as num?)?.toInt(),
          beneficiaries: (json['beneficiaries'] as List<dynamic>?)
              ?.map((e) => ProductOrderBeneficiaryRequestVo.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          paymentMethod: json['paymentMethod'] as String?,
          clientId: json['clientId'] as String?,
        );

Map<String, dynamic> _$$AgentProductPurchaseRequestVoImplToJson(
        _$AgentProductPurchaseRequestVoImpl instance) =>
    <String, dynamic>{
      'productDetails': instance.productDetails,
      'clientBankId': instance.clientBankId,
      'beneficiaries': instance.beneficiaries,
      'paymentMethod': instance.paymentMethod,
      'clientId': instance.clientId,
    };
