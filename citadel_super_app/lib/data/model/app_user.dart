// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'app_user.freezed.dart';
part 'app_user.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class AppUser with _$AppUser {
  AppUser._();

  factory AppUser({
     String? emailAddress, 
     String? userType, 
    
  }) = _AppUser;
  
  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

  // To form example request for API test
  static Map<String, dynamic> toExampleApiJson() => {
    'emailAddress' : 'string',
    'userType' : 'string',
    
  };
}