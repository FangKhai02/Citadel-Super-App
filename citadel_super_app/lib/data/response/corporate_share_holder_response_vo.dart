// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/corporate_shareholder_vo.dart';


part 'corporate_share_holder_response_vo.freezed.dart';
part 'corporate_share_holder_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateShareHolderResponseVo with _$CorporateShareHolderResponseVo {
  CorporateShareHolderResponseVo._();

  factory CorporateShareHolderResponseVo({
     String? code,
     String? message,
     CorporateShareholderVo? corporateShareholder,
    
  }) = _CorporateShareHolderResponseVo;
  
  factory CorporateShareHolderResponseVo.fromJson(Map<String, dynamic> json) => _$CorporateShareHolderResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "corporateShareholder" : CorporateShareholderVo.toExampleApiJson(),
  //   
  // };
}