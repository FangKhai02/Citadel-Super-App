// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'change_password_request_vo.freezed.dart';
part 'change_password_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ChangePasswordRequestVo with _$ChangePasswordRequestVo {
  ChangePasswordRequestVo._();

  factory ChangePasswordRequestVo({
     String? oldPassword,
     String? newPassword,
    
  }) = _ChangePasswordRequestVo;
  
  factory ChangePasswordRequestVo.fromJson(Map<String, dynamic> json) => _$ChangePasswordRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'oldPassword' : 'string',
  //   'newPassword' : 'string',
  //   
  // };
}