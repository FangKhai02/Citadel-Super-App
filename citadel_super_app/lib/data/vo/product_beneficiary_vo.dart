// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'product_beneficiary_vo.freezed.dart';
part 'product_beneficiary_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class ProductBeneficiaryVo with _$ProductBeneficiaryVo {
  ProductBeneficiaryVo._();

  factory ProductBeneficiaryVo({
     int? beneficiaryId, 
     String? name, 
     double? distributionPercentage, 
    
  }) = _ProductBeneficiaryVo;
  
  factory ProductBeneficiaryVo.fromJson(Map<String, dynamic> json) => _$ProductBeneficiaryVoFromJson(json);

  // To form example request/response for API test
  static Map<String, dynamic> toExampleApiJson() => {
    "beneficiaryId" : 0,
    "name" : 'string',
    "distributionPercentage" : 0,
    
  };
}