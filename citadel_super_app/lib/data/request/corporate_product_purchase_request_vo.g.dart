// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_product_purchase_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateProductPurchaseRequestVoImpl
    _$$CorporateProductPurchaseRequestVoImplFromJson(
            Map<String, dynamic> json) =>
        _$CorporateProductPurchaseRequestVoImpl(
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
          corporateId: json['corporateId'] as String?,
        );

Map<String, dynamic> _$$CorporateProductPurchaseRequestVoImplToJson(
        _$CorporateProductPurchaseRequestVoImpl instance) =>
    <String, dynamic>{
      'productDetails': instance.productDetails,
      'clientBankId': instance.clientBankId,
      'beneficiaries': instance.beneficiaries,
      'paymentMethod': instance.paymentMethod,
      'corporateId': instance.corporateId,
    };
