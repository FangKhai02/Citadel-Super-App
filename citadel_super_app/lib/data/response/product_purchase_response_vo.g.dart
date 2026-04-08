// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_purchase_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductPurchaseResponseVoImpl _$$ProductPurchaseResponseVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductPurchaseResponseVoImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      productOrderStatus: json['productOrderStatus'] as String?,
      productId: (json['productId'] as num?)?.toInt(),
      productOrderReferenceNumber:
          json['productOrderReferenceNumber'] as String?,
      productName: json['productName'] as String?,
      purchasedAmount: (json['purchasedAmount'] as num?)?.toInt(),
      dividend: (json['dividend'] as num?)?.toDouble(),
      investmentTenureMonth: (json['investmentTenureMonth'] as num?)?.toInt(),
      bankDetails: json['bankDetails'] == null
          ? null
          : BankDetailsVo.fromJson(json['bankDetails'] as Map<String, dynamic>),
      productBeneficiaries: (json['productBeneficiaries'] as List<dynamic>?)
          ?.map((e) =>
              FundBeneficiaryDetailsVo.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentMethod: json['paymentMethod'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
    );

Map<String, dynamic> _$$ProductPurchaseResponseVoImplToJson(
        _$ProductPurchaseResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'productOrderStatus': instance.productOrderStatus,
      'productId': instance.productId,
      'productOrderReferenceNumber': instance.productOrderReferenceNumber,
      'productName': instance.productName,
      'purchasedAmount': instance.purchasedAmount,
      'dividend': instance.dividend,
      'investmentTenureMonth': instance.investmentTenureMonth,
      'bankDetails': instance.bankDetails,
      'productBeneficiaries': instance.productBeneficiaries,
      'paymentMethod': instance.paymentMethod,
      'paymentStatus': instance.paymentStatus,
    };
