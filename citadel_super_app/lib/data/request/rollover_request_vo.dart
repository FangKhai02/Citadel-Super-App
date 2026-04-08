// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'rollover_request_vo.freezed.dart';
part 'rollover_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class RolloverRequestVo with _$RolloverRequestVo {
  RolloverRequestVo._();

  factory RolloverRequestVo({
     double? rolloverAmount,
    
  }) = _RolloverRequestVo;
  
  factory RolloverRequestVo.fromJson(Map<String, dynamic> json) => _$RolloverRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'rolloverAmount' : 0,
  //   
  // };
}