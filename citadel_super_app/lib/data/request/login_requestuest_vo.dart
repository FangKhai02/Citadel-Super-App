// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'login_requestuest_vo.freezed.dart';
part 'login_requestuest_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class LoginRequestuestVo with _$LoginRequestuestVo {
  LoginRequestuestVo._();

  factory LoginRequestuestVo({
     String? email,
     String? password,
     String? oneSignalSubscriptionId,
    
  }) = _LoginRequestuestVo;
  
  factory LoginRequestuestVo.fromJson(Map<String, dynamic> json) => _$LoginRequestuestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'email' : 'string',
  //   'password' : 'string',
  //   'oneSignalSubscriptionId' : 'string',
  //   
  // };
}