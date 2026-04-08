// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'otp_verification_request.freezed.dart';
part 'otp_verification_request.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class OtpVerificationRequest with _$OtpVerificationRequest {
  OtpVerificationRequest._();

  factory OtpVerificationRequest({
     String? otp,
    
  }) = _OtpVerificationRequest;
  
  factory OtpVerificationRequest.fromJson(Map<String, dynamic> json) => _$OtpVerificationRequestFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'otp' : 'string',
  //   
  // };
}