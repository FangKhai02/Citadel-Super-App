// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'fund_amount_vo.freezed.dart';
part 'fund_amount_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class FundAmountVo with _$FundAmountVo {
  FundAmountVo._();

  factory FundAmountVo({
     double? amount, 
     double? dividend, 
    
  }) = _FundAmountVo;
  
  factory FundAmountVo.fromJson(Map<String, dynamic> json) => _$FundAmountVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "amount" : 0,
  //   "dividend" : 0,
  //   
  // };
}