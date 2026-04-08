// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/constant_vo.dart';


part 'get_constants_response_vo.freezed.dart';
part 'get_constants_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class GetConstantsResponseVo with _$GetConstantsResponseVo {
  GetConstantsResponseVo._();

  factory GetConstantsResponseVo({
     String? code,
     String? message,
     List<ConstantVo>? constants,
    
  }) = _GetConstantsResponseVo;
  
  factory GetConstantsResponseVo.fromJson(Map<String, dynamic> json) => _$GetConstantsResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "constants" : ConstantVo.toExampleApiJson(),
  //   
  // };
}