// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductVoImpl _$$ProductVoImplFromJson(Map<String, dynamic> json) =>
    _$ProductVoImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      productDescription: json['productDescription'] as String?,
      productCatalogueUrl: json['productCatalogueUrl'] as String?,
      imageOfProductUrl: json['imageOfProductUrl'] as String?,
      isSoldOut: json['isSoldOut'] as bool?,
    );

Map<String, dynamic> _$$ProductVoImplToJson(_$ProductVoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'productDescription': instance.productDescription,
      'productCatalogueUrl': instance.productCatalogueUrl,
      'imageOfProductUrl': instance.imageOfProductUrl,
      'isSoldOut': instance.isSoldOut,
    };
