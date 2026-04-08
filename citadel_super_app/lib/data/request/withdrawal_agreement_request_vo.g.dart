// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_agreement_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WithdrawalAgreementRequestVoImpl _$$WithdrawalAgreementRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$WithdrawalAgreementRequestVoImpl(
      digitalSignature: json['digitalSignature'] as String?,
      fullName: json['fullName'] as String?,
      identityCardNumber: json['identityCardNumber'] as String?,
    );

Map<String, dynamic> _$$WithdrawalAgreementRequestVoImplToJson(
        _$WithdrawalAgreementRequestVoImpl instance) =>
    <String, dynamic>{
      'digitalSignature': instance.digitalSignature,
      'fullName': instance.fullName,
      'identityCardNumber': instance.identityCardNumber,
    };
