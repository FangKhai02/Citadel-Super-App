// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'get_maintenance_response_vo.freezed.dart';
part 'get_maintenance_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class GetMaintenanceResponseVo with _$GetMaintenanceResponseVo {
  GetMaintenanceResponseVo._();

  factory GetMaintenanceResponseVo({
     String? code,
     String? message,
     String? startDatetime,
     String? endDatetime,
    
  }) = _GetMaintenanceResponseVo;
  
  factory GetMaintenanceResponseVo.fromJson(Map<String, dynamic> json) => _$GetMaintenanceResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "startDatetime" : 'string',
  //   "endDatetime" : 'string',
  //   
  // };
}