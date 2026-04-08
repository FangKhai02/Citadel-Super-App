// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'client_pin_request_vo.freezed.dart';
part 'client_pin_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientPinRequestVo with _$ClientPinRequestVo {
  ClientPinRequestVo._();

  factory ClientPinRequestVo({
     String? newPin,
     String? oldPin,
    
  }) = _ClientPinRequestVo;
  
  factory ClientPinRequestVo.fromJson(Map<String, dynamic> json) => _$ClientPinRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'newPin' : 'string',
  //   'oldPin' : 'string',
  //   
  // };
}