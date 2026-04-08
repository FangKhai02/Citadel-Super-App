// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/product_order_payment_receipt_vo.dart';


part 'product_order_payment_details_vo.freezed.dart';
part 'product_order_payment_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ProductOrderPaymentDetailsVo with _$ProductOrderPaymentDetailsVo {
  ProductOrderPaymentDetailsVo._();

  factory ProductOrderPaymentDetailsVo({
     String? paymentMethod, 
     String? paymentStatus, 
     String? transactionId, 
     String? bankName, 
     List<ProductOrderPaymentReceiptVo>? paymentReceipts, 
    
  }) = _ProductOrderPaymentDetailsVo;
  
  factory ProductOrderPaymentDetailsVo.fromJson(Map<String, dynamic> json) => _$ProductOrderPaymentDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "paymentMethod" : 'string',
  //   "paymentStatus" : 'string',
  //   "transactionId" : 'string',
  //   "bankName" : 'string',
  //   "paymentReceipts" : ProductOrderPaymentReceiptVo.toExampleApiJson(),
  //   
  // };
}