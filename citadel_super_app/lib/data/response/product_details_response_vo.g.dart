// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductDetailsResponseVoImpl _$$ProductDetailsResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductDetailsResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      name: json['name'] as String?,
      productDescription: json['productDescription'] as String?,
      productCode: json['productCode'] as String?,
      fundAmounts: (json['fundAmounts'] as List<dynamic>?)
          ?.map((e) => FundAmountVo.fromJson(e as Map<String, dynamic>))
          .toList(),
      investmentTenureMonth: (json['investmentTenureMonth'] as num?)?.toInt(),
      productCatalogueUrl: json['productCatalogueUrl'] as String?,
      imageOfProductUrl: json['imageOfProductUrl'] as String?,
      status: json['status'] as bool?,
      livingTrustOptionEnabled: json['livingTrustOptionEnabled'] as bool?,
    );

Map<String, dynamic> _$$ProductDetailsResponseVoImplToJson(
        _$ProductDetailsResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'name': instance.name,
      'productDescription': instance.productDescription,
      'productCode': instance.productCode,
      'fundAmounts': instance.fundAmounts,
      'investmentTenureMonth': instance.investmentTenureMonth,
      'productCatalogueUrl': instance.productCatalogueUrl,
      'imageOfProductUrl': instance.imageOfProductUrl,
      'status': instance.status,
      'livingTrustOptionEnabled': instance.livingTrustOptionEnabled,
    };
