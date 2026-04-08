// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'test_i_d_requestuest.freezed.dart';
part 'test_i_d_requestuest.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class TestIDRequestuest with _$TestIDRequestuest {
  TestIDRequestuest._();

  factory TestIDRequestuest({
     List<int>? longIds,
    
  }) = _TestIDRequestuest;
  
  factory TestIDRequestuest.fromJson(Map<String, dynamic> json) => _$TestIDRequestuestFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'longIds' : int.toExampleApiJson(),
  //   
  // };
}