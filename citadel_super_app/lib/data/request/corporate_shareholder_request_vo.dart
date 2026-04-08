// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/pep_declaration_vo.dart';


part 'corporate_shareholder_request_vo.freezed.dart';
part 'corporate_shareholder_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateShareholderRequestVo with _$CorporateShareholderRequestVo {
  CorporateShareholderRequestVo._();

  factory CorporateShareholderRequestVo({
     String? name,
     String? identityCardNumber,
     double? percentageOfShareholdings,
     String? mobileCountryCode,
     String? mobileNumber,
     String? email,
     String? address,
     String? postcode,
     String? city,
     String? state,
     String? country,
     String? identityDocumentType,
     String? identityCardFrontImage,
     String? identityCardBackImage,
     PepDeclarationVo? pepDeclaration,
    
  }) = _CorporateShareholderRequestVo;
  
  factory CorporateShareholderRequestVo.fromJson(Map<String, dynamic> json) => _$CorporateShareholderRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'name' : 'string',
  //   'identityCardNumber' : 'string',
  //   'percentageOfShareholdings' : 0,
  //   'mobileCountryCode' : 'string',
  //   'mobileNumber' : 'string',
  //   'email' : 'string',
  //   'address' : 'string',
  //   'postcode' : 'string',
  //   'city' : 'string',
  //   'state' : 'string',
  //   'country' : 'string',
  //   'identityDocumentType' : 'string',
  //   'identityCardFrontImage' : 'string',
  //   'identityCardBackImage' : 'string',
  //   'pepDeclaration' : PepDeclarationVo.toExampleApiJson(),
  //   
  // };
}