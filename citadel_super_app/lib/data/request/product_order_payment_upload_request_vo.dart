// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/product_order_payment_receipt_vo.dart';


part 'product_order_payment_upload_request_vo.freezed.dart';
part 'product_order_payment_upload_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ProductOrderPaymentUploadRequestVo with _$ProductOrderPaymentUploadRequestVo {
  ProductOrderPaymentUploadRequestVo._();

  factory ProductOrderPaymentUploadRequestVo({
     List<ProductOrderPaymentReceiptVo>? receipts,
    
  }) = _ProductOrderPaymentUploadRequestVo;
  
  factory ProductOrderPaymentUploadRequestVo.fromJson(Map<String, dynamic> json) => _$ProductOrderPaymentUploadRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'receipts' : ProductOrderPaymentReceiptVo.toExampleApiJson(),
  //   
  // };
}