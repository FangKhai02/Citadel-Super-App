// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_shareholder_edit_request_vo.freezed.dart';
part 'corporate_shareholder_edit_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateShareholderEditRequestVo with _$CorporateShareholderEditRequestVo {
  CorporateShareholderEditRequestVo._();

  factory CorporateShareholderEditRequestVo({
     int? corporateShareholderId,
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
    
  }) = _CorporateShareholderEditRequestVo;
  
  factory CorporateShareholderEditRequestVo.fromJson(Map<String, dynamic> json) => _$CorporateShareholderEditRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'corporateShareholderId' : 0,
  //   'name' : 'string',
  //   'percentageOfShareholdings' : 0,
  //   'mobileCountryCode' : 'string',
  //   'mobileNumber' : 'string',
  //   'email' : 'string',
  //   'address' : 'string',
  //   'postcode' : 'string',
  //   'city' : 'string',
  //   'state' : 'string',
  //   'country' : 'string',
  //   
  // };
}