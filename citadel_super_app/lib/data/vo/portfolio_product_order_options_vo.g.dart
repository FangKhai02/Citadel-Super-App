// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_product_order_options_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PortfolioProductOrderOptionsVoImpl
    _$$PortfolioProductOrderOptionsVoImplFromJson(Map<String, dynamic> json) =>
        _$PortfolioProductOrderOptionsVoImpl(
          newProductOrderReferenceNumber:
              json['newProductOrderReferenceNumber'] as String?,
          optionType: json['optionType'] as String?,
          optionStatus: json['optionStatus'] as String?,
          amount: (json['amount'] as num?)?.toDouble(),
          statusString: json['statusString'] as String?,
          createdAt: (json['createdAt'] as num?)?.toInt(),
          clientSignatureStatus: json['clientSignatureStatus'] as String?,
          witnessSignatureStatus: json['witnessSignatureStatus'] as String?,
        );

Map<String, dynamic> _$$PortfolioProductOrderOptionsVoImplToJson(
        _$PortfolioProductOrderOptionsVoImpl instance) =>
    <String, dynamic>{
      'newProductOrderReferenceNumber': instance.newProductOrderReferenceNumber,
      'optionType': instance.optionType,
      'optionStatus': instance.optionStatus,
      'amount': instance.amount,
      'statusString': instance.statusString,
      'createdAt': instance.createdAt,
      'clientSignatureStatus': instance.clientSignatureStatus,
      'witnessSignatureStatus': instance.witnessSignatureStatus,
    };
