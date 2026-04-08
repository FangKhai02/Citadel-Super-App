// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/corporate_client_vo.dart';
import '../vo/corporate_details_vo.dart';
import '../vo/corporate_documents_vo.dart';
import '../vo/corporate_shareholder_base_vo.dart';


part 'corporate_profile_response_vo.freezed.dart';
part 'corporate_profile_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class CorporateProfileResponseVo with _$CorporateProfileResponseVo {
  CorporateProfileResponseVo._();

  factory CorporateProfileResponseVo({
     String? code,
     String? message,
     CorporateClientVo? corporateClient,
     CorporateDetailsVo? corporateDetails,
     List<CorporateDocumentsVo>? corporateDocuments,
     List<CorporateShareholderBaseVo>? bindedCorporateShareholders,
    
  }) = _CorporateProfileResponseVo;
  
  factory CorporateProfileResponseVo.fromJson(Map<String, dynamic> json) => _$CorporateProfileResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "corporateClient" : CorporateClientVo.toExampleApiJson(),
  //   "corporateDetails" : CorporateDetailsVo.toExampleApiJson(),
  //   "corporateDocuments" : CorporateDocumentsVo.toExampleApiJson(),
  //   "bindedCorporateShareholders" : CorporateShareholderBaseVo.toExampleApiJson(),
  //   
  // };
}