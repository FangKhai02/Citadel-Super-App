// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'product_order_documents_vo.freezed.dart';
part 'product_order_documents_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ProductOrderDocumentsVo with _$ProductOrderDocumentsVo {
  ProductOrderDocumentsVo._();

  factory ProductOrderDocumentsVo({
     String? profitSharingSchedule, 
     String? officialReceipt, 
     String? statementOfAccount, 
    
  }) = _ProductOrderDocumentsVo;
  
  factory ProductOrderDocumentsVo.fromJson(Map<String, dynamic> json) => _$ProductOrderDocumentsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "profitSharingSchedule" : 'string',
  //   "officialReceipt" : 'string',
  //   "statementOfAccount" : 'string',
  //   
  // };
}