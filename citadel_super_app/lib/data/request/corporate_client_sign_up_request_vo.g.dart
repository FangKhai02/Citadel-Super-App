// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_client_sign_up_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateClientSignUpRequestVoImpl
    _$$CorporateClientSignUpRequestVoImplFromJson(Map<String, dynamic> json) =>
        _$CorporateClientSignUpRequestVoImpl(
          corporateDetails: json['corporateDetails'] == null
              ? null
              : CorporateDetailsRequestVo.fromJson(
                  json['corporateDetails'] as Map<String, dynamic>),
          annualIncomeDeclaration: json['annualIncomeDeclaration'] as String?,
          sourceOfIncome: json['sourceOfIncome'] as String?,
          digitalSignature: json['digitalSignature'] as String?,
        );

Map<String, dynamic> _$$CorporateClientSignUpRequestVoImplToJson(
        _$CorporateClientSignUpRequestVoImpl instance) =>
    <String, dynamic>{
      'corporateDetails': instance.corporateDetails,
      'annualIncomeDeclaration': instance.annualIncomeDeclaration,
      'sourceOfIncome': instance.sourceOfIncome,
      'digitalSignature': instance.digitalSignature,
    };
