// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'sign_up_base_identity_details_vo.freezed.dart';
part 'sign_up_base_identity_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class SignUpBaseIdentityDetailsVo with _$SignUpBaseIdentityDetailsVo {
  SignUpBaseIdentityDetailsVo._();

  factory SignUpBaseIdentityDetailsVo({
     String? fullName, 
     String? identityCardNumber, 
     int? dob, 
     String? identityDocumentType, 
     String? identityCardFrontImage, 
     String? identityCardBackImage, 
    
  }) = _SignUpBaseIdentityDetailsVo;
  
  factory SignUpBaseIdentityDetailsVo.fromJson(Map<String, dynamic> json) => _$SignUpBaseIdentityDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "fullName" : 'string',
  //   "identityCardNumber" : 'string',
  //   "dob" : 0,
  //   "identityDocumentType" : 'string',
  //   "identityCardFrontImage" : 'string',
  //   "identityCardBackImage" : 'string',
  //   
  // };
}