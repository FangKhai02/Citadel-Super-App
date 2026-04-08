// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'reset_password_request_vo.freezed.dart';
part 'reset_password_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ResetPasswordRequestVo with _$ResetPasswordRequestVo {
  ResetPasswordRequestVo._();

  factory ResetPasswordRequestVo({
     String? email,
     String? password,
     String? token,
    
  }) = _ResetPasswordRequestVo;
  
  factory ResetPasswordRequestVo.fromJson(Map<String, dynamic> json) => _$ResetPasswordRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'email' : 'string',
  //   'password' : 'string',
  //   'token' : 'string',
  //   
  // };
}