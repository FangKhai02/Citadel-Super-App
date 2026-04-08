// GENERATED CODE FROM MASON - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';



part 'beneficiary_guardian_relationship_update_request_vo.freezed.dart';
part 'beneficiary_guardian_relationship_update_request_vo.g.dart';

// `@freezed`, which does not come with setter
// `@unfreezed` for getter and setter usage
@unfreezed
abstract class BeneficiaryGuardianRelationshipUpdateRequestVo with _$BeneficiaryGuardianRelationshipUpdateRequestVo {
  BeneficiaryGuardianRelationshipUpdateRequestVo._();

  factory BeneficiaryGuardianRelationshipUpdateRequestVo({
     int? guardianId,
     int? beneficiaryId,
     String? relationshipToGuardian,
     String? relationshipToBeneficiary,
    
  }) = _BeneficiaryGuardianRelationshipUpdateRequestVo;
  
  factory BeneficiaryGuardianRelationshipUpdateRequestVo.fromJson(Map<String, dynamic> json) => _$BeneficiaryGuardianRelationshipUpdateRequestVoFromJson(json);

  // // To form example request for API test
  // static Map<String, dynamic> toExampleApiJson() => {
  //   'guardianId' : 0,
  //   'beneficiaryId' : 0,
  //   'relationshipToGuardian' : 'string',
  //   'relationshipToBeneficiary' : 'string',
  //   
  // };
}