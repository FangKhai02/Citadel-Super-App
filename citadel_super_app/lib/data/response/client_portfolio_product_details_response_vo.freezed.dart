// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_portfolio_product_details_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClientPortfolioProductDetailsResponseVo
    _$ClientPortfolioProductDetailsResponseVoFromJson(
        Map<String, dynamic> json) {
  return _ClientPortfolioProductDetailsResponseVo.fromJson(json);
}

/// @nodoc
mixin _$ClientPortfolioProductDetailsResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  ClientPortfolioVo? get clientPortfolio => throw _privateConstructorUsedError;
  set clientPortfolio(ClientPortfolioVo? value) =>
      throw _privateConstructorUsedError;
  BankDetailsVo? get bankDetails => throw _privateConstructorUsedError;
  set bankDetails(BankDetailsVo? value) => throw _privateConstructorUsedError;
  List<FundBeneficiaryDetailsVo>? get fundBeneficiaries =>
      throw _privateConstructorUsedError;
  set fundBeneficiaries(List<FundBeneficiaryDetailsVo>? value) =>
      throw _privateConstructorUsedError;
  ProductOrderPaymentDetailsVo? get paymentDetails =>
      throw _privateConstructorUsedError;
  set paymentDetails(ProductOrderPaymentDetailsVo? value) =>
      throw _privateConstructorUsedError;
  ProductOrderDocumentsVo? get documents => throw _privateConstructorUsedError;
  set documents(ProductOrderDocumentsVo? value) =>
      throw _privateConstructorUsedError;
  String? get agreementNumber => throw _privateConstructorUsedError;
  set agreementNumber(String? value) => throw _privateConstructorUsedError;
  bool? get rolloverAllowed => throw _privateConstructorUsedError;
  set rolloverAllowed(bool? value) => throw _privateConstructorUsedError;
  bool? get fullRedemptionAllowed => throw _privateConstructorUsedError;
  set fullRedemptionAllowed(bool? value) => throw _privateConstructorUsedError;
  bool? get reallocationAllowed => throw _privateConstructorUsedError;
  set reallocationAllowed(bool? value) => throw _privateConstructorUsedError;
  bool? get earlyRedemptionAllowed => throw _privateConstructorUsedError;
  set earlyRedemptionAllowed(bool? value) => throw _privateConstructorUsedError;
  bool? get displayShareAgreementButton => throw _privateConstructorUsedError;
  set displayShareAgreementButton(bool? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientPortfolioProductDetailsResponseVoCopyWith<
          ClientPortfolioProductDetailsResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientPortfolioProductDetailsResponseVoCopyWith<$Res> {
  factory $ClientPortfolioProductDetailsResponseVoCopyWith(
          ClientPortfolioProductDetailsResponseVo value,
          $Res Function(ClientPortfolioProductDetailsResponseVo) then) =
      _$ClientPortfolioProductDetailsResponseVoCopyWithImpl<$Res,
          ClientPortfolioProductDetailsResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      ClientPortfolioVo? clientPortfolio,
      BankDetailsVo? bankDetails,
      List<FundBeneficiaryDetailsVo>? fundBeneficiaries,
      ProductOrderPaymentDetailsVo? paymentDetails,
      ProductOrderDocumentsVo? documents,
      String? agreementNumber,
      bool? rolloverAllowed,
      bool? fullRedemptionAllowed,
      bool? reallocationAllowed,
      bool? earlyRedemptionAllowed,
      bool? displayShareAgreementButton});

  $ClientPortfolioVoCopyWith<$Res>? get clientPortfolio;
  $BankDetailsVoCopyWith<$Res>? get bankDetails;
  $ProductOrderPaymentDetailsVoCopyWith<$Res>? get paymentDetails;
  $ProductOrderDocumentsVoCopyWith<$Res>? get documents;
}

/// @nodoc
class _$ClientPortfolioProductDetailsResponseVoCopyWithImpl<$Res,
        $Val extends ClientPortfolioProductDetailsResponseVo>
    implements $ClientPortfolioProductDetailsResponseVoCopyWith<$Res> {
  _$ClientPortfolioProductDetailsResponseVoCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? clientPortfolio = freezed,
    Object? bankDetails = freezed,
    Object? fundBeneficiaries = freezed,
    Object? paymentDetails = freezed,
    Object? documents = freezed,
    Object? agreementNumber = freezed,
    Object? rolloverAllowed = freezed,
    Object? fullRedemptionAllowed = freezed,
    Object? reallocationAllowed = freezed,
    Object? earlyRedemptionAllowed = freezed,
    Object? displayShareAgreementButton = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      clientPortfolio: freezed == clientPortfolio
          ? _value.clientPortfolio
          : clientPortfolio // ignore: cast_nullable_to_non_nullable
              as ClientPortfolioVo?,
      bankDetails: freezed == bankDetails
          ? _value.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as BankDetailsVo?,
      fundBeneficiaries: freezed == fundBeneficiaries
          ? _value.fundBeneficiaries
          : fundBeneficiaries // ignore: cast_nullable_to_non_nullable
              as List<FundBeneficiaryDetailsVo>?,
      paymentDetails: freezed == paymentDetails
          ? _value.paymentDetails
          : paymentDetails // ignore: cast_nullable_to_non_nullable
              as ProductOrderPaymentDetailsVo?,
      documents: freezed == documents
          ? _value.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as ProductOrderDocumentsVo?,
      agreementNumber: freezed == agreementNumber
          ? _value.agreementNumber
          : agreementNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      rolloverAllowed: freezed == rolloverAllowed
          ? _value.rolloverAllowed
          : rolloverAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      fullRedemptionAllowed: freezed == fullRedemptionAllowed
          ? _value.fullRedemptionAllowed
          : fullRedemptionAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      reallocationAllowed: freezed == reallocationAllowed
          ? _value.reallocationAllowed
          : reallocationAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      earlyRedemptionAllowed: freezed == earlyRedemptionAllowed
          ? _value.earlyRedemptionAllowed
          : earlyRedemptionAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      displayShareAgreementButton: freezed == displayShareAgreementButton
          ? _value.displayShareAgreementButton
          : displayShareAgreementButton // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientPortfolioVoCopyWith<$Res>? get clientPortfolio {
    if (_value.clientPortfolio == null) {
      return null;
    }

    return $ClientPortfolioVoCopyWith<$Res>(_value.clientPortfolio!, (value) {
      return _then(_value.copyWith(clientPortfolio: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BankDetailsVoCopyWith<$Res>? get bankDetails {
    if (_value.bankDetails == null) {
      return null;
    }

    return $BankDetailsVoCopyWith<$Res>(_value.bankDetails!, (value) {
      return _then(_value.copyWith(bankDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductOrderPaymentDetailsVoCopyWith<$Res>? get paymentDetails {
    if (_value.paymentDetails == null) {
      return null;
    }

    return $ProductOrderPaymentDetailsVoCopyWith<$Res>(_value.paymentDetails!,
        (value) {
      return _then(_value.copyWith(paymentDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductOrderDocumentsVoCopyWith<$Res>? get documents {
    if (_value.documents == null) {
      return null;
    }

    return $ProductOrderDocumentsVoCopyWith<$Res>(_value.documents!, (value) {
      return _then(_value.copyWith(documents: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClientPortfolioProductDetailsResponseVoImplCopyWith<$Res>
    implements $ClientPortfolioProductDetailsResponseVoCopyWith<$Res> {
  factory _$$ClientPortfolioProductDetailsResponseVoImplCopyWith(
          _$ClientPortfolioProductDetailsResponseVoImpl value,
          $Res Function(_$ClientPortfolioProductDetailsResponseVoImpl) then) =
      __$$ClientPortfolioProductDetailsResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      ClientPortfolioVo? clientPortfolio,
      BankDetailsVo? bankDetails,
      List<FundBeneficiaryDetailsVo>? fundBeneficiaries,
      ProductOrderPaymentDetailsVo? paymentDetails,
      ProductOrderDocumentsVo? documents,
      String? agreementNumber,
      bool? rolloverAllowed,
      bool? fullRedemptionAllowed,
      bool? reallocationAllowed,
      bool? earlyRedemptionAllowed,
      bool? displayShareAgreementButton});

  @override
  $ClientPortfolioVoCopyWith<$Res>? get clientPortfolio;
  @override
  $BankDetailsVoCopyWith<$Res>? get bankDetails;
  @override
  $ProductOrderPaymentDetailsVoCopyWith<$Res>? get paymentDetails;
  @override
  $ProductOrderDocumentsVoCopyWith<$Res>? get documents;
}

/// @nodoc
class __$$ClientPortfolioProductDetailsResponseVoImplCopyWithImpl<$Res>
    extends _$ClientPortfolioProductDetailsResponseVoCopyWithImpl<$Res,
        _$ClientPortfolioProductDetailsResponseVoImpl>
    implements _$$ClientPortfolioProductDetailsResponseVoImplCopyWith<$Res> {
  __$$ClientPortfolioProductDetailsResponseVoImplCopyWithImpl(
      _$ClientPortfolioProductDetailsResponseVoImpl _value,
      $Res Function(_$ClientPortfolioProductDetailsResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? clientPortfolio = freezed,
    Object? bankDetails = freezed,
    Object? fundBeneficiaries = freezed,
    Object? paymentDetails = freezed,
    Object? documents = freezed,
    Object? agreementNumber = freezed,
    Object? rolloverAllowed = freezed,
    Object? fullRedemptionAllowed = freezed,
    Object? reallocationAllowed = freezed,
    Object? earlyRedemptionAllowed = freezed,
    Object? displayShareAgreementButton = freezed,
  }) {
    return _then(_$ClientPortfolioProductDetailsResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      clientPortfolio: freezed == clientPortfolio
          ? _value.clientPortfolio
          : clientPortfolio // ignore: cast_nullable_to_non_nullable
              as ClientPortfolioVo?,
      bankDetails: freezed == bankDetails
          ? _value.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as BankDetailsVo?,
      fundBeneficiaries: freezed == fundBeneficiaries
          ? _value.fundBeneficiaries
          : fundBeneficiaries // ignore: cast_nullable_to_non_nullable
              as List<FundBeneficiaryDetailsVo>?,
      paymentDetails: freezed == paymentDetails
          ? _value.paymentDetails
          : paymentDetails // ignore: cast_nullable_to_non_nullable
              as ProductOrderPaymentDetailsVo?,
      documents: freezed == documents
          ? _value.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as ProductOrderDocumentsVo?,
      agreementNumber: freezed == agreementNumber
          ? _value.agreementNumber
          : agreementNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      rolloverAllowed: freezed == rolloverAllowed
          ? _value.rolloverAllowed
          : rolloverAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      fullRedemptionAllowed: freezed == fullRedemptionAllowed
          ? _value.fullRedemptionAllowed
          : fullRedemptionAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      reallocationAllowed: freezed == reallocationAllowed
          ? _value.reallocationAllowed
          : reallocationAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      earlyRedemptionAllowed: freezed == earlyRedemptionAllowed
          ? _value.earlyRedemptionAllowed
          : earlyRedemptionAllowed // ignore: cast_nullable_to_non_nullable
              as bool?,
      displayShareAgreementButton: freezed == displayShareAgreementButton
          ? _value.displayShareAgreementButton
          : displayShareAgreementButton // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientPortfolioProductDetailsResponseVoImpl
    extends _ClientPortfolioProductDetailsResponseVo {
  _$ClientPortfolioProductDetailsResponseVoImpl(
      {this.code,
      this.message,
      this.clientPortfolio,
      this.bankDetails,
      this.fundBeneficiaries,
      this.paymentDetails,
      this.documents,
      this.agreementNumber,
      this.rolloverAllowed,
      this.fullRedemptionAllowed,
      this.reallocationAllowed,
      this.earlyRedemptionAllowed,
      this.displayShareAgreementButton})
      : super._();

  factory _$ClientPortfolioProductDetailsResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ClientPortfolioProductDetailsResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  ClientPortfolioVo? clientPortfolio;
  @override
  BankDetailsVo? bankDetails;
  @override
  List<FundBeneficiaryDetailsVo>? fundBeneficiaries;
  @override
  ProductOrderPaymentDetailsVo? paymentDetails;
  @override
  ProductOrderDocumentsVo? documents;
  @override
  String? agreementNumber;
  @override
  bool? rolloverAllowed;
  @override
  bool? fullRedemptionAllowed;
  @override
  bool? reallocationAllowed;
  @override
  bool? earlyRedemptionAllowed;
  @override
  bool? displayShareAgreementButton;

  @override
  String toString() {
    return 'ClientPortfolioProductDetailsResponseVo(code: $code, message: $message, clientPortfolio: $clientPortfolio, bankDetails: $bankDetails, fundBeneficiaries: $fundBeneficiaries, paymentDetails: $paymentDetails, documents: $documents, agreementNumber: $agreementNumber, rolloverAllowed: $rolloverAllowed, fullRedemptionAllowed: $fullRedemptionAllowed, reallocationAllowed: $reallocationAllowed, earlyRedemptionAllowed: $earlyRedemptionAllowed, displayShareAgreementButton: $displayShareAgreementButton)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientPortfolioProductDetailsResponseVoImplCopyWith<
          _$ClientPortfolioProductDetailsResponseVoImpl>
      get copyWith =>
          __$$ClientPortfolioProductDetailsResponseVoImplCopyWithImpl<
              _$ClientPortfolioProductDetailsResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientPortfolioProductDetailsResponseVoImplToJson(
      this,
    );
  }
}

abstract class _ClientPortfolioProductDetailsResponseVo
    extends ClientPortfolioProductDetailsResponseVo {
  factory _ClientPortfolioProductDetailsResponseVo(
          {String? code,
          String? message,
          ClientPortfolioVo? clientPortfolio,
          BankDetailsVo? bankDetails,
          List<FundBeneficiaryDetailsVo>? fundBeneficiaries,
          ProductOrderPaymentDetailsVo? paymentDetails,
          ProductOrderDocumentsVo? documents,
          String? agreementNumber,
          bool? rolloverAllowed,
          bool? fullRedemptionAllowed,
          bool? reallocationAllowed,
          bool? earlyRedemptionAllowed,
          bool? displayShareAgreementButton}) =
      _$ClientPortfolioProductDetailsResponseVoImpl;
  _ClientPortfolioProductDetailsResponseVo._() : super._();

  factory _ClientPortfolioProductDetailsResponseVo.fromJson(
          Map<String, dynamic> json) =
      _$ClientPortfolioProductDetailsResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  ClientPortfolioVo? get clientPortfolio;
  set clientPortfolio(ClientPortfolioVo? value);
  @override
  BankDetailsVo? get bankDetails;
  set bankDetails(BankDetailsVo? value);
  @override
  List<FundBeneficiaryDetailsVo>? get fundBeneficiaries;
  set fundBeneficiaries(List<FundBeneficiaryDetailsVo>? value);
  @override
  ProductOrderPaymentDetailsVo? get paymentDetails;
  set paymentDetails(ProductOrderPaymentDetailsVo? value);
  @override
  ProductOrderDocumentsVo? get documents;
  set documents(ProductOrderDocumentsVo? value);
  @override
  String? get agreementNumber;
  set agreementNumber(String? value);
  @override
  bool? get rolloverAllowed;
  set rolloverAllowed(bool? value);
  @override
  bool? get fullRedemptionAllowed;
  set fullRedemptionAllowed(bool? value);
  @override
  bool? get reallocationAllowed;
  set reallocationAllowed(bool? value);
  @override
  bool? get earlyRedemptionAllowed;
  set earlyRedemptionAllowed(bool? value);
  @override
  bool? get displayShareAgreementButton;
  set displayShareAgreementButton(bool? value);
  @override
  @JsonKey(ignore: true)
  _$$ClientPortfolioProductDetailsResponseVoImplCopyWith<
          _$ClientPortfolioProductDetailsResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
