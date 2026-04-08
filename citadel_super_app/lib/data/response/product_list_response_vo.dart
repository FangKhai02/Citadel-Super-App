// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/product_vo.dart';


part 'product_list_response_vo.freezed.dart';
part 'product_list_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ProductListResponseVo with _$ProductListResponseVo {
  ProductListResponseVo._();

  factory ProductListResponseVo({
     String? code,
     String? message,
     List<ProductVo>? productList,
    
  }) = _ProductListResponseVo;
  
  factory ProductListResponseVo.fromJson(Map<String, dynamic> json) => _$ProductListResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "productList" : ProductVo.toExampleApiJson(),
  //   
  // };
}