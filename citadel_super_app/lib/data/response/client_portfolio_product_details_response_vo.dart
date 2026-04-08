// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/client_portfolio_vo.dart';
import '../vo/bank_details_vo.dart';
import '../vo/fund_beneficiary_details_vo.dart';
import '../vo/product_order_payment_details_vo.dart';
import '../vo/product_order_documents_vo.dart';


part 'client_portfolio_product_details_response_vo.freezed.dart';
part 'client_portfolio_product_details_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientPortfolioProductDetailsResponseVo with _$ClientPortfolioProductDetailsResponseVo {
  ClientPortfolioProductDetailsResponseVo._();

  factory ClientPortfolioProductDetailsResponseVo({
     String? code,
     String? message,
     ClientPortfolioVo? clientPortfolio,
     BankDetailsVo? bankDetails,
     List<FundBeneficiaryDetailsVo>? fundBeneficiaries,
     ProductOrderPaymentDetailsVo? paymentDetails,
     ProductOrderDocumentsVo? documents,
     String? agreementNumber,
     bool? rolloverAllowed,
     bool? fullRedemptionAllowed,
     bool? reallocationAllowed,
     bool? earlyRedemptionAllowed,
     bool? displayShareAgreementButton,
    
  }) = _ClientPortfolioProductDetailsResponseVo;
  
  factory ClientPortfolioProductDetailsResponseVo.fromJson(Map<String, dynamic> json) => _$ClientPortfolioProductDetailsResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "clientPortfolio" : ClientPortfolioVo.toExampleApiJson(),
  //   "bankDetails" : BankDetailsVo.toExampleApiJson(),
  //   "fundBeneficiaries" : FundBeneficiaryDetailsVo.toExampleApiJson(),
  //   "paymentDetails" : ProductOrderPaymentDetailsVo.toExampleApiJson(),
  //   "documents" : ProductOrderDocumentsVo.toExampleApiJson(),
  //   "agreementNumber" : 'string',
  //   "rolloverAllowed" : false,
  //   "fullRedemptionAllowed" : false,
  //   "reallocationAllowed" : false,
  //   "earlyRedemptionAllowed" : false,
  //   "displayShareAgreementButton" : false,
  //   
  // };
}