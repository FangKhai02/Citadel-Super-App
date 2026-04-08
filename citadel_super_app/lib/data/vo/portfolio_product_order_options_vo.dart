// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'portfolio_product_order_options_vo.freezed.dart';
part 'portfolio_product_order_options_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class PortfolioProductOrderOptionsVo with _$PortfolioProductOrderOptionsVo {
  PortfolioProductOrderOptionsVo._();

  factory PortfolioProductOrderOptionsVo({
     String? newProductOrderReferenceNumber, 
     String? optionType, 
     String? optionStatus, 
     double? amount, 
     String? statusString, 
     int? createdAt, 
     String? clientSignatureStatus, 
     String? witnessSignatureStatus, 
    
  }) = _PortfolioProductOrderOptionsVo;
  
  factory PortfolioProductOrderOptionsVo.fromJson(Map<String, dynamic> json) => _$PortfolioProductOrderOptionsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "newProductOrderReferenceNumber" : 'string',
  //   "optionType" : 'string',
  //   "optionStatus" : 'string',
  //   "amount" : 0,
  //   "statusString" : 'string',
  //   "createdAt" : 0,
  //   "clientSignatureStatus" : 'string',
  //   "witnessSignatureStatus" : 'string',
  //   
  // };
}