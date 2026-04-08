// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'product_purchase_product_details_vo.freezed.dart';
part 'product_purchase_product_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ProductPurchaseProductDetailsVo with _$ProductPurchaseProductDetailsVo {
  ProductPurchaseProductDetailsVo._();

  factory ProductPurchaseProductDetailsVo({
     int? productId, 
     double? amount, 
     double? dividend, 
     int? investmentTenureMonth, 
    
  }) = _ProductPurchaseProductDetailsVo;
  
  factory ProductPurchaseProductDetailsVo.fromJson(Map<String, dynamic> json) => _$ProductPurchaseProductDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "productId" : 0,
  //   "amount" : 0,
  //   "dividend" : 0,
  //   "investmentTenureMonth" : 0,
  //   
  // };
}