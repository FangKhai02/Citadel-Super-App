// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import '../vo/individual_beneficiary_vo.dart';


part 'client_beneficiary_guardian_response_vo.freezed.dart';
part 'client_beneficiary_guardian_response_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class ClientBeneficiaryGuardianResponseVo with _$ClientBeneficiaryGuardianResponseVo {
  ClientBeneficiaryGuardianResponseVo._();

  factory ClientBeneficiaryGuardianResponseVo({
     String? code,
     String? message,
     List<IndividualBeneficiaryVo>? beneficiaries,
    
  }) = _ClientBeneficiaryGuardianResponseVo;
  
  factory ClientBeneficiaryGuardianResponseVo.fromJson(Map<String, dynamic> json) => _$ClientBeneficiaryGuardianResponseVoFromJson(json);

  // // To form example response for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   "code" : 'string',
  //   "message" : 'string',
  //   "beneficiaries" : IndividualBeneficiaryVo.toExampleApiJson(),
  //   
  // };
}