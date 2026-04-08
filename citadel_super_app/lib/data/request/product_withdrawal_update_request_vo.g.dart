// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_withdrawal_update_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductWithdrawalUpdateRequestVoImpl
    _$$ProductWithdrawalUpdateRequestVoImplFromJson(
            Map<String, dynamic> json) =>
        _$ProductWithdrawalUpdateRequestVoImpl(
          orderReferenceNumber: json['orderReferenceNumber'] as String?,
          withdrawalAmount: (json['withdrawalAmount'] as num?)?.toDouble(),
          withdrawalMethod: json['withdrawalMethod'] as String?,
          withdrawalReason: json['withdrawalReason'] as String?,
          withdrawalAgreementKey: json['withdrawalAgreementKey'] as String?,
        );

Map<String, dynamic> _$$ProductWithdrawalUpdateRequestVoImplToJson(
        _$ProductWithdrawalUpdateRequestVoImpl instance) =>
    <String, dynamic>{
      'orderReferenceNumber': instance.orderReferenceNumber,
      'withdrawalAmount': instance.withdrawalAmount,
      'withdrawalMethod': instance.withdrawalMethod,
      'withdrawalReason': instance.withdrawalReason,
      'withdrawalAgreementKey': instance.withdrawalAgreementKey,
    };
