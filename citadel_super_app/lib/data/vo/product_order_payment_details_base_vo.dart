// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'product_order_payment_details_base_vo.freezed.dart';
part 'product_order_payment_details_base_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ProductOrderPaymentDetailsBaseVo with _$ProductOrderPaymentDetailsBaseVo {
  ProductOrderPaymentDetailsBaseVo._();

  factory ProductOrderPaymentDetailsBaseVo({
     String? paymentMethod, 
     String? paymentStatus, 
    
  }) = _ProductOrderPaymentDetailsBaseVo;
  
  factory ProductOrderPaymentDetailsBaseVo.fromJson(Map<String, dynamic> json) => _$ProductOrderPaymentDetailsBaseVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "paymentMethod" : 'string',
  //   "paymentStatus" : 'string',
  //   
  // };
}