// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'client_secure_tag_vo.freezed.dart';
part 'client_secure_tag_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientSecureTagVo with _$ClientSecureTagVo {
  ClientSecureTagVo._();

  factory ClientSecureTagVo({
     String? agentName, 
     String? agentId, 
    
  }) = _ClientSecureTagVo;
  
  factory ClientSecureTagVo.fromJson(Map<String, dynamic> json) => _$ClientSecureTagVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "agentName" : 'string',
  //   "agentId" : 'string',
  //   
  // };
}