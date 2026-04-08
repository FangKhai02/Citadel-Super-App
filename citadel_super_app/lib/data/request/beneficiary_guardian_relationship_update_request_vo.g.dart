// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_guardian_relationship_update_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BeneficiaryGuardianRelationshipUpdateRequestVoImpl
    _$$BeneficiaryGuardianRelationshipUpdateRequestVoImplFromJson(
            Map<String, dynamic> json) =>
        _$BeneficiaryGuardianRelationshipUpdateRequestVoImpl(
          guardianId: (json['guardianId'] as num?)?.toInt(),
          beneficiaryId: (json['beneficiaryId'] as num?)?.toInt(),
          relationshipToGuardian: json['relationshipToGuardian'] as String?,
          relationshipToBeneficiary:
              json['relationshipToBeneficiary'] as String?,
        );

Map<String, dynamic>
    _$$BeneficiaryGuardianRelationshipUpdateRequestVoImplToJson(
            _$BeneficiaryGuardianRelationshipUpdateRequestVoImpl instance) =>
        <String, dynamic>{
          'guardianId': instance.guardianId,
          'beneficiaryId': instance.beneficiaryId,
          'relationshipToGuardian': instance.relationshipToGuardian,
          'relationshipToBeneficiary': instance.relationshipToBeneficiary,
        };
