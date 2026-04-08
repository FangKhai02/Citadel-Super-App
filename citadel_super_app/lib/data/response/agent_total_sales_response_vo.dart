// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agent_total_sales_response_vo.freezed.dart';
part 'agent_total_sales_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentTotalSalesResponseVo with _$AgentTotalSalesResponseVo {
  AgentTotalSalesResponseVo._();

  factory AgentTotalSalesResponseVo({
     String? code,
     String? message,
     String? totalSalesAmount,
     String? percentageDifference,
     int? currentQuarterStartDate,
     int? currentQuarterEndDate,
     String? paymentMethod,
     int? totalProductsSold,
    
  }) = _AgentTotalSalesResponseVo;
  
  factory AgentTotalSalesResponseVo.fromJson(Map<String, dynamic> json) => _$AgentTotalSalesResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "totalSalesAmount" : 'string',
  //   "percentageDifference" : 'string',
  //   "currentQuarterStartDate" : 0,
  //   "currentQuarterEndDate" : 0,
  //   "paymentMethod" : 'string',
  //   "totalProductsSold" : 0,
  //   
  // };
}