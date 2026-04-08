// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/client_identity_details_request_vo.dart';
import '../vo/client_personal_details_request_vo.dart';
import '../vo/pep_declaration_vo.dart';
import '../vo/employment_details_vo.dart';


part 'client_sign_up_request_vo.freezed.dart';
part 'client_sign_up_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientSignUpRequestVo with _$ClientSignUpRequestVo {
  ClientSignUpRequestVo._();

  factory ClientSignUpRequestVo({
     ClientIdentityDetailsRequestVo? identityDetails,
     ClientPersonalDetailsRequestVo? personalDetails,
     String? selfieImage,
     PepDeclarationVo? pepDeclaration,
     EmploymentDetailsVo? employmentDetails,
     String? digitalSignature,
     String? password,
    
  }) = _ClientSignUpRequestVo;
  
  factory ClientSignUpRequestVo.fromJson(Map<String, dynamic> json) => _$ClientSignUpRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'identityDetails' : ClientIdentityDetailsReqVo.toExampleApiJson(),
  //   'personalDetails' : ClientPersonalDetailsReqVo.toExampleApiJson(),
  //   'selfieImage' : 'string',
  //   'pepDeclaration' : PepDeclarationVo.toExampleApiJson(),
  //   'employmentDetails' : EmploymentDetailsVo.toExampleApiJson(),
  //   'digitalSignature' : 'string',
  //   'password' : 'string',
  //   
  // };
}