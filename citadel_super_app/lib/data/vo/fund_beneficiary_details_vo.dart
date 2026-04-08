// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/fund_beneficiary_details_vo.dart';


part 'fund_beneficiary_details_vo.freezed.dart';
part 'fund_beneficiary_details_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class FundBeneficiaryDetailsVo with _$FundBeneficiaryDetailsVo {
  FundBeneficiaryDetailsVo._();

  factory FundBeneficiaryDetailsVo({
     int? beneficiaryId, 
     String? beneficiaryName, 
     String? relationship, 
     double? distributionPercentage, 
     List<FundBeneficiaryDetailsVo>? subBeneficiaries, 
    
  }) = _FundBeneficiaryDetailsVo;
  
  factory FundBeneficiaryDetailsVo.fromJson(Map<String, dynamic> json) => _$FundBeneficiaryDetailsVoFromJson(json);

  // // To form example request/response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "beneficiaryId" : 0,
  //   "beneficiaryName" : 'string',
  //   "relationship" : 'string',
  //   "distributionPercentage" : 0,
  //   "subBeneficiaries" : FundBeneficiaryDetailsVo.toExampleApiJson(),
  //   
  // };
}