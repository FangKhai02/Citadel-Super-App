// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/bank_details_vo.dart';


part 'corporate_bank_details_response_vo.freezed.dart';
part 'corporate_bank_details_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateBankDetailsResponseVo with _$CorporateBankDetailsResponseVo {
  CorporateBankDetailsResponseVo._();

  factory CorporateBankDetailsResponseVo({
     String? code,
     String? message,
     BankDetailsVo? corporateBankDetailsVo,
    
  }) = _CorporateBankDetailsResponseVo;
  
  factory CorporateBankDetailsResponseVo.fromJson(Map<String, dynamic> json) => _$CorporateBankDetailsResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "corporateBankDetailsVo" : BankDetailsVo.toExampleApiJson(),
  //   
  // };
}