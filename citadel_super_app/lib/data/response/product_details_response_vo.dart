// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/fund_amount_vo.dart';


part 'product_details_response_vo.freezed.dart';
part 'product_details_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ProductDetailsResponseVo with _$ProductDetailsResponseVo {
  ProductDetailsResponseVo._();

  factory ProductDetailsResponseVo({
     String? code,
     String? message,
     String? name,
     String? productDescription,
     String? productCode,
     List<FundAmountVo>? fundAmounts,
     int? investmentTenureMonth,
     String? productCatalogueUrl,
     String? imageOfProductUrl,
     bool? status,
     bool? livingTrustOptionEnabled,
    
  }) = _ProductDetailsResponseVo;
  
  factory ProductDetailsResponseVo.fromJson(Map<String, dynamic> json) => _$ProductDetailsResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "name" : 'string',
  //   "productDescription" : 'string',
  //   "productCode" : 'string',
  //   "fundAmounts" : FundAmountVo.toExampleApiJson(),
  //   "investmentTenureMonth" : 0,
  //   "productCatalogueUrl" : 'string',
  //   "imageOfProductUrl" : 'string',
  //   "status" : false,
  //   "livingTrustOptionEnabled" : false,
  //   
  // };
}