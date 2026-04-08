// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'client_user_details_request_vo.freezed.dart';
part 'client_user_details_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class ClientUserDetailsRequestVo with _$ClientUserDetailsRequestVo {
  ClientUserDetailsRequestVo._();

  factory ClientUserDetailsRequestVo({
     String? fullName, 
     String? identityCardNumber, 
     int? dob, 
     String? address, 
     String? postcode, 
     String? city, 
     String? state, 
     String? country, 
     String? mobileCountryCode, 
     String? mobileNumber, 
     String? email, 
     String? identityCardImage, 
     String? idType, 
     String? gender, 
     String? nationality, 
     String? residentialStatus, 
     String? maritalStatus, 
     String? agentReferralCode, 
    
  }) = _ClientUserDetailsRequestVo;
  
  factory ClientUserDetailsRequestVo.fromJson(Map<String, dynamic> json) => _$ClientUserDetailsRequestVoFromJson(json);

  // To form example request/response for API test
  static Map<String, dynamic> toExampleApiJson() => {
    "fullName" : 'string',
    "identityCardNumber" : 'string',
    "dob" : 0,
    "address" : 'string',
    "postcode" : 'string',
    "city" : 'string',
    "state" : 'string',
    "country" : 'string',
    "mobileCountryCode" : 'string',
    "mobileNumber" : 'string',
    "email" : 'string',
    "identityCardImage" : 'string',
    "idType" : 'string',
    "gender" : 'string',
    "nationality" : 'string',
    "residentialStatus" : 'string',
    "maritalStatus" : 'string',
    "agentReferralCode" : 'string',
    
  };
}