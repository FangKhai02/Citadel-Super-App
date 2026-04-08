// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agent_down_line_product_order_commission_details_vo.freezed.dart';
part 'agent_down_line_product_order_commission_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentDownLineProductOrderCommissionDetailsVo with _$AgentDownLineProductOrderCommissionDetailsVo {
  AgentDownLineProductOrderCommissionDetailsVo._();

  factory AgentDownLineProductOrderCommissionDetailsVo({
     String? status, 
     String? agentName, 
     String? agentRole, 
     double? commissionPercentage, 
     double? commissionAmount, 
     int? calculatedDate, 
    
  }) = _AgentDownLineProductOrderCommissionDetailsVo;
  
  factory AgentDownLineProductOrderCommissionDetailsVo.fromJson(Map<String, dynamic> json) => _$AgentDownLineProductOrderCommissionDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "status" : 'string',
  //   "agentName" : 'string',
  //   "agentRole" : 'string',
  //   "commissionPercentage" : 0,
  //   "commissionAmount" : 0,
  //   "calculatedDate" : 0,
  //   
  // };
}