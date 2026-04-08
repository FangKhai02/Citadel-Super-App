// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_order_payment_receipt_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductOrderPaymentReceiptVoImpl _$$ProductOrderPaymentReceiptVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductOrderPaymentReceiptVoImpl(
      id: (json['id'] as num?)?.toInt(),
      fileName: json['fileName'] as String?,
      file: json['file'] as String?,
      uploadStatus: json['uploadStatus'] as String?,
    );

Map<String, dynamic> _$$ProductOrderPaymentReceiptVoImplToJson(
        _$ProductOrderPaymentReceiptVoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'file': instance.file,
      'uploadStatus': instance.uploadStatus,
    };
