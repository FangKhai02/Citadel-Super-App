// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reallocate_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReallocateRequestVoImpl _$$ReallocateRequestVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ReallocateRequestVoImpl(
      productCode: json['productCode'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ReallocateRequestVoImplToJson(
        _$ReallocateRequestVoImpl instance) =>
    <String, dynamic>{
      'productCode': instance.productCode,
      'amount': instance.amount,
    };
