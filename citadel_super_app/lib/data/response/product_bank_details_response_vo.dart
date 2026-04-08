// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'product_bank_details_response_vo.freezed.dart';
part 'product_bank_details_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ProductBankDetailsResponseVo with _$ProductBankDetailsResponseVo {
  ProductBankDetailsResponseVo._();

  factory ProductBankDetailsResponseVo({
     String? code,
     String? message,
     String? bankName,
     String? bankAccountName,
     String? bankAccountNumber,
    
  }) = _ProductBankDetailsResponseVo;
  
  factory ProductBankDetailsResponseVo.fromJson(Map<String, dynamic> json) => _$ProductBankDetailsResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "bankName" : 'string',
  //   "bankAccountName" : 'string',
  //   "bankAccountNumber" : 'string',
  //   
  // };
}