// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'image_validate_response_vo.freezed.dart';
part 'image_validate_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ImageValidateResponseVo with _$ImageValidateResponseVo {
  ImageValidateResponseVo._();

  factory ImageValidateResponseVo({
     String? code,
     String? message,
     bool? valid,
     double? confidence,
     double? livenessScore,
    
  }) = _ImageValidateResponseVo;
  
  factory ImageValidateResponseVo.fromJson(Map<String, dynamic> json) => _$ImageValidateResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "valid" : false,
  //   "confidence" : 0,
  //   "livenessScore" : 0,
  //   
  // };
}