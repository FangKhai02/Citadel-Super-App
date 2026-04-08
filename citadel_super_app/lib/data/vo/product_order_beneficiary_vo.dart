// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'product_order_beneficiary_vo.freezed.dart';
part 'product_order_beneficiary_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class ProductOrderBeneficiaryVo with _$ProductOrderBeneficiaryVo {
  ProductOrderBeneficiaryVo._();

  factory ProductOrderBeneficiaryVo({
     int? beneficiaryId, 
     double? distributionPercentage, 
    
  }) = _ProductOrderBeneficiaryVo;
  
  factory ProductOrderBeneficiaryVo.fromJson(Map<String, dynamic> json) => _$ProductOrderBeneficiaryVoFromJson(json);

  // To form example request/response for API test
  static Map<String, dynamic> toExampleApiJson() => {
    "beneficiaryId" : 0,
    "distributionPercentage" : 0,
    
  };
}