// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trust_fund_agreement_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrustFundAgreementRequestVoImpl _$$TrustFundAgreementRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$TrustFundAgreementRequestVoImpl(
      digitalSignature: json['digitalSignature'] as String?,
      fullName: json['fullName'] as String?,
      identityCardNumber: json['identityCardNumber'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$$TrustFundAgreementRequestVoImplToJson(
        _$TrustFundAgreementRequestVoImpl instance) =>
    <String, dynamic>{
      'digitalSignature': instance.digitalSignature,
      'fullName': instance.fullName,
      'identityCardNumber': instance.identityCardNumber,
      'role': instance.role,
    };
