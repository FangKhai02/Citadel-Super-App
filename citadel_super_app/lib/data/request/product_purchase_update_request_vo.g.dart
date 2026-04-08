// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_purchase_update_request_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductPurchaseUpdateRequestVoImpl
    _$$ProductPurchaseUpdateRequestVoImplFromJson(Map<String, dynamic> json) =>
        _$ProductPurchaseUpdateRequestVoImpl(
          clientBankId: (json['clientBankId'] as num?)?.toInt(),
          paymentMethod: json['paymentMethod'] as String?,
          beneficiaries: (json['beneficiaries'] as List<dynamic>?)
              ?.map((e) => ProductOrderBeneficiaryRequestVo.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$ProductPurchaseUpdateRequestVoImplToJson(
        _$ProductPurchaseUpdateRequestVoImpl instance) =>
    <String, dynamic>{
      'clientBankId': instance.clientBankId,
      'paymentMethod': instance.paymentMethod,
      'beneficiaries': instance.beneficiaries,
    };
