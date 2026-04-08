// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/product_order_payment_receipt_vo.dart';


part 'product_order_payment_upload_response_vo.freezed.dart';
part 'product_order_payment_upload_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ProductOrderPaymentUploadResponseVo with _$ProductOrderPaymentUploadResponseVo {
  ProductOrderPaymentUploadResponseVo._();

  factory ProductOrderPaymentUploadResponseVo({
     String? code,
     String? message,
     List<ProductOrderPaymentReceiptVo>? paymentReceipts,
    
  }) = _ProductOrderPaymentUploadResponseVo;
  
  factory ProductOrderPaymentUploadResponseVo.fromJson(Map<String, dynamic> json) => _$ProductOrderPaymentUploadResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "paymentReceipts" : ProductOrderPaymentReceiptVo.toExampleApiJson(),
  //   
  // };
}