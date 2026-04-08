// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'agent_personal_details_vo.freezed.dart';
part 'agent_personal_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class AgentPersonalDetailsVo with _$AgentPersonalDetailsVo {
  AgentPersonalDetailsVo._();

  factory AgentPersonalDetailsVo({
     String? name, 
     String? identityDocumentType, 
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
     String? profilePicture, 
    
  }) = _AgentPersonalDetailsVo;
  
  factory AgentPersonalDetailsVo.fromJson(Map<String, dynamic> json) => _$AgentPersonalDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "name" : 'string',
  //   "identityDocumentType" : 'string',
  //   "identityCardNumber" : 'string',
  //   "dob" : 0,
  //   "address" : 'string',
  //   "postcode" : 'string',
  //   "city" : 'string',
  //   "state" : 'string',
  //   "country" : 'string',
  //   "mobileCountryCode" : 'string',
  //   "mobileNumber" : 'string',
  //   "email" : 'string',
  //   "profilePicture" : 'string',
  //   
  // };
}