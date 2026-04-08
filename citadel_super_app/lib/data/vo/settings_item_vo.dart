// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'settings_item_vo.freezed.dart';
part 'settings_item_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class SettingsItemVo with _$SettingsItemVo {
  SettingsItemVo._();

  factory SettingsItemVo({
     String? key, 
     String? value, 
     String? displayName, 
    
  }) = _SettingsItemVo;
  
  factory SettingsItemVo.fromJson(Map<String, dynamic> json) => _$SettingsItemVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "key" : 'string',
  //   "value" : 'string',
  //   "displayName" : 'string',
  //   
  // };
}