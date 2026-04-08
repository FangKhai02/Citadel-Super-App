// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'transaction_vo.freezed.dart';
part 'transaction_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class TransactionVo with _$TransactionVo {
  TransactionVo._();

  factory TransactionVo({
     String? transactionType, 
     String? transactionTitle, 
     String? productName, 
     String? agreementNumber, 
     int? transactionDate, 
     double? amount, 
     String? bankName, 
     String? transactionId, 
     String? status, 
     double? trusteeFee, 
    
  }) = _TransactionVo;
  
  factory TransactionVo.fromJson(Map<String, dynamic> json) => _$TransactionVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "transactionType" : 'string',
  //   "transactionTitle" : 'string',
  //   "productName" : 'string',
  //   "agreementNumber" : 'string',
  //   "transactionDate" : 0,
  //   "amount" : 0,
  //   "bankName" : 'string',
  //   "transactionId" : 'string',
  //   "status" : 'string',
  //   "trusteeFee" : 0,
  //   
  // };
}