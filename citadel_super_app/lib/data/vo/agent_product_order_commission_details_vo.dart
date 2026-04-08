// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agent_product_order_commission_details_vo.freezed.dart';
part 'agent_product_order_commission_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class AgentProductOrderCommissionDetailsVo with _$AgentProductOrderCommissionDetailsVo {
  AgentProductOrderCommissionDetailsVo._();

  factory AgentProductOrderCommissionDetailsVo({
     String? earningType, 
     double? commissionAmount, 
     int? calculatedDate, 
     String? productCode, 
     String? productName, 
     String? agreementName, 
     int? transactionDate, 
     String? bankName, 
     String? transactionId, 
     String? status, 
    
  }) = _AgentProductOrderCommissionDetailsVo;
  
  factory AgentProductOrderCommissionDetailsVo.fromJson(Map<String, dynamic> json) => _$AgentProductOrderCommissionDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "earningType" : 'string',
  //   "commissionAmount" : 0,
  //   "calculatedDate" : 0,
  //   "productCode" : 'string',
  //   "productName" : 'string',
  //   "agreementName" : 'string',
  //   "transactionDate" : 0,
  //   "bankName" : 'string',
  //   "transactionId" : 'string',
  //   "status" : 'string',
  //   
  // };
}