// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/fund_beneficiary_details_vo.dart';


part 'product_purchase_beneficiaries_response_vo.freezed.dart';
part 'product_purchase_beneficiaries_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ProductPurchaseBeneficiariesResponseVo with _$ProductPurchaseBeneficiariesResponseVo {
  ProductPurchaseBeneficiariesResponseVo._();

  factory ProductPurchaseBeneficiariesResponseVo({
     String? code,
     String? message,
     List<FundBeneficiaryDetailsVo>? productBeneficiaries,
    
  }) = _ProductPurchaseBeneficiariesResponseVo;
  
  factory ProductPurchaseBeneficiariesResponseVo.fromJson(Map<String, dynamic> json) => _$ProductPurchaseBeneficiariesResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "productBeneficiaries" : FundBeneficiaryDetailsVo.toExampleApiJson(),
  //   
  // };
}