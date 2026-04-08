// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'web_user_delete_request_vo.freezed.dart';
part 'web_user_delete_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class WebUserDeleteRequestVo with _$WebUserDeleteRequestVo {
  WebUserDeleteRequestVo._();

  factory WebUserDeleteRequestVo({
     String? email,
     String? password,
     String? reason,
    
  }) = _WebUserDeleteRequestVo;
  
  factory WebUserDeleteRequestVo.fromJson(Map<String, dynamic> json) => _$WebUserDeleteRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'email' : 'string',
  //   'password' : 'string',
  //   'reason' : 'string',
  //   
  // };
}