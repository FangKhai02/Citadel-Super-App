// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/portfolio_product_order_options_vo.dart';


part 'client_portfolio_vo.freezed.dart';
part 'client_portfolio_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientPortfolioVo with _$ClientPortfolioVo {
  ClientPortfolioVo._();

  factory ClientPortfolioVo({
     String? clientId, 
     String? clientName, 
     String? orderReferenceNumber, 
     String? productName, 
     String? productCode, 
     String? productType, 
     double? purchasedAmount, 
     String? status, 
     String? remark, 
     int? productPurchaseDate, 
     String? clientAgreementStatus, 
     String? witnessAgreementStatus, 
     int? productId, 
     double? productDividendAmount, 
     int? productTenureMonth, 
     int? clientSignatureDate, 
     int? agreementDate, 
     PortfolioProductOrderOptionsVo? optionsVo, 
    
  }) = _ClientPortfolioVo;
  
  factory ClientPortfolioVo.fromJson(Map<String, dynamic> json) => _$ClientPortfolioVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "clientId" : 'string',
  //   "clientName" : 'string',
  //   "orderReferenceNumber" : 'string',
  //   "productName" : 'string',
  //   "productCode" : 'string',
  //   "productType" : 'string',
  //   "purchasedAmount" : 0,
  //   "status" : 'string',
  //   "remark" : 'string',
  //   "productPurchaseDate" : 0,
  //   "clientAgreementStatus" : 'string',
  //   "witnessAgreementStatus" : 'string',
  //   "productId" : 0,
  //   "productDividendAmount" : 0,
  //   "productTenureMonth" : 0,
  //   "clientSignatureDate" : 0,
  //   "agreementDate" : 0,
  //   "optionsVo" : PortfolioProductOrderOptionsVo.toExampleApiJson(),
  //   
  // };
}