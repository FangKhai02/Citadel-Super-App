// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/client_secure_tag_vo.dart';


part 'client_secure_tag_response_vo.freezed.dart';
part 'client_secure_tag_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientSecureTagResponseVo with _$ClientSecureTagResponseVo {
  ClientSecureTagResponseVo._();

  factory ClientSecureTagResponseVo({
     String? code,
     String? message,
     ClientSecureTagVo? secureTag,
    
  }) = _ClientSecureTagResponseVo;
  
  factory ClientSecureTagResponseVo.fromJson(Map<String, dynamic> json) => _$ClientSecureTagResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "secureTag" : ClientSecureTagVo.toExampleApiJson(),
  //   
  // };
}