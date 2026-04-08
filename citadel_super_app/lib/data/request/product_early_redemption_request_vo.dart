// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'product_early_redemption_request_vo.freezed.dart';
part 'product_early_redemption_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ProductEarlyRedemptionRequestVo with _$ProductEarlyRedemptionRequestVo {
  ProductEarlyRedemptionRequestVo._();

  factory ProductEarlyRedemptionRequestVo({
     String? orderReferenceNumber,
     double? withdrawalAmount,
     String? withdrawalMethod,
     String? withdrawalReason,
     String? supportingDocumentKey,
    
  }) = _ProductEarlyRedemptionRequestVo;
  
  factory ProductEarlyRedemptionRequestVo.fromJson(Map<String, dynamic> json) => _$ProductEarlyRedemptionRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'orderReferenceNumber' : 'string',
  //   'withdrawalAmount' : 0,
  //   'withdrawalMethod' : 'string',
  //   'withdrawalReason' : 'string',
  //   'supportingDocumentKey' : 'string',
  //   
  // };
}