// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/client_personal_details_vo.dart';
import '../vo/client_employment_details_vo.dart';
import '../vo/client_wealth_source_details_vo.dart';
import '../vo/client_agent_details_vo.dart';
import '../vo/pep_declaration_vo.dart';


part 'client_profile_response_vo.freezed.dart';
part 'client_profile_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientProfileResponseVo with _$ClientProfileResponseVo {
  ClientProfileResponseVo._();

  factory ClientProfileResponseVo({
     String? code,
     String? message,
     String? clientId,
     ClientPersonalDetailsVo? personalDetails,
     ClientEmploymentDetailsVo? employmentDetails,
     ClientWealthSourceDetailsVo? wealthSourceDetails,
     ClientAgentDetailsVo? agentDetails,
     PepDeclarationVo? pepDeclaration,
    
  }) = _ClientProfileResponseVo;
  
  factory ClientProfileResponseVo.fromJson(Map<String, dynamic> json) => _$ClientProfileResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "clientId" : 'string',
  //   "personalDetails" : ClientPersonalDetailsVo.toExampleApiJson(),
  //   "employmentDetails" : ClientEmploymentDetailsVo.toExampleApiJson(),
  //   "wealthSourceDetails" : ClientWealthSourceDetailsVo.toExampleApiJson(),
  //   "agentDetails" : ClientAgentDetailsVo.toExampleApiJson(),
  //   "pepDeclaration" : PepDeclarationVo.toExampleApiJson(),
  //   
  // };
}