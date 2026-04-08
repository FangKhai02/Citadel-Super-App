// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'client_identity_details_request_vo.freezed.dart';
part 'client_identity_details_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientIdentityDetailsRequestVo with _$ClientIdentityDetailsRequestVo {
  ClientIdentityDetailsRequestVo._();

  factory ClientIdentityDetailsRequestVo({
     String? fullName, 
     String? identityCardNumber, 
     int? dob, 
     String? identityDocumentType, 
     String? identityCardFrontImage, 
     String? identityCardBackImage, 
     String? gender, 
     String? nationality, 
    
  }) = _ClientIdentityDetailsRequestVo;
  
  factory ClientIdentityDetailsRequestVo.fromJson(Map<String, dynamic> json) => _$ClientIdentityDetailsRequestVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "fullName" : 'string',
  //   "identityCardNumber" : 'string',
  //   "dob" : 0,
  //   "identityDocumentType" : 'string',
  //   "identityCardFrontImage" : 'string',
  //   "identityCardBackImage" : 'string',
  //   "gender" : 'string',
  //   "nationality" : 'string',
  //   
  // };
}