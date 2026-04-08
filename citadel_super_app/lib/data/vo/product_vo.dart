// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'product_vo.freezed.dart';
part 'product_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ProductVo with _$ProductVo {
  ProductVo._();

  factory ProductVo({
     int? id, 
     String? name, 
     String? productDescription, 
     String? productCatalogueUrl, 
     String? imageOfProductUrl, 
     bool? isSoldOut, 
    
  }) = _ProductVo;
  
  factory ProductVo.fromJson(Map<String, dynamic> json) => _$ProductVoFromJson(json);

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