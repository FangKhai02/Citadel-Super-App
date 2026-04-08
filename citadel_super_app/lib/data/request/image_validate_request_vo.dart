// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'image_validate_request_vo.freezed.dart';
part 'image_validate_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ImageValidateRequestVo with _$ImageValidateRequestVo {
  ImageValidateRequestVo._();

  factory ImageValidateRequestVo({
     String? idPhoto,
     String? selfie,
     String? idNumber,
     double? confidence,
     double? livenessScore,
    
  }) = _ImageValidateRequestVo;
  
  factory ImageValidateRequestVo.fromJson(Map<String, dynamic> json) => _$ImageValidateRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'idPhoto' : 'string',
  //   'selfie' : 'string',
  //   'idNumber' : 'string',
  //   'confidence' : 0,
  //   'livenessScore' : 0,
  //   
  // };
}