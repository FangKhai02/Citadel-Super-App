// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/bank_details_vo.dart';


part 'create_bank_response_vo.freezed.dart';
part 'create_bank_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CreateBankResponseVo with _$CreateBankResponseVo {
  CreateBankResponseVo._();

  factory CreateBankResponseVo({
     String? code,
     String? message,
     BankDetailsVo? bankDetails,
    
  }) = _CreateBankResponseVo;
  
  factory CreateBankResponseVo.fromJson(Map<String, dynamic> json) => _$CreateBankResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "bankDetails" : BankDetailsVo.toExampleApiJson(),
  //   
  // };
}