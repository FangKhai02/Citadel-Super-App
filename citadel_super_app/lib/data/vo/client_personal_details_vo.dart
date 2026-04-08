// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/corresponding_address.dart';


part 'client_personal_details_vo.freezed.dart';
part 'client_personal_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientPersonalDetailsVo with _$ClientPersonalDetailsVo {
  ClientPersonalDetailsVo._();

  factory ClientPersonalDetailsVo({
     String? name, 
     String? identityDocumentType, 
     String? identityCardNumber, 
     int? dob, 
     String? address, 
     String? postcode, 
     String? city, 
     String? state, 
     String? country, 
     CorrespondingAddress? correspondingAddress, 
     String? nationality, 
     String? mobileCountryCode, 
     String? mobileNumber, 
     String? gender, 
     String? email, 
     String? maritalStatus, 
     String? residentialStatus, 
     String? profilePicture, 
    
  }) = _ClientPersonalDetailsVo;
  
  factory ClientPersonalDetailsVo.fromJson(Map<String, dynamic> json) => _$ClientPersonalDetailsVoFromJson(json);

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
  //   "correspondingAddress" : CorrespondingAddress.toExampleApiJson(),
  //   "nationality" : 'string',
  //   "mobileCountryCode" : 'string',
  //   "mobileNumber" : 'string',
  //   "gender" : 'string',
  //   "email" : 'string',
  //   "maritalStatus" : 'string',
  //   "residentialStatus" : 'string',
  //   "profilePicture" : 'string',
  //   
  // };
}