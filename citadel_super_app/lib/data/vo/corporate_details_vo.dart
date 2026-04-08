// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/corporate_address_details_vo.dart';


part 'corporate_details_vo.freezed.dart';
part 'corporate_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateDetailsVo with _$CorporateDetailsVo {
  CorporateDetailsVo._();

  factory CorporateDetailsVo({
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
     CorporateAddressDetailsVo? corporateAddressDetails, 
     String? contactName, 
     bool? contactIsMyself, 
     String? contactDesignation, 
     String? contactCountryCode, 
     String? contactMobileNumber, 
     String? contactEmail, 
    
  }) = _CorporateDetailsVo;
  
  factory CorporateDetailsVo.fromJson(Map<String, dynamic> json) => _$CorporateDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "entityName" : 'string',
  //   "entityType" : 'string',
  //   "registrationNumber" : 'string',
  //   "dateIncorporate" : 0,
  //   "placeIncorporate" : 'string',
  //   "businessType" : 'string',
  //   "registeredAddress" : 'string',
  //   "city" : 'string',
  //   "state" : 'string',
  //   "postcode" : 'string',
  //   "country" : 'string',
  //   "corporateAddressDetails" : CorporateAddressDetailsVo.toExampleApiJson(),
  //   "contactName" : 'string',
  //   "contactIsMyself" : false,
  //   "contactDesignation" : 'string',
  //   "contactCountryCode" : 'string',
  //   "contactMobileNumber" : 'string',
  //   "contactEmail" : 'string',
  //   
  // };
}