// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_holdings_validation_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShareHoldingsValidationRequestVoImpl
    _$$ShareHoldingsValidationRequestVoImplFromJson(
            Map<String, dynamic> json) =>
        _$ShareHoldingsValidationRequestVoImpl(
          shareHolderIds: (json['shareHolderIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList(),
        );

Map<String, dynamic> _$$ShareHoldingsValidationRequestVoImplToJson(
        _$ShareHoldingsValidationRequestVoImpl instance) =>
    <String, dynamic>{
      'shareHolderIds': instance.shareHolderIds,
    };
