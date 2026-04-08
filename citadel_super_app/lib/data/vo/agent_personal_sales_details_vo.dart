// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agent_personal_sales_details_vo.freezed.dart';
part 'agent_personal_sales_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentPersonalSalesDetailsVo with _$AgentPersonalSalesDetailsVo {
  AgentPersonalSalesDetailsVo._();

  factory AgentPersonalSalesDetailsVo({
     String? productOrderType, 
     String? clientName, 
     String? clientId, 
     String? code, 
     String? agreementFileName, 
     double? purchasedAmount, 
     String? productStatus, 
     double? commissionPercentage, 
     double? commissionAmount, 
     int? calculatedDate, 
    
  }) = _AgentPersonalSalesDetailsVo;
  
  factory AgentPersonalSalesDetailsVo.fromJson(Map<String, dynamic> json) => _$AgentPersonalSalesDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "productOrderType" : 'string',
  //   "clientName" : 'string',
  //   "clientId" : 'string',
  //   "code" : 'string',
  //   "agreementFileName" : 'string',
  //   "purchasedAmount" : 0,
  //   "productStatus" : 'string',
  //   "commissionPercentage" : 0,
  //   "commissionAmount" : 0,
  //   "calculatedDate" : 0,
  //   
  // };
}