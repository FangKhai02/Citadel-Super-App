// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'client_employment_details_vo.freezed.dart';
part 'client_employment_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientEmploymentDetailsVo with _$ClientEmploymentDetailsVo {
  ClientEmploymentDetailsVo._();

  factory ClientEmploymentDetailsVo({
     String? employmentType, 
     String? employerName, 
     String? industryType, 
     String? jobTitle, 
     String? employerAddress, 
     String? employerPostcode, 
     String? employerCity, 
     String? employerState, 
     String? employerCountry, 
    
  }) = _ClientEmploymentDetailsVo;
  
  factory ClientEmploymentDetailsVo.fromJson(Map<String, dynamic> json) => _$ClientEmploymentDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "employmentType" : 'string',
  //   "employerName" : 'string',
  //   "industryType" : 'string',
  //   "jobTitle" : 'string',
  //   "employerAddress" : 'string',
  //   "employerPostcode" : 'string',
  //   "employerCity" : 'string',
  //   "employerState" : 'string',
  //   "employerCountry" : 'string',
  //   
  // };
}