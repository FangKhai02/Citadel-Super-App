// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/guardian_vo.dart';


part 'individual_beneficiary_response_vo.freezed.dart';
part 'individual_beneficiary_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class IndividualBeneficiaryResponseVo with _$IndividualBeneficiaryResponseVo {
  IndividualBeneficiaryResponseVo._();

  factory IndividualBeneficiaryResponseVo({
     String? code,
     String? message,
     bool? isUnderAge,
     GuardianVo? guardianVo,
     int? individualBeneficiaryId,
    
  }) = _IndividualBeneficiaryResponseVo;
  
  factory IndividualBeneficiaryResponseVo.fromJson(Map<String, dynamic> json) => _$IndividualBeneficiaryResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "isUnderAge" : false,
  //   "guardianVo" : GuardianVo.toExampleApiJson(),
  //   "individualBeneficiaryId" : 0,
  //   
  // };
}