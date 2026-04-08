// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_order_payment_upload_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductOrderPaymentUploadResponseVoImpl
    _$$ProductOrderPaymentUploadResponseVoImplFromJson(
            Map<String, dynamic> json) =>
        _$ProductOrderPaymentUploadResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          paymentReceipts: (json['paymentReceipts'] as List<dynamic>?)
              ?.map((e) => ProductOrderPaymentReceiptVo.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$ProductOrderPaymentUploadResponseVoImplToJson(
        _$ProductOrderPaymentUploadResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'paymentReceipts': instance.paymentReceipts,
    };
