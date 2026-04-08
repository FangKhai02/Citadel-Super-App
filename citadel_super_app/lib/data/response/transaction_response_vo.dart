// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/transaction_vo.dart';


part 'transaction_response_vo.freezed.dart';
part 'transaction_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class TransactionResponseVo with _$TransactionResponseVo {
  TransactionResponseVo._();

  factory TransactionResponseVo({
     String? code,
     String? message,
     List<TransactionVo>? transactions,
    
  }) = _TransactionResponseVo;
  
  factory TransactionResponseVo.fromJson(Map<String, dynamic> json) => _$TransactionResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "transactions" : TransactionVo.toExampleApiJson(),
  //   
  // };
}