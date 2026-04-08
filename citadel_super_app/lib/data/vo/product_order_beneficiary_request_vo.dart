// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/product_order_beneficiary_request_vo.dart';


part 'product_order_beneficiary_request_vo.freezed.dart';
part 'product_order_beneficiary_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ProductOrderBeneficiaryRequestVo with _$ProductOrderBeneficiaryRequestVo {
  ProductOrderBeneficiaryRequestVo._();

  factory ProductOrderBeneficiaryRequestVo({
     int? beneficiaryId, 
     double? distributionPercentage, 
     List<ProductOrderBeneficiaryRequestVo>? subBeneficiaries, 
    
  }) = _ProductOrderBeneficiaryRequestVo;
  
  factory ProductOrderBeneficiaryRequestVo.fromJson(Map<String, dynamic> json) => _$ProductOrderBeneficiaryRequestVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "beneficiaryId" : 0,
  //   "distributionPercentage" : 0,
  //   "subBeneficiaries" : ProductOrderBeneficiaryReqVo.toExampleApiJson(),
  //   
  // };
}