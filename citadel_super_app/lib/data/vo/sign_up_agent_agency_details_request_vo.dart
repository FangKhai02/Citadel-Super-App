// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'sign_up_agent_agency_details_request_vo.freezed.dart';
part 'sign_up_agent_agency_details_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class SignUpAgentAgencyDetailsRequestVo with _$SignUpAgentAgencyDetailsRequestVo {
  SignUpAgentAgencyDetailsRequestVo._();

  factory SignUpAgentAgencyDetailsRequestVo({
     String? agencyId, 
     String? recruitManagerCode, 
    
  }) = _SignUpAgentAgencyDetailsRequestVo;
  
  factory SignUpAgentAgencyDetailsRequestVo.fromJson(Map<String, dynamic> json) => _$SignUpAgentAgencyDetailsRequestVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "agencyId" : 'string',
  //   "recruitManagerCode" : 'string',
  //   
  // };
}