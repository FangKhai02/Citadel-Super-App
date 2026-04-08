// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_purchase_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductPurchaseRequestVo _$ProductPurchaseRequestVoFromJson(
    Map<String, dynamic> json) {
  return _ProductPurchaseRequestVo.fromJson(json);
}

/// @nodoc
mixin _$ProductPurchaseRequestVo {
  ProductPurchaseProductDetailsVo? get productDetails =>
      throw _privateConstructorUsedError;
  set productDetails(ProductPurchaseProductDetailsVo? value) =>
      throw _privateConstructorUsedError;
  bool? get livingTrustOptionEnabled => throw _privateConstructorUsedError;
  set livingTrustOptionEnabled(bool? value) =>
      throw _privateConstructorUsedError;
  int? get clientBankId => throw _privateConstructorUsedError;
  set clientBankId(int? value) => throw _privateConstructorUsedError;
  List<ProductOrderBeneficiaryRequestVo>? get beneficiaries =>
      throw _privateConstructorUsedError;
  set beneficiaries(List<ProductOrderBeneficiaryRequestVo>? value) =>
      throw _privateConstructorUsedError;
  String? get paymentMethod => throw _privateConstructorUsedError;
  set paymentMethod(String? value) => throw _privateConstructorUsedError;
  String? get clientId => throw _privateConstructorUsedError;
  set clientId(String? value) => throw _privateConstructorUsedError;
  String? get corporateClientId => throw _privateConstructorUsedError;
  set corporateClientId(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductPurchaseRequestVoCopyWith<ProductPurchaseRequestVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductPurchaseRequestVoCopyWith<$Res> {
  factory $ProductPurchaseRequestVoCopyWith(ProductPurchaseRequestVo value,
          $Res Function(ProductPurchaseRequestVo) then) =
      _$ProductPurchaseRequestVoCopyWithImpl<$Res, ProductPurchaseRequestVo>;
  @useResult
  $Res call(
      {ProductPurchaseProductDetailsVo? productDetails,
      bool? livingTrustOptionEnabled,
      int? clientBankId,
      List<ProductOrderBeneficiaryRequestVo>? beneficiaries,
      String? paymentMethod,
      String? clientId,
      String? corporateClientId});

  $ProductPurchaseProductDetailsVoCopyWith<$Res>? get productDetails;
}

/// @nodoc
class _$ProductPurchaseRequestVoCopyWithImpl<$Res,
        $Val extends ProductPurchaseRequestVo>
    implements $ProductPurchaseRequestVoCopyWith<$Res> {
  _$ProductPurchaseRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productDetails = freezed,
    Object? livingTrustOptionEnabled = freezed,
    Object? clientBankId = freezed,
    Object? beneficiaries = freezed,
    Object? paymentMethod = freezed,
    Object? clientId = freezed,
    Object? corporateClientId = freezed,
  }) {
    return _then(_value.copyWith(
      productDetails: freezed == productDetails
          ? _value.productDetails
          : productDetails // ignore: cast_nullable_to_non_nullable
              as ProductPurchaseProductDetailsVo?,
      livingTrustOptionEnabled: freezed == livingTrustOptionEnabled
          ? _value.livingTrustOptionEnabled
          : livingTrustOptionEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      clientBankId: freezed == clientBankId
          ? _value.clientBankId
          : clientBankId // ignore: cast_nullable_to_non_nullable
              as int?,
      beneficiaries: freezed == beneficiaries
          ? _value.beneficiaries
          : beneficiaries // ignore: cast_nullable_to_non_nullable
              as List<ProductOrderBeneficiaryRequestVo>?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateClientId: freezed == corporateClientId
          ? _value.corporateClientId
          : corporateClientId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductPurchaseProductDetailsVoCopyWith<$Res>? get productDetails {
    if (_value.productDetails == null) {
      return null;
    }

    return $ProductPurchaseProductDetailsVoCopyWith<$Res>(
        _value.productDetails!, (value) {
      return _then(_value.copyWith(productDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductPurchaseRequestVoImplCopyWith<$Res>
    implements $ProductPurchaseRequestVoCopyWith<$Res> {
  factory _$$ProductPurchaseRequestVoImplCopyWith(
          _$ProductPurchaseRequestVoImpl value,
          $Res Function(_$ProductPurchaseRequestVoImpl) then) =
      __$$ProductPurchaseRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProductPurchaseProductDetailsVo? productDetails,
      bool? livingTrustOptionEnabled,
      int? clientBankId,
      List<ProductOrderBeneficiaryRequestVo>? beneficiaries,
      String? paymentMethod,
      String? clientId,
      String? corporateClientId});

  @override
  $ProductPurchaseProductDetailsVoCopyWith<$Res>? get productDetails;
}

/// @nodoc
class __$$ProductPurchaseRequestVoImplCopyWithImpl<$Res>
    extends _$ProductPurchaseRequestVoCopyWithImpl<$Res,
        _$ProductPurchaseRequestVoImpl>
    implements _$$ProductPurchaseRequestVoImplCopyWith<$Res> {
  __$$ProductPurchaseRequestVoImplCopyWithImpl(
      _$ProductPurchaseRequestVoImpl _value,
      $Res Function(_$ProductPurchaseRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productDetails = freezed,
    Object? livingTrustOptionEnabled = freezed,
    Object? clientBankId = freezed,
    Object? beneficiaries = freezed,
    Object? paymentMethod = freezed,
    Object? clientId = freezed,
    Object? corporateClientId = freezed,
  }) {
    return _then(_$ProductPurchaseRequestVoImpl(
      productDetails: freezed == productDetails
          ? _value.productDetails
          : productDetails // ignore: cast_nullable_to_non_nullable
              as ProductPurchaseProductDetailsVo?,
      livingTrustOptionEnabled: freezed == livingTrustOptionEnabled
          ? _value.livingTrustOptionEnabled
          : livingTrustOptionEnabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      clientBankId: freezed == clientBankId
          ? _value.clientBankId
          : clientBankId // ignore: cast_nullable_to_non_nullable
              as int?,
      beneficiaries: freezed == beneficiaries
          ? _value.beneficiaries
          : beneficiaries // ignore: cast_nullable_to_non_nullable
              as List<ProductOrderBeneficiaryRequestVo>?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateClientId: freezed == corporateClientId
          ? _value.corporateClientId
          : corporateClientId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductPurchaseRequestVoImpl extends _ProductPurchaseRequestVo {
  _$ProductPurchaseRequestVoImpl(
      {this.productDetails,
      this.livingTrustOptionEnabled,
      this.clientBankId,
      this.beneficiaries,
      this.paymentMethod,
      this.clientId,
      this.corporateClientId})
      : super._();

  factory _$ProductPurchaseRequestVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductPurchaseRequestVoImplFromJson(json);

  @override
  ProductPurchaseProductDetailsVo? productDetails;
  @override
  bool? livingTrustOptionEnabled;
  @override
  int? clientBankId;
  @override
  List<ProductOrderBeneficiaryRequestVo>? beneficiaries;
  @override
  String? paymentMethod;
  @override
  String? clientId;
  @override
  String? corporateClientId;

  @override
  String toString() {
    return 'ProductPurchaseRequestVo(productDetails: $productDetails, livingTrustOptionEnabled: $livingTrustOptionEnabled, clientBankId: $clientBankId, beneficiaries: $beneficiaries, paymentMethod: $paymentMethod, clientId: $clientId, corporateClientId: $corporateClientId)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductPurchaseRequestVoImplCopyWith<_$ProductPurchaseRequestVoImpl>
      get copyWith => __$$ProductPurchaseRequestVoImplCopyWithImpl<
          _$ProductPurchaseRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductPurchaseRequestVoImplToJson(
      this,
    );
  }
}

abstract class _ProductPurchaseRequestVo extends ProductPurchaseRequestVo {
  factory _ProductPurchaseRequestVo(
      {ProductPurchaseProductDetailsVo? productDetails,
      bool? livingTrustOptionEnabled,
      int? clientBankId,
      List<ProductOrderBeneficiaryRequestVo>? beneficiaries,
      String? paymentMethod,
      String? clientId,
      String? corporateClientId}) = _$ProductPurchaseRequestVoImpl;
  _ProductPurchaseRequestVo._() : super._();

  factory _ProductPurchaseRequestVo.fromJson(Map<String, dynamic> json) =
      _$ProductPurchaseRequestVoImpl.fromJson;

  @override
  ProductPurchaseProductDetailsVo? get productDetails;
  set productDetails(ProductPurchaseProductDetailsVo? value);
  @override
  bool? get livingTrustOptionEnabled;
  set livingTrustOptionEnabled(bool? value);
  @override
  int? get clientBankId;
  set clientBankId(int? value);
  @override
  List<ProductOrderBeneficiaryRequestVo>? get beneficiaries;
  set beneficiaries(List<ProductOrderBeneficiaryRequestVo>? value);
  @override
  String? get paymentMethod;
  set paymentMethod(String? value);
  @override
  String? get clientId;
  set clientId(String? value);
  @override
  String? get corporateClientId;
  set corporateClientId(String? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductPurchaseRequestVoImplCopyWith<_$ProductPurchaseRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
