// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'product_list_vo.freezed.dart';
part 'product_list_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class ProductListVo with _$ProductListVo {
  ProductListVo._();

  factory ProductListVo({
     int? id, 
     String? name, 
     String? productDescription, 
     String? productCatalogueUrl, 
     String? imageOfProductUrl, 
     bool? isSoldOut, 
    
  }) = _ProductListVo;
  
  factory ProductListVo.fromJson(Map<String, dynamic> json) => _$ProductListVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "id" : 0,
  //   "name" : 'string',
  //   "productDescription" : 'string',
  //   "productCatalogueUrl" : 'string',
  //   "imageOfProductUrl" : 'string',
  //   "isSoldOut" : false,
  //   
  // };
}