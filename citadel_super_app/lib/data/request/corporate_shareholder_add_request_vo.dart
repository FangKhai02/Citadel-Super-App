// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/corporate_share_holder_add_vo.dart';


part 'corporate_shareholder_add_request_vo.freezed.dart';
part 'corporate_shareholder_add_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateShareholderAddRequestVo with _$CorporateShareholderAddRequestVo {
  CorporateShareholderAddRequestVo._();

  factory CorporateShareholderAddRequestVo({
     List<CorporateShareHolderAddVo>? shareHolders,
    
  }) = _CorporateShareholderAddRequestVo;
  
  factory CorporateShareholderAddRequestVo.fromJson(Map<String, dynamic> json) => _$CorporateShareholderAddRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'shareHolders' : CorporateShareHolderAddVo.toExampleApiJson(),
  //   
  // };
}