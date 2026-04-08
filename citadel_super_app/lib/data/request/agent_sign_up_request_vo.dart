// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/sign_up_base_identity_details_vo.dart';
import '../vo/sign_up_base_contact_details_vo.dart';
import '../vo/sign_up_agent_agency_details_request_vo.dart';
import '../vo/bank_details_request_vo.dart';


part 'agent_sign_up_request_vo.freezed.dart';
part 'agent_sign_up_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentSignUpRequestVo with _$AgentSignUpRequestVo {
  AgentSignUpRequestVo._();

  factory AgentSignUpRequestVo({
     SignUpBaseIdentityDetailsVo? identityDetails,
     SignUpBaseContactDetailsVo? contactDetails,
     String? selfieImage,
     SignUpAgentAgencyDetailsRequestVo? agencyDetails,
     BankDetailsRequestVo? bankDetails,
     String? digitalSignature,
     String? password,
    
  }) = _AgentSignUpRequestVo;
  
  factory AgentSignUpRequestVo.fromJson(Map<String, dynamic> json) => _$AgentSignUpRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'identityDetails' : SignUpBaseIdentityDetailsVo.toExampleApiJson(),
  //   'contactDetails' : SignUpBaseContactDetailsVo.toExampleApiJson(),
  //   'selfieImage' : 'string',
  //   'agencyDetails' : SignUpAgentAgencyDetailsReqVo.toExampleApiJson(),
  //   'bankDetails' : BankDetailsReqVo.toExampleApiJson(),
  //   'digitalSignature' : 'string',
  //   'password' : 'string',
  //   
  // };
}