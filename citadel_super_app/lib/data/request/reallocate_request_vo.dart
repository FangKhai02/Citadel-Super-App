// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'reallocate_request_vo.freezed.dart';
part 'reallocate_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ReallocateRequestVo with _$ReallocateRequestVo {
  ReallocateRequestVo._();

  factory ReallocateRequestVo({
     String? productCode,
     double? amount,
    
  }) = _ReallocateRequestVo;
  
  factory ReallocateRequestVo.fromJson(Map<String, dynamic> json) => _$ReallocateRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'productCode' : 'string',
  //   'amount' : 0,
  //   
  // };
}