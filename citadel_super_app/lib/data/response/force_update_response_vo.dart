// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'force_update_response_vo.freezed.dart';
part 'force_update_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ForceUpdateResponseVo with _$ForceUpdateResponseVo {
  ForceUpdateResponseVo._();

  factory ForceUpdateResponseVo({
     String? code,
     String? message,
     bool? updateRequired,
     String? updateLink,
    
  }) = _ForceUpdateResponseVo;
  
  factory ForceUpdateResponseVo.fromJson(Map<String, dynamic> json) => _$ForceUpdateResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "updateRequired" : false,
  //   "updateLink" : 'string',
  //   
  // };
}