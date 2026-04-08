// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/key_value_map_vo.dart';


part 'constant_vo.freezed.dart';
part 'constant_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ConstantVo with _$ConstantVo {
  ConstantVo._();

  factory ConstantVo({
     String? category, 
     List<KeyValueMapVo>? list, 
    
  }) = _ConstantVo;
  
  factory ConstantVo.fromJson(Map<String, dynamic> json) => _$ConstantVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "category" : 'string',
  //   "list" : KeyValueMapVo.toExampleApiJson(),
  //   
  // };
}