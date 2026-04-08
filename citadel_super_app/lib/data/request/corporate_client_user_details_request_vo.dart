// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_client_user_details_request_vo.freezed.dart';
part 'corporate_client_user_details_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class CorporateClientUserDetailsRequestVo with _$CorporateClientUserDetailsRequestVo {
  CorporateClientUserDetailsRequestVo._();

  factory CorporateClientUserDetailsRequestVo({
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
     String? identityCardFrontImageKey,
     String? identityCardBackImageKey,
    
  }) = _CorporateClientUserDetailsRequestVo;
  
  factory CorporateClientUserDetailsRequestVo.fromJson(Map<String, dynamic> json) => _$CorporateClientUserDetailsRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'name' : 'string',
  //   'identityCardNumber' : 'string',
  //   'dob' : 0,
  //   'address' : 'string',
  //   'postcode' : 'string',
  //   'city' : 'string',
  //   'state' : 'string',
  //   'country' : 'string',
  //   'mobileCountryCode' : 'string',
  //   'mobileNumber' : 'string',
  //   'email' : 'string',
  //   'identityCardFrontImageKey' : 'string',
  //   'identityCardBackImageKey' : 'string',
  //   
  // };
}