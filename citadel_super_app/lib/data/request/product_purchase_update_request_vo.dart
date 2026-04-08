// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/product_order_beneficiary_request_vo.dart';


part 'product_purchase_update_request_vo.freezed.dart';
part 'product_purchase_update_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class ProductPurchaseUpdateRequestVo with _$ProductPurchaseUpdateRequestVo {
  ProductPurchaseUpdateRequestVo._();

  factory ProductPurchaseUpdateRequestVo({
     int? clientBankId,
     String? paymentMethod,
     List<ProductOrderBeneficiaryRequestVo>? beneficiaries,
    
  }) = _ProductPurchaseUpdateRequestVo;
  
  factory ProductPurchaseUpdateRequestVo.fromJson(Map<String, dynamic> json) => _$ProductPurchaseUpdateRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'clientBankId' : 0,
  //   'paymentMethod' : 'string',
  //   'beneficiaries' : ProductOrderBeneficiaryReqVo.toExampleApiJson(),
  //   
  // };
}