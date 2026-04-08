// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'client_profile_image_add_edit_request_vo.freezed.dart';
part 'client_profile_image_add_edit_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientProfileImageAddEditRequestVo with _$ClientProfileImageAddEditRequestVo {
  ClientProfileImageAddEditRequestVo._();

  factory ClientProfileImageAddEditRequestVo({
     String? profilePicture,
    
  }) = _ClientProfileImageAddEditRequestVo;
  
  factory ClientProfileImageAddEditRequestVo.fromJson(Map<String, dynamic> json) => _$ClientProfileImageAddEditRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'profilePicture' : 'string',
  //   
  // };
}