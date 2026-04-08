// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_purchase_product_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductPurchaseProductDetailsVoImpl
    _$$ProductPurchaseProductDetailsVoImplFromJson(Map<String, dynamic> json) =>
        _$ProductPurchaseProductDetailsVoImpl(
          productId: (json['productId'] as num?)?.toInt(),
          amount: (json['amount'] as num?)?.toDouble(),
          dividend: (json['dividend'] as num?)?.toDouble(),
          investmentTenureMonth:
              (json['investmentTenureMonth'] as num?)?.toInt(),
        );

Map<String, dynamic> _$$ProductPurchaseProductDetailsVoImplToJson(
        _$ProductPurchaseProductDetailsVoImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'amount': instance.amount,
      'dividend': instance.dividend,
      'investmentTenureMonth': instance.investmentTenureMonth,
    };
