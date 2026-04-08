// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'client_agent_details_vo.freezed.dart';
part 'client_agent_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientAgentDetailsVo with _$ClientAgentDetailsVo {
  ClientAgentDetailsVo._();

  factory ClientAgentDetailsVo({
     String? agentName, 
     String? agentReferralCode, 
     String? agentId, 
     String? agencyName, 
     String? agencyId, 
     String? agentCountryCode, 
     String? agentMobileNumber, 
    
  }) = _ClientAgentDetailsVo;
  
  factory ClientAgentDetailsVo.fromJson(Map<String, dynamic> json) => _$ClientAgentDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "agentName" : 'string',
  //   "agentReferralCode" : 'string',
  //   "agentId" : 'string',
  //   "agencyName" : 'string',
  //   "agencyId" : 'string',
  //   "agentCountryCode" : 'string',
  //   "agentMobileNumber" : 'string',
  //   
  // };
}