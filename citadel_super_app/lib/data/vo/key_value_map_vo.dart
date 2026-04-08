// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'key_value_map_vo.freezed.dart';
part 'key_value_map_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class KeyValueMapVo with _$KeyValueMapVo {
  KeyValueMapVo._();

  factory KeyValueMapVo({
     String? key, 
     String? value, 
    
  }) = _KeyValueMapVo;
  
  factory KeyValueMapVo.fromJson(Map<String, dynamic> json) => _$KeyValueMapVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "key" : 'string',
  //   "value" : 'string',
  //   
  // };
}