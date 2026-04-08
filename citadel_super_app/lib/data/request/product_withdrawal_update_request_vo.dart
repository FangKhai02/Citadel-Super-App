// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'product_withdrawal_update_request_vo.freezed.dart';
part 'product_withdrawal_update_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class ProductWithdrawalUpdateRequestVo with _$ProductWithdrawalUpdateRequestVo {
  ProductWithdrawalUpdateRequestVo._();

  factory ProductWithdrawalUpdateRequestVo({
     String? orderReferenceNumber,
     double? withdrawalAmount,
     String? withdrawalMethod,
     String? withdrawalReason,
     String? withdrawalAgreementKey,
    
  }) = _ProductWithdrawalUpdateRequestVo;
  
  factory ProductWithdrawalUpdateRequestVo.fromJson(Map<String, dynamic> json) => _$ProductWithdrawalUpdateRequestVoFromJson(json);

  // To form example request for API test
  static Map<String, dynamic> toExampleApiJson() => {
    'orderReferenceNumber' : 'string',
    'withdrawalAmount' : 0,
    'withdrawalMethod' : 'string',
    'withdrawalReason' : 'string',
    'withdrawalAgreementKey' : 'string',
    
  };
}