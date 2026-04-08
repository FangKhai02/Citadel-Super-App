// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agent_profile_image_add_edit_request_vo.freezed.dart';
part 'agent_profile_image_add_edit_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentProfileImageAddEditRequestVo with _$AgentProfileImageAddEditRequestVo {
  AgentProfileImageAddEditRequestVo._();

  factory AgentProfileImageAddEditRequestVo({
     String? profilePicture,
    
  }) = _AgentProfileImageAddEditRequestVo;
  
  factory AgentProfileImageAddEditRequestVo.fromJson(Map<String, dynamic> json) => _$AgentProfileImageAddEditRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'profilePicture' : 'string',
  //   
  // };
}