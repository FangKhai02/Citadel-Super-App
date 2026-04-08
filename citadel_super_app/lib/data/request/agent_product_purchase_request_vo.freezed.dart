// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_product_purchase_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentProductPurchaseRequestVo _$AgentProductPurchaseRequestVoFromJson(
    Map<String, dynamic> json) {
  return _AgentProductPurchaseRequestVo.fromJson(json);
}

/// @nodoc
mixin _$AgentProductPurchaseRequestVo {
  ProductPurchaseProductDetailsVo? get productDetails =>
      throw _privateConstructorUsedError;
  set productDetails(ProductPurchaseProductDetailsVo? value) =>
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

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentProductPurchaseRequestVoCopyWith<AgentProductPurchaseRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentProductPurchaseRequestVoCopyWith<$Res> {
  factory $AgentProductPurchaseRequestVoCopyWith(
          AgentProductPurchaseRequestVo value,
          $Res Function(AgentProductPurchaseRequestVo) then) =
      _$AgentProductPurchaseRequestVoCopyWithImpl<$Res,
          AgentProductPurchaseRequestVo>;
  @useResult
  $Res call(
      {ProductPurchaseProductDetailsVo? productDetails,
      int? clientBankId,
      List<ProductOrderBeneficiaryRequestVo>? beneficiaries,
      String? paymentMethod,
      String? clientId});

  $ProductPurchaseProductDetailsVoCopyWith<$Res>? get productDetails;
}

/// @nodoc
class _$AgentProductPurchaseRequestVoCopyWithImpl<$Res,
        $Val extends AgentProductPurchaseRequestVo>
    implements $AgentProductPurchaseRequestVoCopyWith<$Res> {
  _$AgentProductPurchaseRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productDetails = freezed,
    Object? clientBankId = freezed,
    Object? beneficiaries = freezed,
    Object? paymentMethod = freezed,
    Object? clientId = freezed,
  }) {
    return _then(_value.copyWith(
      productDetails: freezed == productDetails
          ? _value.productDetails
          : productDetails // ignore: cast_nullable_to_non_nullable
              as ProductPurchaseProductDetailsVo?,
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
abstract class _$$AgentProductPurchaseRequestVoImplCopyWith<$Res>
    implements $AgentProductPurchaseRequestVoCopyWith<$Res> {
  factory _$$AgentProductPurchaseRequestVoImplCopyWith(
          _$AgentProductPurchaseRequestVoImpl value,
          $Res Function(_$AgentProductPurchaseRequestVoImpl) then) =
      __$$AgentProductPurchaseRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProductPurchaseProductDetailsVo? productDetails,
      int? clientBankId,
      List<ProductOrderBeneficiaryRequestVo>? beneficiaries,
      String? paymentMethod,
      String? clientId});

  @override
  $ProductPurchaseProductDetailsVoCopyWith<$Res>? get productDetails;
}

/// @nodoc
class __$$AgentProductPurchaseRequestVoImplCopyWithImpl<$Res>
    extends _$AgentProductPurchaseRequestVoCopyWithImpl<$Res,
        _$AgentProductPurchaseRequestVoImpl>
    implements _$$AgentProductPurchaseRequestVoImplCopyWith<$Res> {
  __$$AgentProductPurchaseRequestVoImplCopyWithImpl(
      _$AgentProductPurchaseRequestVoImpl _value,
      $Res Function(_$AgentProductPurchaseRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productDetails = freezed,
    Object? clientBankId = freezed,
    Object? beneficiaries = freezed,
    Object? paymentMethod = freezed,
    Object? clientId = freezed,
  }) {
    return _then(_$AgentProductPurchaseRequestVoImpl(
      productDetails: freezed == productDetails
          ? _value.productDetails
          : productDetails // ignore: cast_nullable_to_non_nullable
              as ProductPurchaseProductDetailsVo?,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentProductPurchaseRequestVoImpl
    extends _AgentProductPurchaseRequestVo {
  _$AgentProductPurchaseRequestVoImpl(
      {this.productDetails,
      this.clientBankId,
      this.beneficiaries,
      this.paymentMethod,
      this.clientId})
      : super._();

  factory _$AgentProductPurchaseRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AgentProductPurchaseRequestVoImplFromJson(json);

  @override
  ProductPurchaseProductDetailsVo? productDetails;
  @override
  int? clientBankId;
  @override
  List<ProductOrderBeneficiaryRequestVo>? beneficiaries;
  @override
  String? paymentMethod;
  @override
  String? clientId;

  @override
  String toString() {
    return 'AgentProductPurchaseRequestVo(productDetails: $productDetails, clientBankId: $clientBankId, beneficiaries: $beneficiaries, paymentMethod: $paymentMethod, clientId: $clientId)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentProductPurchaseRequestVoImplCopyWith<
          _$AgentProductPurchaseRequestVoImpl>
      get copyWith => __$$AgentProductPurchaseRequestVoImplCopyWithImpl<
          _$AgentProductPurchaseRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentProductPurchaseRequestVoImplToJson(
      this,
    );
  }
}

abstract class _AgentProductPurchaseRequestVo
    extends AgentProductPurchaseRequestVo {
  factory _AgentProductPurchaseRequestVo(
      {ProductPurchaseProductDetailsVo? productDetails,
      int? clientBankId,
      List<ProductOrderBeneficiaryRequestVo>? beneficiaries,
      String? paymentMethod,
      String? clientId}) = _$AgentProductPurchaseRequestVoImpl;
  _AgentProductPurchaseRequestVo._() : super._();

  factory _AgentProductPurchaseRequestVo.fromJson(Map<String, dynamic> json) =
      _$AgentProductPurchaseRequestVoImpl.fromJson;

  @override
  ProductPurchaseProductDetailsVo? get productDetails;
  set productDetails(ProductPurchaseProductDetailsVo? value);
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
  @JsonKey(ignore: true)
  _$$AgentProductPurchaseRequestVoImplCopyWith<
          _$AgentProductPurchaseRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
