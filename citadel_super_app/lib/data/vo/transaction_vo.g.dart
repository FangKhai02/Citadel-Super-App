// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionVoImpl _$$TransactionVoImplFromJson(Map<String, dynamic> json) =>
    _$TransactionVoImpl(
      transactionType: json['transactionType'] as String?,
      transactionTitle: json['transactionTitle'] as String?,
      productName: json['productName'] as String?,
      agreementNumber: json['agreementNumber'] as String?,
      transactionDate: (json['transactionDate'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toDouble(),
      bankName: json['bankName'] as String?,
      transactionId: json['transactionId'] as String?,
      status: json['status'] as String?,
      trusteeFee: (json['trusteeFee'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$TransactionVoImplToJson(_$TransactionVoImpl instance) =>
    <String, dynamic>{
      'transactionType': instance.transactionType,
      'transactionTitle': instance.transactionTitle,
      'productName': instance.productName,
      'agreementNumber': instance.agreementNumber,
      'transactionDate': instance.transactionDate,
      'amount': instance.amount,
      'bankName': instance.bankName,
      'transactionId': instance.transactionId,
      'status': instance.status,
      'trusteeFee': instance.trusteeFee,
    };
