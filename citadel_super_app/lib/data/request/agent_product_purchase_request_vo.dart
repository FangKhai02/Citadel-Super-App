// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/product_purchase_product_details_vo.dart';
import '../vo/product_order_beneficiary_request_vo.dart';


part 'agent_product_purchase_request_vo.freezed.dart';
part 'agent_product_purchase_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class AgentProductPurchaseRequestVo with _$AgentProductPurchaseRequestVo {
  AgentProductPurchaseRequestVo._();

  factory AgentProductPurchaseRequestVo({
     ProductPurchaseProductDetailsVo? productDetails,
     int? clientBankId,
     List<ProductOrderBeneficiaryRequestVo>? beneficiaries,
     String? paymentMethod,
     String? clientId,
    
  }) = _AgentProductPurchaseRequestVo;
  
  factory AgentProductPurchaseRequestVo.fromJson(Map<String, dynamic> json) => _$AgentProductPurchaseRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'productDetails' : ProductPurchaseProductDetailsVo.toExampleApiJson(),
  //   'clientBankId' : 0,
  //   'beneficiaries' : ProductOrderBeneficiaryReqVo.toExampleApiJson(),
  //   'paymentMethod' : 'string',
  //   'clientId' : 'string',
  //   
  // };
}