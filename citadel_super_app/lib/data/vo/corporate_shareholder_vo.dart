// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/pep_declaration_vo.dart';


part 'corporate_shareholder_vo.freezed.dart';
part 'corporate_shareholder_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateShareholderVo with _$CorporateShareholderVo {
  CorporateShareholderVo._();

  factory CorporateShareholderVo({
     int? id, 
     String? name, 
     double? percentageOfShareholdings, 
     String? status, 
     String? mobileCountryCode, 
     String? mobileNumber, 
     String? email, 
     String? address, 
     String? postcode, 
     String? city, 
     String? state, 
     String? country, 
     PepDeclarationVo? pepDeclaration, 
    
  }) = _CorporateShareholderVo;
  
  factory CorporateShareholderVo.fromJson(Map<String, dynamic> json) => _$CorporateShareholderVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "id" : 0,
  //   "name" : 'string',
  //   "percentageOfShareholdings" : 0,
  //   "status" : 'string',
  //   "mobileCountryCode" : 'string',
  //   "mobileNumber" : 'string',
  //   "email" : 'string',
  //   "address" : 'string',
  //   "postcode" : 'string',
  //   "city" : 'string',
  //   "state" : 'string',
  //   "country" : 'string',
  //   "pepDeclaration" : PepDeclarationVo.toExampleApiJson(),
  //   
  // };
}