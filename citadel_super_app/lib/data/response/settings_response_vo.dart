// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/settings_item_vo.dart';


part 'settings_response_vo.freezed.dart';
part 'settings_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class SettingsResponseVo with _$SettingsResponseVo {
  SettingsResponseVo._();

  factory SettingsResponseVo({
     String? code,
     String? message,
     List<SettingsItemVo>? settings,
    
  }) = _SettingsResponseVo;
  
  factory SettingsResponseVo.fromJson(Map<String, dynamic> json) => _$SettingsResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "settings" : SettingsItemVo.toExampleApiJson(),
  //   
  // };
}