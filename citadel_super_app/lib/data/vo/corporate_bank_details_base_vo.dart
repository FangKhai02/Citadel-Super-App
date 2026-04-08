// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_bank_details_base_vo.freezed.dart';
part 'corporate_bank_details_base_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
class CorporateBankDetailsBaseVo with _$CorporateBankDetailsBaseVo {
  CorporateBankDetailsBaseVo._();

  factory CorporateBankDetailsBaseVo({
     int? id, 
     String? bankName, 
     String? bankAccountHolderName, 
    
  }) = _CorporateBankDetailsBaseVo;
  
  factory CorporateBankDetailsBaseVo.fromJson(Map<String, dynamic> json) => _$CorporateBankDetailsBaseVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "id" : 0,
  //   "bankName" : 'string',
  //   "bankAccountHolderName" : 'string',
  //   
  // };
}