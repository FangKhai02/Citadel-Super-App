// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/bank_details_vo.dart';
import '../vo/fund_beneficiary_details_vo.dart';


part 'product_purchase_response_vo.freezed.dart';
part 'product_purchase_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class ProductPurchaseResponseVo with _$ProductPurchaseResponseVo {
  ProductPurchaseResponseVo._();

  factory ProductPurchaseResponseVo({
     String? code,
     String? message,
     String? productOrderStatus,
     int? productId,
     String? productOrderReferenceNumber,
     String? productName,
     int? purchasedAmount,
     double? dividend,
     int? investmentTenureMonth,
     BankDetailsVo? bankDetails,
     List<FundBeneficiaryDetailsVo>? productBeneficiaries,
     String? paymentMethod,
     String? paymentStatus,
    
  }) = _ProductPurchaseResponseVo;
  
  factory ProductPurchaseResponseVo.fromJson(Map<String, dynamic> json) => _$ProductPurchaseResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "productOrderStatus" : 'string',
  //   "productId" : 0,
  //   "productOrderReferenceNumber" : 'string',
  //   "productName" : 'string',
  //   "purchasedAmount" : 0,
  //   "dividend" : 0,
  //   "investmentTenureMonth" : 0,
  //   "bankDetails" : BankDetailsVo.toExampleApiJson(),
  //   "productBeneficiaries" : FundBeneficiaryDetailsVo.toExampleApiJson(),
  //   "paymentMethod" : 'string',
  //   "paymentStatus" : 'string',
  //   
  // };
}