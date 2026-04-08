// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'niu_apply_signee_vo.freezed.dart';
part 'niu_apply_signee_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class NiuApplySigneeVo with _$NiuApplySigneeVo {
  NiuApplySigneeVo._();

  factory NiuApplySigneeVo({
     String? fullName, 
     String? nric, 
     int? signedDate, 
     String? signature, 
    
  }) = _NiuApplySigneeVo;
  
  factory NiuApplySigneeVo.fromJson(Map<String, dynamic> json) => _$NiuApplySigneeVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "fullName" : 'string',
  //   "nric" : 'string',
  //   "signedDate" : 0,
  //   "signature" : 'string',
  //   
  // };
}