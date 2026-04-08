// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/product_purchase_product_details_vo.dart';
import '../vo/product_order_beneficiary_request_vo.dart';


part 'corporate_product_purchase_request_vo.freezed.dart';
part 'corporate_product_purchase_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class CorporateProductPurchaseRequestVo with _$CorporateProductPurchaseRequestVo {
  CorporateProductPurchaseRequestVo._();

  factory CorporateProductPurchaseRequestVo({
     ProductPurchaseProductDetailsVo? productDetails,
     int? clientBankId,
     List<ProductOrderBeneficiaryRequestVo>? beneficiaries,
     String? paymentMethod,
     String? corporateId,
    
  }) = _CorporateProductPurchaseRequestVo;
  
  factory CorporateProductPurchaseRequestVo.fromJson(Map<String, dynamic> json) => _$CorporateProductPurchaseRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'productDetails' : ProductPurchaseProductDetailsVo.toExampleApiJson(),
  //   'clientBankId' : 0,
  //   'beneficiaries' : ProductOrderBeneficiaryReqVo.toExampleApiJson(),
  //   'paymentMethod' : 'string',
  //   'corporateId' : 'string',
  //   
  // };
}