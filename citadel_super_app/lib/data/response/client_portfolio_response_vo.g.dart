// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_portfolio_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientPortfolioResponseVoImpl _$$ClientPortfolioResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientPortfolioResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      portfolio: (json['portfolio'] as List<dynamic>?)
          ?.map((e) => ClientPortfolioVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ClientPortfolioResponseVoImplToJson(
        _$ClientPortfolioResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'portfolio': instance.portfolio,
    };
