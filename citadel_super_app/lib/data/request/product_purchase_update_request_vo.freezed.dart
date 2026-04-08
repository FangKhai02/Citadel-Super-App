// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_purchase_update_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductPurchaseUpdateRequestVo _$ProductPurchaseUpdateRequestVoFromJson(
    Map<String, dynamic> json) {
  return _ProductPurchaseUpdateRequestVo.fromJson(json);
}

/// @nodoc
mixin _$ProductPurchaseUpdateRequestVo {
  int? get clientBankId => throw _privateConstructorUsedError;
  set clientBankId(int? value) => throw _privateConstructorUsedError;
  String? get paymentMethod => throw _privateConstructorUsedError;
  set paymentMethod(String? value) => throw _privateConstructorUsedError;
  List<ProductOrderBeneficiaryRequestVo>? get beneficiaries =>
      throw _privateConstructorUsedError;
  set beneficiaries(List<ProductOrderBeneficiaryRequestVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductPurchaseUpdateRequestVoCopyWith<ProductPurchaseUpdateRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductPurchaseUpdateRequestVoCopyWith<$Res> {
  factory $ProductPurchaseUpdateRequestVoCopyWith(
          ProductPurchaseUpdateRequestVo value,
          $Res Function(ProductPurchaseUpdateRequestVo) then) =
      _$ProductPurchaseUpdateRequestVoCopyWithImpl<$Res,
          ProductPurchaseUpdateRequestVo>;
  @useResult
  $Res call(
      {int? clientBankId,
      String? paymentMethod,
      List<ProductOrderBeneficiaryRequestVo>? beneficiaries});
}

/// @nodoc
class _$ProductPurchaseUpdateRequestVoCopyWithImpl<$Res,
        $Val extends ProductPurchaseUpdateRequestVo>
    implements $ProductPurchaseUpdateRequestVoCopyWith<$Res> {
  _$ProductPurchaseUpdateRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientBankId = freezed,
    Object? paymentMethod = freezed,
    Object? beneficiaries = freezed,
  }) {
    return _then(_value.copyWith(
      clientBankId: freezed == clientBankId
          ? _value.clientBankId
          : clientBankId // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      beneficiaries: freezed == beneficiaries
          ? _value.beneficiaries
          : beneficiaries // ignore: cast_nullable_to_non_nullable
              as List<ProductOrderBeneficiaryRequestVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductPurchaseUpdateRequestVoImplCopyWith<$Res>
    implements $ProductPurchaseUpdateRequestVoCopyWith<$Res> {
  factory _$$ProductPurchaseUpdateRequestVoImplCopyWith(
          _$ProductPurchaseUpdateRequestVoImpl value,
          $Res Function(_$ProductPurchaseUpdateRequestVoImpl) then) =
      __$$ProductPurchaseUpdateRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? clientBankId,
      String? paymentMethod,
      List<ProductOrderBeneficiaryRequestVo>? beneficiaries});
}

/// @nodoc
class __$$ProductPurchaseUpdateRequestVoImplCopyWithImpl<$Res>
    extends _$ProductPurchaseUpdateRequestVoCopyWithImpl<$Res,
        _$ProductPurchaseUpdateRequestVoImpl>
    implements _$$ProductPurchaseUpdateRequestVoImplCopyWith<$Res> {
  __$$ProductPurchaseUpdateRequestVoImplCopyWithImpl(
      _$ProductPurchaseUpdateRequestVoImpl _value,
      $Res Function(_$ProductPurchaseUpdateRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientBankId = freezed,
    Object? paymentMethod = freezed,
    Object? beneficiaries = freezed,
  }) {
    return _then(_$ProductPurchaseUpdateRequestVoImpl(
      clientBankId: freezed == clientBankId
          ? _value.clientBankId
          : clientBankId // ignore: cast_nullable_to_non_nullable
              as int?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      beneficiaries: freezed == beneficiaries
          ? _value.beneficiaries
          : beneficiaries // ignore: cast_nullable_to_non_nullable
              as List<ProductOrderBeneficiaryRequestVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductPurchaseUpdateRequestVoImpl
    extends _ProductPurchaseUpdateRequestVo {
  _$ProductPurchaseUpdateRequestVoImpl(
      {this.clientBankId, this.paymentMethod, this.beneficiaries})
      : super._();

  factory _$ProductPurchaseUpdateRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ProductPurchaseUpdateRequestVoImplFromJson(json);

  @override
  int? clientBankId;
  @override
  String? paymentMethod;
  @override
  List<ProductOrderBeneficiaryRequestVo>? beneficiaries;

  @override
  String toString() {
    return 'ProductPurchaseUpdateRequestVo(clientBankId: $clientBankId, paymentMethod: $paymentMethod, beneficiaries: $beneficiaries)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductPurchaseUpdateRequestVoImplCopyWith<
          _$ProductPurchaseUpdateRequestVoImpl>
      get copyWith => __$$ProductPurchaseUpdateRequestVoImplCopyWithImpl<
          _$ProductPurchaseUpdateRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductPurchaseUpdateRequestVoImplToJson(
      this,
    );
  }
}

abstract class _ProductPurchaseUpdateRequestVo
    extends ProductPurchaseUpdateRequestVo {
  factory _ProductPurchaseUpdateRequestVo(
          {int? clientBankId,
          String? paymentMethod,
          List<ProductOrderBeneficiaryRequestVo>? beneficiaries}) =
      _$ProductPurchaseUpdateRequestVoImpl;
  _ProductPurchaseUpdateRequestVo._() : super._();

  factory _ProductPurchaseUpdateRequestVo.fromJson(Map<String, dynamic> json) =
      _$ProductPurchaseUpdateRequestVoImpl.fromJson;

  @override
  int? get clientBankId;
  set clientBankId(int? value);
  @override
  String? get paymentMethod;
  set paymentMethod(String? value);
  @override
  List<ProductOrderBeneficiaryRequestVo>? get beneficiaries;
  set beneficiaries(List<ProductOrderBeneficiaryRequestVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductPurchaseUpdateRequestVoImplCopyWith<
          _$ProductPurchaseUpdateRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
