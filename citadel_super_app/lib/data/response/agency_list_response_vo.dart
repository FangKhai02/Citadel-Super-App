// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/agency_vo.dart';


part 'agency_list_response_vo.freezed.dart';
part 'agency_list_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgencyListResponseVo with _$AgencyListResponseVo {
  AgencyListResponseVo._();

  factory AgencyListResponseVo({
     String? code,
     String? message,
     List<AgencyVo>? agencyList,
    
  }) = _AgencyListResponseVo;
  
  factory AgencyListResponseVo.fromJson(Map<String, dynamic> json) => _$AgencyListResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "agencyList" : AgencyVo.toExampleApiJson(),
  //   
  // };
}