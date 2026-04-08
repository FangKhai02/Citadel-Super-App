// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'app_user_delete_request_vo.freezed.dart';
part 'app_user_delete_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AppUserDeleteRequestVo with _$AppUserDeleteRequestVo {
  AppUserDeleteRequestVo._();

  factory AppUserDeleteRequestVo({
     String? name,
     String? mobileCountryCode,
     String? mobileNumber,
     String? reason,
     String? pin,
    
  }) = _AppUserDeleteRequestVo;
  
  factory AppUserDeleteRequestVo.fromJson(Map<String, dynamic> json) => _$AppUserDeleteRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'name' : 'string',
  //   'mobileCountryCode' : 'string',
  //   'mobileNumber' : 'string',
  //   'reason' : 'string',
  //   'pin' : 'string',
  //   
  // };
}