// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_client_vo.freezed.dart';
part 'corporate_client_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateClientVo with _$CorporateClientVo {
  CorporateClientVo._();

  factory CorporateClientVo({
     int? id, 
     String? corporateClientId, 
     String? referenceNumber, 
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
     String? digitalSignature, 
     String? status, 
     String? approvalRemark, 
    
  }) = _CorporateClientVo;
  
  factory CorporateClientVo.fromJson(Map<String, dynamic> json) => _$CorporateClientVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "id" : 0,
  //   "corporateClientId" : 'string',
  //   "referenceNumber" : 'string',
  //   "profilePicture" : 'string',
  //   "name" : 'string',
  //   "identityCardNumber" : 'string',
  //   "dob" : 0,
  //   "address" : 'string',
  //   "postcode" : 'string',
  //   "city" : 'string',
  //   "state" : 'string',
  //   "country" : 'string',
  //   "mobileCountryCode" : 'string',
  //   "mobileNumber" : 'string',
  //   "email" : 'string',
  //   "annualIncomeDeclaration" : 'string',
  //   "sourceOfIncome" : 'string',
  //   "digitalSignature" : 'string',
  //   "status" : 'string',
  //   "approvalRemark" : 'string',
  //   
  // };
}