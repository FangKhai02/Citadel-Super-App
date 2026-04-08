// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_order_payment_details_base_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductOrderPaymentDetailsBaseVo _$ProductOrderPaymentDetailsBaseVoFromJson(
    Map<String, dynamic> json) {
  return _ProductOrderPaymentDetailsBaseVo.fromJson(json);
}

/// @nodoc
mixin _$ProductOrderPaymentDetailsBaseVo {
  String? get paymentMethod => throw _privateConstructorUsedError;
  set paymentMethod(String? value) => throw _privateConstructorUsedError;
  String? get paymentStatus => throw _privateConstructorUsedError;
  set paymentStatus(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductOrderPaymentDetailsBaseVoCopyWith<ProductOrderPaymentDetailsBaseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductOrderPaymentDetailsBaseVoCopyWith<$Res> {
  factory $ProductOrderPaymentDetailsBaseVoCopyWith(
          ProductOrderPaymentDetailsBaseVo value,
          $Res Function(ProductOrderPaymentDetailsBaseVo) then) =
      _$ProductOrderPaymentDetailsBaseVoCopyWithImpl<$Res,
          ProductOrderPaymentDetailsBaseVo>;
  @useResult
  $Res call({String? paymentMethod, String? paymentStatus});
}

/// @nodoc
class _$ProductOrderPaymentDetailsBaseVoCopyWithImpl<$Res,
        $Val extends ProductOrderPaymentDetailsBaseVo>
    implements $ProductOrderPaymentDetailsBaseVoCopyWith<$Res> {
  _$ProductOrderPaymentDetailsBaseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentMethod = freezed,
    Object? paymentStatus = freezed,
  }) {
    return _then(_value.copyWith(
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentStatus: freezed == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductOrderPaymentDetailsBaseVoImplCopyWith<$Res>
    implements $ProductOrderPaymentDetailsBaseVoCopyWith<$Res> {
  factory _$$ProductOrderPaymentDetailsBaseVoImplCopyWith(
          _$ProductOrderPaymentDetailsBaseVoImpl value,
          $Res Function(_$ProductOrderPaymentDetailsBaseVoImpl) then) =
      __$$ProductOrderPaymentDetailsBaseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? paymentMethod, String? paymentStatus});
}

/// @nodoc
class __$$ProductOrderPaymentDetailsBaseVoImplCopyWithImpl<$Res>
    extends _$ProductOrderPaymentDetailsBaseVoCopyWithImpl<$Res,
        _$ProductOrderPaymentDetailsBaseVoImpl>
    implements _$$ProductOrderPaymentDetailsBaseVoImplCopyWith<$Res> {
  __$$ProductOrderPaymentDetailsBaseVoImplCopyWithImpl(
      _$ProductOrderPaymentDetailsBaseVoImpl _value,
      $Res Function(_$ProductOrderPaymentDetailsBaseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentMethod = freezed,
    Object? paymentStatus = freezed,
  }) {
    return _then(_$ProductOrderPaymentDetailsBaseVoImpl(
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentStatus: freezed == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductOrderPaymentDetailsBaseVoImpl
    extends _ProductOrderPaymentDetailsBaseVo {
  _$ProductOrderPaymentDetailsBaseVoImpl(
      {this.paymentMethod, this.paymentStatus})
      : super._();

  factory _$ProductOrderPaymentDetailsBaseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ProductOrderPaymentDetailsBaseVoImplFromJson(json);

  @override
  String? paymentMethod;
  @override
  String? paymentStatus;

  @override
  String toString() {
    return 'ProductOrderPaymentDetailsBaseVo(paymentMethod: $paymentMethod, paymentStatus: $paymentStatus)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductOrderPaymentDetailsBaseVoImplCopyWith<
          _$ProductOrderPaymentDetailsBaseVoImpl>
      get copyWith => __$$ProductOrderPaymentDetailsBaseVoImplCopyWithImpl<
          _$ProductOrderPaymentDetailsBaseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductOrderPaymentDetailsBaseVoImplToJson(
      this,
    );
  }
}

abstract class _ProductOrderPaymentDetailsBaseVo
    extends ProductOrderPaymentDetailsBaseVo {
  factory _ProductOrderPaymentDetailsBaseVo(
      {String? paymentMethod,
      String? paymentStatus}) = _$ProductOrderPaymentDetailsBaseVoImpl;
  _ProductOrderPaymentDetailsBaseVo._() : super._();

  factory _ProductOrderPaymentDetailsBaseVo.fromJson(
          Map<String, dynamic> json) =
      _$ProductOrderPaymentDetailsBaseVoImpl.fromJson;

  @override
  String? get paymentMethod;
  set paymentMethod(String? value);
  @override
  String? get paymentStatus;
  set paymentStatus(String? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductOrderPaymentDetailsBaseVoImplCopyWith<
          _$ProductOrderPaymentDetailsBaseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
