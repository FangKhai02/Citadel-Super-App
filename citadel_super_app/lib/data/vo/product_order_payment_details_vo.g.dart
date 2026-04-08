// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_order_payment_details_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductOrderPaymentDetailsVoImpl _$$ProductOrderPaymentDetailsVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductOrderPaymentDetailsVoImpl(
      paymentMethod: json['paymentMethod'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      transactionId: json['transactionId'] as String?,
      bankName: json['bankName'] as String?,
      paymentReceipts: (json['paymentReceipts'] as List<dynamic>?)
          ?.map((e) =>
              ProductOrderPaymentReceiptVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProductOrderPaymentDetailsVoImplToJson(
        _$ProductOrderPaymentDetailsVoImpl instance) =>
    <String, dynamic>{
      'paymentMethod': instance.paymentMethod,
      'paymentStatus': instance.paymentStatus,
      'transactionId': instance.transactionId,
      'bankName': instance.bankName,
      'paymentReceipts': instance.paymentReceipts,
    };
