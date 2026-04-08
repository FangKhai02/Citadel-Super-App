// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_client_response_vo.freezed.dart';
part 'corporate_client_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class CorporateClientResponseVo with _$CorporateClientResponseVo {
  CorporateClientResponseVo._();

  factory CorporateClientResponseVo({
     int? id, 
     String? profilePicture, 
     String? name, 
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
     String? annualIncomeDeclaration, 
     String? sourceOfIncome, 
    
  }) = _CorporateClientResponseVo;
  
  factory CorporateClientResponseVo.fromJson(Map<String, dynamic> json) => _$CorporateClientResponseVoFromJson(json);

  // To form example request/response for API test
  static Map<String, dynamic> toExampleApiJson() => {
    "id" : 0,
    "profilePicture" : 'string',
    "name" : 'string',
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
    "annualIncomeDeclaration" : 'string',
    "sourceOfIncome" : 'string',
    
  };
}