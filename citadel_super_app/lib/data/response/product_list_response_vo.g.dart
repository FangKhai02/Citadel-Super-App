// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductListResponseVoImpl _$$ProductListResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductListResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      productList: (json['productList'] as List<dynamic>?)
          ?.map((e) => ProductVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProductListResponseVoImplToJson(
        _$ProductListResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'productList': instance.productList,
    };
