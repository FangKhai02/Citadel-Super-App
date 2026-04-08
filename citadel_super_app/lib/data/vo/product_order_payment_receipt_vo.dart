// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'product_order_payment_receipt_vo.freezed.dart';
part 'product_order_payment_receipt_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ProductOrderPaymentReceiptVo with _$ProductOrderPaymentReceiptVo {
  ProductOrderPaymentReceiptVo._();

  factory ProductOrderPaymentReceiptVo({
     int? id, 
     String? fileName, 
     String? file, 
     String? uploadStatus, 
    
  }) = _ProductOrderPaymentReceiptVo;
  
  factory ProductOrderPaymentReceiptVo.fromJson(Map<String, dynamic> json) => _$ProductOrderPaymentReceiptVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "id" : 0,
  //   "fileName" : 'string',
  //   "file" : 'string',
  //   "uploadStatus" : 'string',
  //   
  // };
}