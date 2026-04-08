// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'trust_fund_agreement_request_vo.freezed.dart';
part 'trust_fund_agreement_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class TrustFundAgreementRequestVo with _$TrustFundAgreementRequestVo {
  TrustFundAgreementRequestVo._();

  factory TrustFundAgreementRequestVo({
     String? digitalSignature,
     String? fullName,
     String? identityCardNumber,
     String? role,
    
  }) = _TrustFundAgreementRequestVo;
  
  factory TrustFundAgreementRequestVo.fromJson(Map<String, dynamic> json) => _$TrustFundAgreementRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'digitalSignature' : 'string',
  //   'fullName' : 'string',
  //   'identityCardNumber' : 'string',
  //   'role' : 'string',
  //   
  // };
}