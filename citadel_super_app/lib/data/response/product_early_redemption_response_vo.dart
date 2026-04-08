// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'product_early_redemption_response_vo.freezed.dart';
part 'product_early_redemption_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ProductEarlyRedemptionResponseVo with _$ProductEarlyRedemptionResponseVo {
  ProductEarlyRedemptionResponseVo._();

  factory ProductEarlyRedemptionResponseVo({
     String? code,
     String? message,
     double? penaltyPercentage,
     double? penaltyAmount,
     double? redemptionAmount,
     String? redemptionReferenceNumber,
    
  }) = _ProductEarlyRedemptionResponseVo;
  
  factory ProductEarlyRedemptionResponseVo.fromJson(Map<String, dynamic> json) => _$ProductEarlyRedemptionResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "penaltyPercentage" : 0,
  //   "penaltyAmount" : 0,
  //   "redemptionAmount" : 0,
  //   "redemptionReferenceNumber" : 'string',
  //   
  // };
}