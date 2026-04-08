// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_client_details_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentClientDetailsResponseVoImpl _$$AgentClientDetailsResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$AgentClientDetailsResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      clientPortfolio: (json['clientPortfolio'] as List<dynamic>?)
          ?.map((e) => ClientPortfolioVo.fromJson(e as Map<String, dynamic>))
          .toList(),
      dividendPayouts: (json['dividendPayouts'] as List<dynamic>?)
          ?.map(
              (e) => AgentDividendPayoutVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AgentClientDetailsResponseVoImplToJson(
        _$AgentClientDetailsResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'clientPortfolio': instance.clientPortfolio,
      'dividendPayouts': instance.dividendPayouts,
    };
