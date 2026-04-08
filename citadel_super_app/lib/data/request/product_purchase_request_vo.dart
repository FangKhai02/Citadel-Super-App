// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/product_purchase_product_details_vo.dart';
import '../vo/product_order_beneficiary_request_vo.dart';


part 'product_purchase_request_vo.freezed.dart';
part 'product_purchase_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ProductPurchaseRequestVo with _$ProductPurchaseRequestVo {
  ProductPurchaseRequestVo._();

  factory ProductPurchaseRequestVo({
     ProductPurchaseProductDetailsVo? productDetails,
     bool? livingTrustOptionEnabled,
     int? clientBankId,
     List<ProductOrderBeneficiaryRequestVo>? beneficiaries,
     String? paymentMethod,
     String? clientId,
     String? corporateClientId,
    
  }) = _ProductPurchaseRequestVo;
  
  factory ProductPurchaseRequestVo.fromJson(Map<String, dynamic> json) => _$ProductPurchaseRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'productDetails' : ProductPurchaseProductDetailsVo.toExampleApiJson(),
  //   'livingTrustOptionEnabled' : false,
  //   'clientBankId' : 0,
  //   'beneficiaries' : ProductOrderBeneficiaryReqVo.toExampleApiJson(),
  //   'paymentMethod' : 'string',
  //   'clientId' : 'string',
  //   'corporateClientId' : 'string',
  //   
  // };
}