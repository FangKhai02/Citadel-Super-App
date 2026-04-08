// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agency_vo.freezed.dart';
part 'agency_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgencyVo with _$AgencyVo {
  AgencyVo._();

  factory AgencyVo({
     String? agencyCode, 
     String? agencyId, 
     String? agencyName, 
    
  }) = _AgencyVo;
  
  factory AgencyVo.fromJson(Map<String, dynamic> json) => _$AgencyVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "agencyCode" : 'string',
  //   "agencyId" : 'string',
  //   "agencyName" : 'string',
  //   
  // };
}