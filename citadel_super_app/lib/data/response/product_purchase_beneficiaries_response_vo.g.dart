// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_purchase_beneficiaries_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductPurchaseBeneficiariesResponseVoImpl
    _$$ProductPurchaseBeneficiariesResponseVoImplFromJson(
            Map<String, dynamic> json) =>
        _$ProductPurchaseBeneficiariesResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          productBeneficiaries: (json['productBeneficiaries'] as List<dynamic>?)
              ?.map((e) =>
                  FundBeneficiaryDetailsVo.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$ProductPurchaseBeneficiariesResponseVoImplToJson(
        _$ProductPurchaseBeneficiariesResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'productBeneficiaries': instance.productBeneficiaries,
    };
