// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'employment_details_vo.freezed.dart';
part 'employment_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class EmploymentDetailsVo with _$EmploymentDetailsVo {
  EmploymentDetailsVo._();

  factory EmploymentDetailsVo({
     String? employmentType, 
     String? employerName, 
     String? industryType, 
     String? jobTitle, 
     String? employerAddress, 
     String? postcode, 
     String? city, 
     String? state, 
     String? country, 
    
  }) = _EmploymentDetailsVo;
  
  factory EmploymentDetailsVo.fromJson(Map<String, dynamic> json) => _$EmploymentDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "employmentType" : 'string',
  //   "employerName" : 'string',
  //   "industryType" : 'string',
  //   "jobTitle" : 'string',
  //   "employerAddress" : 'string',
  //   "postcode" : 'string',
  //   "city" : 'string',
  //   "state" : 'string',
  //   "country" : 'string',
  //   
  // };
}