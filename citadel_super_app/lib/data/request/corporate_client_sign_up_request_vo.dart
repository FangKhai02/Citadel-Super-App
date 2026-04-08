// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/corporate_details_request_vo.dart';


part 'corporate_client_sign_up_request_vo.freezed.dart';
part 'corporate_client_sign_up_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateClientSignUpRequestVo with _$CorporateClientSignUpRequestVo {
  CorporateClientSignUpRequestVo._();

  factory CorporateClientSignUpRequestVo({
     CorporateDetailsRequestVo? corporateDetails,
     String? annualIncomeDeclaration,
     String? sourceOfIncome,
     String? digitalSignature,
    
  }) = _CorporateClientSignUpRequestVo;
  
  factory CorporateClientSignUpRequestVo.fromJson(Map<String, dynamic> json) => _$CorporateClientSignUpRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'corporateDetails' : CorporateDetailsReqVo.toExampleApiJson(),
  //   'annualIncomeDeclaration' : 'string',
  //   'sourceOfIncome' : 'string',
  //   'digitalSignature' : 'string',
  //   
  // };
}