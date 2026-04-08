// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_purchase_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductPurchaseRequestVoImpl _$$ProductPurchaseRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductPurchaseRequestVoImpl(
      productDetails: json['productDetails'] == null
          ? null
          : ProductPurchaseProductDetailsVo.fromJson(
              json['productDetails'] as Map<String, dynamic>),
      livingTrustOptionEnabled: json['livingTrustOptionEnabled'] as bool?,
      clientBankId: (json['clientBankId'] as num?)?.toInt(),
      beneficiaries: (json['beneficiaries'] as List<dynamic>?)
          ?.map((e) => ProductOrderBeneficiaryRequestVo.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      paymentMethod: json['paymentMethod'] as String?,
      clientId: json['clientId'] as String?,
      corporateClientId: json['corporateClientId'] as String?,
    );

Map<String, dynamic> _$$ProductPurchaseRequestVoImplToJson(
        _$ProductPurchaseRequestVoImpl instance) =>
    <String, dynamic>{
      'productDetails': instance.productDetails,
      'livingTrustOptionEnabled': instance.livingTrustOptionEnabled,
      'clientBankId': instance.clientBankId,
      'beneficiaries': instance.beneficiaries,
      'paymentMethod': instance.paymentMethod,
      'clientId': instance.clientId,
      'corporateClientId': instance.corporateClientId,
    };
