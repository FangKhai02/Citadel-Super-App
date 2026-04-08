// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'corporate_bank_details_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CorporateBankDetailsResponseVoImpl
    _$$CorporateBankDetailsResponseVoImplFromJson(Map<String, dynamic> json) =>
        _$CorporateBankDetailsResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          corporateBankDetailsVo: json['corporateBankDetailsVo'] == null
              ? null
              : BankDetailsVo.fromJson(
                  json['corporateBankDetailsVo'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$CorporateBankDetailsResponseVoImplToJson(
        _$CorporateBankDetailsResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'corporateBankDetailsVo': instance.corporateBankDetailsVo,
    };
