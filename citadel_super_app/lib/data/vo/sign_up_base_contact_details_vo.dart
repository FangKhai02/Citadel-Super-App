// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/corresponding_address.dart';


part 'sign_up_base_contact_details_vo.freezed.dart';
part 'sign_up_base_contact_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class SignUpBaseContactDetailsVo with _$SignUpBaseContactDetailsVo {
  SignUpBaseContactDetailsVo._();

  factory SignUpBaseContactDetailsVo({
     String? address, 
     String? postcode, 
     String? city, 
     String? state, 
     String? country, 
     CorrespondingAddress? correspondingAddress, 
     String? mobileCountryCode, 
     String? mobileNumber, 
     String? email, 
     String? proofOfAddressFile, 
    
  }) = _SignUpBaseContactDetailsVo;
  
  factory SignUpBaseContactDetailsVo.fromJson(Map<String, dynamic> json) => _$SignUpBaseContactDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "address" : 'string',
  //   "postcode" : 'string',
  //   "city" : 'string',
  //   "state" : 'string',
  //   "country" : 'string',
  //   "correspondingAddress" : CorrespondingAddress.toExampleApiJson(),
  //   "mobileCountryCode" : 'string',
  //   "mobileNumber" : 'string',
  //   "email" : 'string',
  //   "proofOfAddressFile" : 'string',
  //   
  // };
}