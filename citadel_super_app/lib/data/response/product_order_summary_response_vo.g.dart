// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_order_summary_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductOrderSummaryResponseVoImpl
    _$$ProductOrderSummaryResponseVoImplFromJson(Map<String, dynamic> json) =>
        _$ProductOrderSummaryResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          productOrderStatus: json['productOrderStatus'] as String?,
          productId: (json['productId'] as num?)?.toInt(),
          productOrderReferenceNumber:
              json['productOrderReferenceNumber'] as String?,
          productName: json['productName'] as String?,
          purchasedAmount: (json['purchasedAmount'] as num?)?.toDouble(),
          dividend: (json['dividend'] as num?)?.toDouble(),
          investmentTenureMonth:
              (json['investmentTenureMonth'] as num?)?.toInt(),
          bankDetails: json['bankDetails'] == null
              ? null
              : BankDetailsVo.fromJson(
                  json['bankDetails'] as Map<String, dynamic>),
          productBeneficiaries: (json['productBeneficiaries'] as List<dynamic>?)
              ?.map((e) =>
                  FundBeneficiaryDetailsVo.fromJson(e as Map<String, dynamic>))
              .toList(),
          paymentDetails: json['paymentDetails'] == null
              ? null
              : ProductOrderPaymentDetailsBaseVo.fromJson(
                  json['paymentDetails'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$ProductOrderSummaryResponseVoImplToJson(
        _$ProductOrderSummaryResponseVoImpl instance) =>
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
      'paymentDetails': instance.paymentDetails,
    };
