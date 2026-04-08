// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_personal_sales_details_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentPersonalSalesDetailsResponseVoImpl
    _$$AgentPersonalSalesDetailsResponseVoImplFromJson(
            Map<String, dynamic> json) =>
        _$AgentPersonalSalesDetailsResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          salesDetails: (json['salesDetails'] as List<dynamic>?)
              ?.map((e) => AgentPersonalSalesDetailsVo.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$AgentPersonalSalesDetailsResponseVoImplToJson(
        _$AgentPersonalSalesDetailsResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'salesDetails': instance.salesDetails,
    };
