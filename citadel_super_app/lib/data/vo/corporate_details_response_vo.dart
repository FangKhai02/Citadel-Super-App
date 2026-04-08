// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_details_response_vo.freezed.dart';
part 'corporate_details_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class CorporateDetailsResponseVo with _$CorporateDetailsResponseVo {
  CorporateDetailsResponseVo._();

  factory CorporateDetailsResponseVo({
     String? entityName, 
     String? entityType, 
     String? registrationNumber, 
     int? dateIncorporate, 
     String? placeIncorporate, 
     String? businessType, 
     String? registeredAddress, 
     String? city, 
     String? state, 
     String? postcode, 
     String? country, 
     String? businessAddress, 
     String? businessPostcode, 
     String? businessCity, 
     String? businessState, 
     String? businessCountry, 
     String? contactName, 
     String? contactDesignation, 
     String? contactCountryCode, 
     String? contactMobileNumber, 
     String? contactEmail, 
    
  }) = _CorporateDetailsResponseVo;
  
  factory CorporateDetailsResponseVo.fromJson(Map<String, dynamic> json) => _$CorporateDetailsResponseVoFromJson(json);

  // To form example request/response for API test
  static Map<String, dynamic> toExampleApiJson() => {
    "entityName" : 'string',
    "entityType" : 'string',
    "registrationNumber" : 'string',
    "dateIncorporate" : 0,
    "placeIncorporate" : 'string',
    "businessType" : 'string',
    "registeredAddress" : 'string',
    "city" : 'string',
    "state" : 'string',
    "postcode" : 'string',
    "country" : 'string',
    "businessAddress" : 'string',
    "businessPostcode" : 'string',
    "businessCity" : 'string',
    "businessState" : 'string',
    "businessCountry" : 'string',
    "contactName" : 'string',
    "contactDesignation" : 'string',
    "contactCountryCode" : 'string',
    "contactMobileNumber" : 'string',
    "contactEmail" : 'string',
    
  };
}