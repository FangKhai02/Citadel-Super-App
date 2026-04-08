// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_portfolio_product_details_response_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClientPortfolioProductDetailsResponseVoImpl
    _$$ClientPortfolioProductDetailsResponseVoImplFromJson(
            Map<String, dynamic> json) =>
        _$ClientPortfolioProductDetailsResponseVoImpl(
          code: json['code'] as String?,
          message: json['message'] as String?,
          clientPortfolio: json['clientPortfolio'] == null
              ? null
              : ClientPortfolioVo.fromJson(
                  json['clientPortfolio'] as Map<String, dynamic>),
          bankDetails: json['bankDetails'] == null
              ? null
              : BankDetailsVo.fromJson(
                  json['bankDetails'] as Map<String, dynamic>),
          fundBeneficiaries: (json['fundBeneficiaries'] as List<dynamic>?)
              ?.map((e) =>
                  FundBeneficiaryDetailsVo.fromJson(e as Map<String, dynamic>))
              .toList(),
          paymentDetails: json['paymentDetails'] == null
              ? null
              : ProductOrderPaymentDetailsVo.fromJson(
                  json['paymentDetails'] as Map<String, dynamic>),
          documents: json['documents'] == null
              ? null
              : ProductOrderDocumentsVo.fromJson(
                  json['documents'] as Map<String, dynamic>),
          agreementNumber: json['agreementNumber'] as String?,
          rolloverAllowed: json['rolloverAllowed'] as bool?,
          fullRedemptionAllowed: json['fullRedemptionAllowed'] as bool?,
          reallocationAllowed: json['reallocationAllowed'] as bool?,
          earlyRedemptionAllowed: json['earlyRedemptionAllowed'] as bool?,
          displayShareAgreementButton:
              json['displayShareAgreementButton'] as bool?,
        );

Map<String, dynamic> _$$ClientPortfolioProductDetailsResponseVoImplToJson(
        _$ClientPortfolioProductDetailsResponseVoImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'clientPortfolio': instance.clientPortfolio,
      'bankDetails': instance.bankDetails,
      'fundBeneficiaries': instance.fundBeneficiaries,
      'paymentDetails': instance.paymentDetails,
      'documents': instance.documents,
      'agreementNumber': instance.agreementNumber,
      'rolloverAllowed': instance.rolloverAllowed,
      'fullRedemptionAllowed': instance.fullRedemptionAllowed,
      'reallocationAllowed': instance.reallocationAllowed,
      'earlyRedemptionAllowed': instance.earlyRedemptionAllowed,
      'displayShareAgreementButton': instance.displayShareAgreementButton,
    };
