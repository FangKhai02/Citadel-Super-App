// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_order_payment_details_base_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductOrderPaymentDetailsBaseVoImpl
    _$$ProductOrderPaymentDetailsBaseVoImplFromJson(
            Map<String, dynamic> json) =>
        _$ProductOrderPaymentDetailsBaseVoImpl(
          paymentMethod: json['paymentMethod'] as String?,
          paymentStatus: json['paymentStatus'] as String?,
        );

Map<String, dynamic> _$$ProductOrderPaymentDetailsBaseVoImplToJson(
        _$ProductOrderPaymentDetailsBaseVoImpl instance) =>
    <String, dynamic>{
      'paymentMethod': instance.paymentMethod,
      'paymentStatus': instance.paymentStatus,
    };
