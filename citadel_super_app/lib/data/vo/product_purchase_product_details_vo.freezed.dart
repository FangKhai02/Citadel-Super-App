// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_purchase_product_details_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductPurchaseProductDetailsVo _$ProductPurchaseProductDetailsVoFromJson(
    Map<String, dynamic> json) {
  return _ProductPurchaseProductDetailsVo.fromJson(json);
}

/// @nodoc
mixin _$ProductPurchaseProductDetailsVo {
  int? get productId => throw _privateConstructorUsedError;
  set productId(int? value) => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  set amount(double? value) => throw _privateConstructorUsedError;
  double? get dividend => throw _privateConstructorUsedError;
  set dividend(double? value) => throw _privateConstructorUsedError;
  int? get investmentTenureMonth => throw _privateConstructorUsedError;
  set investmentTenureMonth(int? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductPurchaseProductDetailsVoCopyWith<ProductPurchaseProductDetailsVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductPurchaseProductDetailsVoCopyWith<$Res> {
  factory $ProductPurchaseProductDetailsVoCopyWith(
          ProductPurchaseProductDetailsVo value,
          $Res Function(ProductPurchaseProductDetailsVo) then) =
      _$ProductPurchaseProductDetailsVoCopyWithImpl<$Res,
          ProductPurchaseProductDetailsVo>;
  @useResult
  $Res call(
      {int? productId,
      double? amount,
      double? dividend,
      int? investmentTenureMonth});
}

/// @nodoc
class _$ProductPurchaseProductDetailsVoCopyWithImpl<$Res,
        $Val extends ProductPurchaseProductDetailsVo>
    implements $ProductPurchaseProductDetailsVoCopyWith<$Res> {
  _$ProductPurchaseProductDetailsVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = freezed,
    Object? amount = freezed,
    Object? dividend = freezed,
    Object? investmentTenureMonth = freezed,
  }) {
    return _then(_value.copyWith(
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      dividend: freezed == dividend
          ? _value.dividend
          : dividend // ignore: cast_nullable_to_non_nullable
              as double?,
      investmentTenureMonth: freezed == investmentTenureMonth
          ? _value.investmentTenureMonth
          : investmentTenureMonth // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductPurchaseProductDetailsVoImplCopyWith<$Res>
    implements $ProductPurchaseProductDetailsVoCopyWith<$Res> {
  factory _$$ProductPurchaseProductDetailsVoImplCopyWith(
          _$ProductPurchaseProductDetailsVoImpl value,
          $Res Function(_$ProductPurchaseProductDetailsVoImpl) then) =
      __$$ProductPurchaseProductDetailsVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? productId,
      double? amount,
      double? dividend,
      int? investmentTenureMonth});
}

/// @nodoc
class __$$ProductPurchaseProductDetailsVoImplCopyWithImpl<$Res>
    extends _$ProductPurchaseProductDetailsVoCopyWithImpl<$Res,
        _$ProductPurchaseProductDetailsVoImpl>
    implements _$$ProductPurchaseProductDetailsVoImplCopyWith<$Res> {
  __$$ProductPurchaseProductDetailsVoImplCopyWithImpl(
      _$ProductPurchaseProductDetailsVoImpl _value,
      $Res Function(_$ProductPurchaseProductDetailsVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = freezed,
    Object? amount = freezed,
    Object? dividend = freezed,
    Object? investmentTenureMonth = freezed,
  }) {
    return _then(_$ProductPurchaseProductDetailsVoImpl(
      productId: freezed == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as int?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      dividend: freezed == dividend
          ? _value.dividend
          : dividend // ignore: cast_nullable_to_non_nullable
              as double?,
      investmentTenureMonth: freezed == investmentTenureMonth
          ? _value.investmentTenureMonth
          : investmentTenureMonth // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductPurchaseProductDetailsVoImpl
    extends _ProductPurchaseProductDetailsVo {
  _$ProductPurchaseProductDetailsVoImpl(
      {this.productId, this.amount, this.dividend, this.investmentTenureMonth})
      : super._();

  factory _$ProductPurchaseProductDetailsVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ProductPurchaseProductDetailsVoImplFromJson(json);

  @override
  int? productId;
  @override
  double? amount;
  @override
  double? dividend;
  @override
  int? investmentTenureMonth;

  @override
  String toString() {
    return 'ProductPurchaseProductDetailsVo(productId: $productId, amount: $amount, dividend: $dividend, investmentTenureMonth: $investmentTenureMonth)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductPurchaseProductDetailsVoImplCopyWith<
          _$ProductPurchaseProductDetailsVoImpl>
      get copyWith => __$$ProductPurchaseProductDetailsVoImplCopyWithImpl<
          _$ProductPurchaseProductDetailsVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductPurchaseProductDetailsVoImplToJson(
      this,
    );
  }
}

abstract class _ProductPurchaseProductDetailsVo
    extends ProductPurchaseProductDetailsVo {
  factory _ProductPurchaseProductDetailsVo(
      {int? productId,
      double? amount,
      double? dividend,
      int? investmentTenureMonth}) = _$ProductPurchaseProductDetailsVoImpl;
  _ProductPurchaseProductDetailsVo._() : super._();

  factory _ProductPurchaseProductDetailsVo.fromJson(Map<String, dynamic> json) =
      _$ProductPurchaseProductDetailsVoImpl.fromJson;

  @override
  int? get productId;
  set productId(int? value);
  @override
  double? get amount;
  set amount(double? value);
  @override
  double? get dividend;
  set dividend(double? value);
  @override
  int? get investmentTenureMonth;
  set investmentTenureMonth(int? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductPurchaseProductDetailsVoImplCopyWith<
          _$ProductPurchaseProductDetailsVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
