// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incremental_amount_list_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IncrementalAmountListResponseVoImpl
    _$$IncrementalAmountListResponseVoImplFromJson(Map<String, dynamic> json) =>
        _$IncrementalAmountListResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          amountList: (json['amountList'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList(),
        );

Map<String, dynamic> _$$IncrementalAmountListResponseVoImplToJson(
        _$IncrementalAmountListResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'amountList': instance.amountList,
    };
