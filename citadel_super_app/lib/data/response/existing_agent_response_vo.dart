// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/sign_up_base_identity_details_vo.dart';
import '../vo/sign_up_base_contact_details_vo.dart';
import '../vo/sign_up_agent_agency_details_request_vo.dart';
import '../vo/bank_details_request_vo.dart';


part 'existing_agent_response_vo.freezed.dart';
part 'existing_agent_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ExistingAgentResponseVo with _$ExistingAgentResponseVo {
  ExistingAgentResponseVo._();

  factory ExistingAgentResponseVo({
     String? code,
     String? message,
     SignUpBaseIdentityDetailsVo? identityDetails,
     SignUpBaseContactDetailsVo? contactDetails,
     String? selfieImage,
     SignUpAgentAgencyDetailsRequestVo? agencyDetails,
     String? agencyCode,
     BankDetailsRequestVo? bankDetails,
     String? digitalSignature,
    
  }) = _ExistingAgentResponseVo;
  
  factory ExistingAgentResponseVo.fromJson(Map<String, dynamic> json) => _$ExistingAgentResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "identityDetails" : SignUpBaseIdentityDetailsVo.toExampleApiJson(),
  //   "contactDetails" : SignUpBaseContactDetailsVo.toExampleApiJson(),
  //   "selfieImage" : 'string',
  //   "agencyDetails" : SignUpAgentAgencyDetailsReqVo.toExampleApiJson(),
  //   "agencyCode" : 'string',
  //   "bankDetails" : BankDetailsReqVo.toExampleApiJson(),
  //   "digitalSignature" : 'string',
  //   
  // };
}