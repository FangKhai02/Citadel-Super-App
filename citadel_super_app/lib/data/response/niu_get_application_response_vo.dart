// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/niu_get_application_details_vo.dart';


part 'niu_get_application_response_vo.freezed.dart';
part 'niu_get_application_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class NiuGetApplicationResponseVo with _$NiuGetApplicationResponseVo {
  NiuGetApplicationResponseVo._();

  factory NiuGetApplicationResponseVo({
     String? code,
     String? message,
     List<NiuGetApplicationDetailsVo>? applications,
    
  }) = _NiuGetApplicationResponseVo;
  
  factory NiuGetApplicationResponseVo.fromJson(Map<String, dynamic> json) => _$NiuGetApplicationResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "applications" : NiuGetApplicationDetailsVo.toExampleApiJson(),
  //   
  // };
}