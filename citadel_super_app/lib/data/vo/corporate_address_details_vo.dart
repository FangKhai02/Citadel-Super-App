// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_address_details_vo.freezed.dart';
part 'corporate_address_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateAddressDetailsVo with _$CorporateAddressDetailsVo {
  CorporateAddressDetailsVo._();

  factory CorporateAddressDetailsVo({
     bool? isDifferentRegisteredAddress, 
     String? businessAddress, 
     String? businessPostcode, 
     String? businessCity, 
     String? businessState, 
     String? businessCountry, 
    
  }) = _CorporateAddressDetailsVo;
  
  factory CorporateAddressDetailsVo.fromJson(Map<String, dynamic> json) => _$CorporateAddressDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "isDifferentRegisteredAddress" : false,
  //   "businessAddress" : 'string',
  //   "businessPostcode" : 'string',
  //   "businessCity" : 'string',
  //   "businessState" : 'string',
  //   "businessCountry" : 'string',
  //   
  // };
}