// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/agent_down_line_product_order_commission_details_vo.dart';


part 'agent_down_line_commission_vo.freezed.dart';
part 'agent_down_line_commission_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentDownLineCommissionVo with _$AgentDownLineCommissionVo {
  AgentDownLineCommissionVo._();

  factory AgentDownLineCommissionVo({
     String? productCode, 
     List<AgentDownLineProductOrderCommissionDetailsVo>? commissionList, 
    
  }) = _AgentDownLineCommissionVo;
  
  factory AgentDownLineCommissionVo.fromJson(Map<String, dynamic> json) => _$AgentDownLineCommissionVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "productCode" : 'string',
  //   "commissionList" : AgentDownLineProductOrderCommissionDetailsVo.toExampleApiJson(),
  //   
  // };
}