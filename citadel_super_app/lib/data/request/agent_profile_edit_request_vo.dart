// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agent_profile_edit_request_vo.freezed.dart';
part 'agent_profile_edit_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentProfileEditRequestVo with _$AgentProfileEditRequestVo {
  AgentProfileEditRequestVo._();

  factory AgentProfileEditRequestVo({
     String? address,
     String? postcode,
     String? city,
     String? state,
     String? country,
     String? mobileCountryCode,
     String? mobileNumber,
     String? email,
    
  }) = _AgentProfileEditRequestVo;
  
  factory AgentProfileEditRequestVo.fromJson(Map<String, dynamic> json) => _$AgentProfileEditRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'address' : 'string',
  //   'postcode' : 'string',
  //   'city' : 'string',
  //   'state' : 'string',
  //   'country' : 'string',
  //   'mobileCountryCode' : 'string',
  //   'mobileNumber' : 'string',
  //   'email' : 'string',
  //   
  // };
}