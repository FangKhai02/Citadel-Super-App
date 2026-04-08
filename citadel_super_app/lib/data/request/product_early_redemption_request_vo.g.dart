// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_early_redemption_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductEarlyRedemptionRequestVoImpl
    _$$ProductEarlyRedemptionRequestVoImplFromJson(Map<String, dynamic> json) =>
        _$ProductEarlyRedemptionRequestVoImpl(
          orderReferenceNumber: json['orderReferenceNumber'] as String?,
          withdrawalAmount: (json['withdrawalAmount'] as num?)?.toDouble(),
          withdrawalMethod: json['withdrawalMethod'] as String?,
          withdrawalReason: json['withdrawalReason'] as String?,
          supportingDocumentKey: json['supportingDocumentKey'] as String?,
        );

Map<String, dynamic> _$$ProductEarlyRedemptionRequestVoImplToJson(
        _$ProductEarlyRedemptionRequestVoImpl instance) =>
    <String, dynamic>{
      'orderReferenceNumber': instance.orderReferenceNumber,
      'withdrawalAmount': instance.withdrawalAmount,
      'withdrawalMethod': instance.withdrawalMethod,
      'withdrawalReason': instance.withdrawalReason,
      'supportingDocumentKey': instance.supportingDocumentKey,
    };
