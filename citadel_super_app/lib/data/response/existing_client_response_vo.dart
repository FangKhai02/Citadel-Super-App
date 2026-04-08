// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/client_identity_details_request_vo.dart';
import '../vo/client_personal_details_request_vo.dart';
import '../vo/pep_declaration_vo.dart';
import '../vo/employment_details_vo.dart';


part 'existing_client_response_vo.freezed.dart';
part 'existing_client_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ExistingClientResponseVo with _$ExistingClientResponseVo {
  ExistingClientResponseVo._();

  factory ExistingClientResponseVo({
     String? code,
     String? message,
     ClientIdentityDetailsRequestVo? identityDetails,
     ClientPersonalDetailsRequestVo? personalDetails,
     String? selfieImage,
     PepDeclarationVo? pepDeclaration,
     EmploymentDetailsVo? employmentDetails,
     String? digitalSignature,
     String? agentReferralCode,
     String? password,
    
  }) = _ExistingClientResponseVo;
  
  factory ExistingClientResponseVo.fromJson(Map<String, dynamic> json) => _$ExistingClientResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "identityDetails" : ClientIdentityDetailsReqVo.toExampleApiJson(),
  //   "personalDetails" : ClientPersonalDetailsReqVo.toExampleApiJson(),
  //   "selfieImage" : 'string',
  //   "pepDeclaration" : PepDeclarationVo.toExampleApiJson(),
  //   "employmentDetails" : EmploymentDetailsVo.toExampleApiJson(),
  //   "digitalSignature" : 'string',
  //   "agentReferralCode" : 'string',
  //   "password" : 'string',
  //   
  // };
}