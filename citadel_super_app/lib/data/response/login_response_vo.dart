// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'login_response_vo.freezed.dart';
part 'login_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class LoginResponseVo with _$LoginResponseVo {
  LoginResponseVo._();

  factory LoginResponseVo({
     String? code,
     String? message,
     String? apiKey,
     bool? hasPin,
     String? userType,
    
  }) = _LoginResponseVo;
  
  factory LoginResponseVo.fromJson(Map<String, dynamic> json) => _$LoginResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "apiKey" : 'string',
  //   "hasPin" : false,
  //   "userType" : 'string',
  //   
  // };
}