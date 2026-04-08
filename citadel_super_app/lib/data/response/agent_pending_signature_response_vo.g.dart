// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent_pending_signature_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentPendingSignatureResponseVoImpl
    _$$AgentPendingSignatureResponseVoImplFromJson(Map<String, dynamic> json) =>
        _$AgentPendingSignatureResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          productOrders: (json['productOrders'] as List<dynamic>?)
              ?.map(
                  (e) => ClientPortfolioVo.fromJson(e as Map<String, dynamic>))
              .toList(),
          earlyRedemptions: (json['earlyRedemptions'] as List<dynamic>?)
              ?.map(
                  (e) => ClientPortfolioVo.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$AgentPendingSignatureResponseVoImplToJson(
        _$AgentPendingSignatureResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'productOrders': instance.productOrders,
      'earlyRedemptions': instance.earlyRedemptions,
    };
