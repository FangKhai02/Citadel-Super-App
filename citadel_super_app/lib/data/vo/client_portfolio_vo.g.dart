// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_portfolio_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientPortfolioVoImpl _$$ClientPortfolioVoImplFromJson(
        Map<String, dynamic> json) =>
    _$ClientPortfolioVoImpl(
      clientId: json['clientId'] as String?,
      clientName: json['clientName'] as String?,
      orderReferenceNumber: json['orderReferenceNumber'] as String?,
      productName: json['productName'] as String?,
      productCode: json['productCode'] as String?,
      productType: json['productType'] as String?,
      purchasedAmount: (json['purchasedAmount'] as num?)?.toDouble(),
      status: json['status'] as String?,
      remark: json['remark'] as String?,
      productPurchaseDate: (json['productPurchaseDate'] as num?)?.toInt(),
      clientAgreementStatus: json['clientAgreementStatus'] as String?,
      witnessAgreementStatus: json['witnessAgreementStatus'] as String?,
      productId: (json['productId'] as num?)?.toInt(),
      productDividendAmount:
          (json['productDividendAmount'] as num?)?.toDouble(),
      productTenureMonth: (json['productTenureMonth'] as num?)?.toInt(),
      clientSignatureDate: (json['clientSignatureDate'] as num?)?.toInt(),
      agreementDate: (json['agreementDate'] as num?)?.toInt(),
      optionsVo: json['optionsVo'] == null
          ? null
          : PortfolioProductOrderOptionsVo.fromJson(
              json['optionsVo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ClientPortfolioVoImplToJson(
        _$ClientPortfolioVoImpl instance) =>
    <String, dynamic>{
      'clientId': instance.clientId,
      'clientName': instance.clientName,
      'orderReferenceNumber': instance.orderReferenceNumber,
      'productName': instance.productName,
      'productCode': instance.productCode,
      'productType': instance.productType,
      'purchasedAmount': instance.purchasedAmount,
      'status': instance.status,
      'remark': instance.remark,
      'productPurchaseDate': instance.productPurchaseDate,
      'clientAgreementStatus': instance.clientAgreementStatus,
      'witnessAgreementStatus': instance.witnessAgreementStatus,
      'productId': instance.productId,
      'productDividendAmount': instance.productDividendAmount,
      'productTenureMonth': instance.productTenureMonth,
      'clientSignatureDate': instance.clientSignatureDate,
      'agreementDate': instance.agreementDate,
      'optionsVo': instance.optionsVo,
    };
