// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/bank_details_vo.dart';


part 'corporate_bank_details_list_response_vo.freezed.dart';
part 'corporate_bank_details_list_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateBankDetailsListResponseVo with _$CorporateBankDetailsListResponseVo {
  CorporateBankDetailsListResponseVo._();

  factory CorporateBankDetailsListResponseVo({
     String? code,
     String? message,
     List<BankDetailsVo>? corporateBankDetails,
    
  }) = _CorporateBankDetailsListResponseVo;
  
  factory CorporateBankDetailsListResponseVo.fromJson(Map<String, dynamic> json) => _$CorporateBankDetailsListResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "corporateBankDetails" : BankDetailsVo.toExampleApiJson(),
  //   
  // };
}