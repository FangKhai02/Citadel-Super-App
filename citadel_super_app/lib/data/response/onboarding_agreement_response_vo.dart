// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'onboarding_agreement_response_vo.freezed.dart';
part 'onboarding_agreement_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class OnboardingAgreementResponseVo with _$OnboardingAgreementResponseVo {
  OnboardingAgreementResponseVo._();

  factory OnboardingAgreementResponseVo({
     String? code,
     String? message,
     String? html,
    
  }) = _OnboardingAgreementResponseVo;
  
  factory OnboardingAgreementResponseVo.fromJson(Map<String, dynamic> json) => _$OnboardingAgreementResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "html" : 'string',
  //   
  // };
}