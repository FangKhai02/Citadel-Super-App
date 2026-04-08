// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'incremental_amount_list_response_vo.freezed.dart';
part 'incremental_amount_list_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class IncrementalAmountListResponseVo with _$IncrementalAmountListResponseVo {
  IncrementalAmountListResponseVo._();

  factory IncrementalAmountListResponseVo({
     String? code,
     String? message,
     List<double>? amountList,
    
  }) = _IncrementalAmountListResponseVo;
  
  factory IncrementalAmountListResponseVo.fromJson(Map<String, dynamic> json) => _$IncrementalAmountListResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "amountList" : double.toExampleApiJson(),
  //   
  // };
}