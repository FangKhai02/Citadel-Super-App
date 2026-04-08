// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'corporate_share_holder_add_vo.freezed.dart';
part 'corporate_share_holder_add_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateShareHolderAddVo with _$CorporateShareHolderAddVo {
  CorporateShareHolderAddVo._();

  factory CorporateShareHolderAddVo({
     int? id, 
     double? percentageOfShareholdings, 
    
  }) = _CorporateShareHolderAddVo;
  
  factory CorporateShareHolderAddVo.fromJson(Map<String, dynamic> json) => _$CorporateShareHolderAddVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "id" : 0,
  //   "percentageOfShareholdings" : 0,
  //   
  // };
}