// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_order_payment_upload_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductOrderPaymentUploadRequestVoImpl
    _$$ProductOrderPaymentUploadRequestVoImplFromJson(
            Map<String, dynamic> json) =>
        _$ProductOrderPaymentUploadRequestVoImpl(
          receipts: (json['receipts'] as List<dynamic>?)
              ?.map((e) => ProductOrderPaymentReceiptVo.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$ProductOrderPaymentUploadRequestVoImplToJson(
        _$ProductOrderPaymentUploadRequestVoImpl instance) =>
    <String, dynamic>{
      'receipts': instance.receipts,
    };
