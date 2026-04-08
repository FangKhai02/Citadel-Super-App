// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_client_validate_two_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateClientValidateTwoRequestVoImpl
    _$$CorporateClientValidateTwoRequestVoImplFromJson(
            Map<String, dynamic> json) =>
        _$CorporateClientValidateTwoRequestVoImpl(
          annualIncomeDeclaration: json['annualIncomeDeclaration'] as String?,
          sourceOfIncome: json['sourceOfIncome'] as String?,
          digitalSignature: json['digitalSignature'] as String?,
        );

Map<String, dynamic> _$$CorporateClientValidateTwoRequestVoImplToJson(
        _$CorporateClientValidateTwoRequestVoImpl instance) =>
    <String, dynamic>{
      'annualIncomeDeclaration': instance.annualIncomeDeclaration,
      'sourceOfIncome': instance.sourceOfIncome,
      'digitalSignature': instance.digitalSignature,
    };
