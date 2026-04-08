// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/corresponding_address.dart';


part 'client_personal_details_request_vo.freezed.dart';
part 'client_personal_details_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientPersonalDetailsRequestVo with _$ClientPersonalDetailsRequestVo {
  ClientPersonalDetailsRequestVo._();

  factory ClientPersonalDetailsRequestVo({
     String? address, 
     String? postcode, 
     String? city, 
     String? state, 
     String? country, 
     CorrespondingAddress? correspondingAddress, 
     String? mobileCountryCode, 
     String? mobileNumber, 
     String? email, 
     String? proofOfAddressFile, 
     String? maritalStatus, 
     String? residentialStatus, 
     String? agentReferralCode, 
    
  }) = _ClientPersonalDetailsRequestVo;
  
  factory ClientPersonalDetailsRequestVo.fromJson(Map<String, dynamic> json) => _$ClientPersonalDetailsRequestVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "address" : 'string',
  //   "postcode" : 'string',
  //   "city" : 'string',
  //   "state" : 'string',
  //   "country" : 'string',
  //   "correspondingAddress" : CorrespondingAddress.toExampleApiJson(),
  //   "mobileCountryCode" : 'string',
  //   "mobileNumber" : 'string',
  //   "email" : 'string',
  //   "proofOfAddressFile" : 'string',
  //   "maritalStatus" : 'string',
  //   "residentialStatus" : 'string',
  //   "agentReferralCode" : 'string',
  //   
  // };
}