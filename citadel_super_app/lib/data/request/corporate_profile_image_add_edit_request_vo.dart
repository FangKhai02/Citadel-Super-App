// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_profile_image_add_edit_request_vo.freezed.dart';
part 'corporate_profile_image_add_edit_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateProfileImageAddEditRequestVo with _$CorporateProfileImageAddEditRequestVo {
  CorporateProfileImageAddEditRequestVo._();

  factory CorporateProfileImageAddEditRequestVo({
     String? profilePicture,
    
  }) = _CorporateProfileImageAddEditRequestVo;
  
  factory CorporateProfileImageAddEditRequestVo.fromJson(Map<String, dynamic> json) => _$CorporateProfileImageAddEditRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'profilePicture' : 'string',
  //   
  // };
}