// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'reallocatable_product_codes_response_vo.freezed.dart';
part 'reallocatable_product_codes_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ReallocatableProductCodesResponseVo with _$ReallocatableProductCodesResponseVo {
  ReallocatableProductCodesResponseVo._();

  factory ReallocatableProductCodesResponseVo({
     String? code,
     String? message,
     List<String>? productCodes,
    
  }) = _ReallocatableProductCodesResponseVo;
  
  factory ReallocatableProductCodesResponseVo.fromJson(Map<String, dynamic> json) => _$ReallocatableProductCodesResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "productCodes" : 'string',
  //   
  // };
}