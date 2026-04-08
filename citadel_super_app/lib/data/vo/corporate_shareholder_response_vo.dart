// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_shareholder_response_vo.freezed.dart';
part 'corporate_shareholder_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class CorporateShareholderResponseVo with _$CorporateShareholderResponseVo {
  CorporateShareholderResponseVo._();

  factory CorporateShareholderResponseVo({
     int? id, 
     String? name, 
     double? percentageOfShareholdings, 
     String? mobileCountryCode, 
     String? mobileNumber, 
     String? email, 
     String? address, 
     String? postcode, 
     String? city, 
     String? state, 
     String? country, 
    
  }) = _CorporateShareholderResponseVo;
  
  factory CorporateShareholderResponseVo.fromJson(Map<String, dynamic> json) => _$CorporateShareholderResponseVoFromJson(json);

  // To form example request/response for API test
  static Map<String, dynamic> toExampleApiJson() => {
    "id" : 0,
    "name" : 'string',
    "percentageOfShareholdings" : 0,
    "mobileCountryCode" : 'string',
    "mobileNumber" : 'string',
    "email" : 'string',
    "address" : 'string',
    "postcode" : 'string',
    "city" : 'string',
    "state" : 'string',
    "country" : 'string',
    
  };
}