// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/corresponding_address.dart';
import '../vo/employment_details_vo.dart';


part 'client_profile_edit_request_vo.freezed.dart';
part 'client_profile_edit_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientProfileEditRequestVo with _$ClientProfileEditRequestVo {
  ClientProfileEditRequestVo._();

  factory ClientProfileEditRequestVo({
     String? name,
     String? address,
     String? postcode,
     String? city,
     String? state,
     String? country,
     CorrespondingAddress? correspondingAddress,
     String? residentialStatus,
     String? maritalStatus,
     String? mobileCountryCode,
     String? mobileNumber,
     String? email,
     EmploymentDetailsVo? employmentDetails,
     String? nationality,
     String? annualIncomeDeclaration,
     String? sourceOfIncome,
    
  }) = _ClientProfileEditRequestVo;
  
  factory ClientProfileEditRequestVo.fromJson(Map<String, dynamic> json) => _$ClientProfileEditRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'name' : 'string',
  //   'address' : 'string',
  //   'postcode' : 'string',
  //   'city' : 'string',
  //   'state' : 'string',
  //   'country' : 'string',
  //   'correspondingAddress' : CorrespondingAddress.toExampleApiJson(),
  //   'residentialStatus' : 'string',
  //   'maritalStatus' : 'string',
  //   'mobileCountryCode' : 'string',
  //   'mobileNumber' : 'string',
  //   'email' : 'string',
  //   'employmentDetails' : EmploymentDetailsVo.toExampleApiJson(),
  //   'nationality' : 'string',
  //   'annualIncomeDeclaration' : 'string',
  //   'sourceOfIncome' : 'string',
  //   
  // };
}