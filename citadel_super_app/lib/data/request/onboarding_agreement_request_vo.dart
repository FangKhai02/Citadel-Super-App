// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'onboarding_agreement_request_vo.freezed.dart';
part 'onboarding_agreement_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class OnboardingAgreementRequestVo with _$OnboardingAgreementRequestVo {
  OnboardingAgreementRequestVo._();

  factory OnboardingAgreementRequestVo({
     String? name,
     String? identityCardNumber,
     String? corporateClientId,
    
  }) = _OnboardingAgreementRequestVo;
  
  factory OnboardingAgreementRequestVo.fromJson(Map<String, dynamic> json) => _$OnboardingAgreementRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'name' : 'string',
  //   'identityCardNumber' : 'string',
  //   'corporateClientId' : 'string',
  //   
  // };
}