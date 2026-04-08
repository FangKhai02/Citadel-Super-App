// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agent_earning_vo.freezed.dart';
part 'agent_earning_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentEarningVo with _$AgentEarningVo {
  AgentEarningVo._();

  factory AgentEarningVo({
     String? earningType, 
     double? commissionAmount, 
     String? productCode, 
     String? agreementNumber, 
     int? transactionDate, 
     String? bankName, 
     String? transactionId, 
     String? status, 
    
  }) = _AgentEarningVo;
  
  factory AgentEarningVo.fromJson(Map<String, dynamic> json) => _$AgentEarningVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "earningType" : 'string',
  //   "commissionAmount" : 0,
  //   "productCode" : 'string',
  //   "agreementNumber" : 'string',
  //   "transactionDate" : 0,
  //   "bankName" : 'string',
  //   "transactionId" : 'string',
  //   "status" : 'string',
  //   
  // };
}