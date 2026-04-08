// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'contact_us_form_submit_request_vo.freezed.dart';
part 'contact_us_form_submit_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ContactUsFormSubmitRequestVo with _$ContactUsFormSubmitRequestVo {
  ContactUsFormSubmitRequestVo._();

  factory ContactUsFormSubmitRequestVo({
     String? name,
     String? mobileCountryCode,
     String? mobileNumber,
     String? email,
     String? reason,
     String? remark,
    
  }) = _ContactUsFormSubmitRequestVo;
  
  factory ContactUsFormSubmitRequestVo.fromJson(Map<String, dynamic> json) => _$ContactUsFormSubmitRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'name' : 'string',
  //   'mobileCountryCode' : 'string',
  //   'mobileNumber' : 'string',
  //   'email' : 'string',
  //   'reason' : 'string',
  //   'remark' : 'string',
  //   
  // };
}