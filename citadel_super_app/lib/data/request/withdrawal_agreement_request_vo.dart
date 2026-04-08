// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'withdrawal_agreement_request_vo.freezed.dart';
part 'withdrawal_agreement_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class WithdrawalAgreementRequestVo with _$WithdrawalAgreementRequestVo {
  WithdrawalAgreementRequestVo._();

  factory WithdrawalAgreementRequestVo({
     String? digitalSignature,
     String? fullName,
     String? identityCardNumber,
    
  }) = _WithdrawalAgreementRequestVo;
  
  factory WithdrawalAgreementRequestVo.fromJson(Map<String, dynamic> json) => _$WithdrawalAgreementRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'digitalSignature' : 'string',
  //   'fullName' : 'string',
  //   'identityCardNumber' : 'string',
  //   
  // };
}