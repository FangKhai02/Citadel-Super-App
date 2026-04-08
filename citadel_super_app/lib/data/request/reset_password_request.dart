// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'reset_password_request.freezed.dart';
part 'reset_password_request.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class ResetPasswordRequest with _$ResetPasswordRequest {
  ResetPasswordRequest._();

  factory ResetPasswordRequest({
     String? email,
     String? password,
     String? token,
    
  }) = _ResetPasswordRequest;
  
  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) => _$ResetPasswordRequestFromJson(json);

  // To form example request for API test
  static Map<String, dynamic> toExampleApiJson() => {
    'email' : 'string',
    'password' : 'string',
    'token' : 'string',
    
  };
}