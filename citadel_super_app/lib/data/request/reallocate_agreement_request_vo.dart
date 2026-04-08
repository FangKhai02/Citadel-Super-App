// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'reallocate_agreement_request_vo.freezed.dart';
part 'reallocate_agreement_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class ReallocateAgreementRequestVo with _$ReallocateAgreementRequestVo {
  ReallocateAgreementRequestVo._();

  factory ReallocateAgreementRequestVo({
     String? digitalSignature,
    
  }) = _ReallocateAgreementRequestVo;
  
  factory ReallocateAgreementRequestVo.fromJson(Map<String, dynamic> json) => _$ReallocateAgreementRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'digitalSignature' : 'string',
  //   
  // };
}