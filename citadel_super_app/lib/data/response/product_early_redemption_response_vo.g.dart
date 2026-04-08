// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_early_redemption_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductEarlyRedemptionResponseVoImpl
    _$$ProductEarlyRedemptionResponseVoImplFromJson(
            Map<String, dynamic> json) =>
        _$ProductEarlyRedemptionResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          penaltyPercentage: (json['penaltyPercentage'] as num?)?.toDouble(),
          penaltyAmount: (json['penaltyAmount'] as num?)?.toDouble(),
          redemptionAmount: (json['redemptionAmount'] as num?)?.toDouble(),
          redemptionReferenceNumber:
              json['redemptionReferenceNumber'] as String?,
        );

Map<String, dynamic> _$$ProductEarlyRedemptionResponseVoImplToJson(
        _$ProductEarlyRedemptionResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'penaltyPercentage': instance.penaltyPercentage,
      'penaltyAmount': instance.penaltyAmount,
      'redemptionAmount': instance.redemptionAmount,
      'redemptionReferenceNumber': instance.redemptionReferenceNumber,
    };
