// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductListVoImpl _$$ProductListVoImplFromJson(Map<String, dynamic> json) =>
    _$ProductListVoImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      productDescription: json['productDescription'] as String?,
      productCatalogueUrl: json['productCatalogueUrl'] as String?,
      imageOfProductUrl: json['imageOfProductUrl'] as String?,
      isSoldOut: json['isSoldOut'] as bool?,
    );

Map<String, dynamic> _$$ProductListVoImplToJson(_$ProductListVoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'productDescription': instance.productDescription,
      'productCatalogueUrl': instance.productCatalogueUrl,
      'imageOfProductUrl': instance.imageOfProductUrl,
      'isSoldOut': instance.isSoldOut,
    };
