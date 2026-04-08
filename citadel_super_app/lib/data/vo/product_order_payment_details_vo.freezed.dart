// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_order_payment_details_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductOrderPaymentDetailsVo _$ProductOrderPaymentDetailsVoFromJson(
    Map<String, dynamic> json) {
  return _ProductOrderPaymentDetailsVo.fromJson(json);
}

/// @nodoc
mixin _$ProductOrderPaymentDetailsVo {
  String? get paymentMethod => throw _privateConstructorUsedError;
  set paymentMethod(String? value) => throw _privateConstructorUsedError;
  String? get paymentStatus => throw _privateConstructorUsedError;
  set paymentStatus(String? value) => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  set transactionId(String? value) => throw _privateConstructorUsedError;
  String? get bankName => throw _privateConstructorUsedError;
  set bankName(String? value) => throw _privateConstructorUsedError;
  List<ProductOrderPaymentReceiptVo>? get paymentReceipts =>
      throw _privateConstructorUsedError;
  set paymentReceipts(List<ProductOrderPaymentReceiptVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductOrderPaymentDetailsVoCopyWith<ProductOrderPaymentDetailsVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductOrderPaymentDetailsVoCopyWith<$Res> {
  factory $ProductOrderPaymentDetailsVoCopyWith(
          ProductOrderPaymentDetailsVo value,
          $Res Function(ProductOrderPaymentDetailsVo) then) =
      _$ProductOrderPaymentDetailsVoCopyWithImpl<$Res,
          ProductOrderPaymentDetailsVo>;
  @useResult
  $Res call(
      {String? paymentMethod,
      String? paymentStatus,
      String? transactionId,
      String? bankName,
      List<ProductOrderPaymentReceiptVo>? paymentReceipts});
}

/// @nodoc
class _$ProductOrderPaymentDetailsVoCopyWithImpl<$Res,
        $Val extends ProductOrderPaymentDetailsVo>
    implements $ProductOrderPaymentDetailsVoCopyWith<$Res> {
  _$ProductOrderPaymentDetailsVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentMethod = freezed,
    Object? paymentStatus = freezed,
    Object? transactionId = freezed,
    Object? bankName = freezed,
    Object? paymentReceipts = freezed,
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
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentReceipts: freezed == paymentReceipts
          ? _value.paymentReceipts
          : paymentReceipts // ignore: cast_nullable_to_non_nullable
              as List<ProductOrderPaymentReceiptVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductOrderPaymentDetailsVoImplCopyWith<$Res>
    implements $ProductOrderPaymentDetailsVoCopyWith<$Res> {
  factory _$$ProductOrderPaymentDetailsVoImplCopyWith(
          _$ProductOrderPaymentDetailsVoImpl value,
          $Res Function(_$ProductOrderPaymentDetailsVoImpl) then) =
      __$$ProductOrderPaymentDetailsVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? paymentMethod,
      String? paymentStatus,
      String? transactionId,
      String? bankName,
      List<ProductOrderPaymentReceiptVo>? paymentReceipts});
}

/// @nodoc
class __$$ProductOrderPaymentDetailsVoImplCopyWithImpl<$Res>
    extends _$ProductOrderPaymentDetailsVoCopyWithImpl<$Res,
        _$ProductOrderPaymentDetailsVoImpl>
    implements _$$ProductOrderPaymentDetailsVoImplCopyWith<$Res> {
  __$$ProductOrderPaymentDetailsVoImplCopyWithImpl(
      _$ProductOrderPaymentDetailsVoImpl _value,
      $Res Function(_$ProductOrderPaymentDetailsVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentMethod = freezed,
    Object? paymentStatus = freezed,
    Object? transactionId = freezed,
    Object? bankName = freezed,
    Object? paymentReceipts = freezed,
  }) {
    return _then(_$ProductOrderPaymentDetailsVoImpl(
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentStatus: freezed == paymentStatus
          ? _value.paymentStatus
          : paymentStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentReceipts: freezed == paymentReceipts
          ? _value.paymentReceipts
          : paymentReceipts // ignore: cast_nullable_to_non_nullable
              as List<ProductOrderPaymentReceiptVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductOrderPaymentDetailsVoImpl extends _ProductOrderPaymentDetailsVo {
  _$ProductOrderPaymentDetailsVoImpl(
      {this.paymentMethod,
      this.paymentStatus,
      this.transactionId,
      this.bankName,
      this.paymentReceipts})
      : super._();

  factory _$ProductOrderPaymentDetailsVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ProductOrderPaymentDetailsVoImplFromJson(json);

  @override
  String? paymentMethod;
  @override
  String? paymentStatus;
  @override
  String? transactionId;
  @override
  String? bankName;
  @override
  List<ProductOrderPaymentReceiptVo>? paymentReceipts;

  @override
  String toString() {
    return 'ProductOrderPaymentDetailsVo(paymentMethod: $paymentMethod, paymentStatus: $paymentStatus, transactionId: $transactionId, bankName: $bankName, paymentReceipts: $paymentReceipts)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductOrderPaymentDetailsVoImplCopyWith<
          _$ProductOrderPaymentDetailsVoImpl>
      get copyWith => __$$ProductOrderPaymentDetailsVoImplCopyWithImpl<
          _$ProductOrderPaymentDetailsVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductOrderPaymentDetailsVoImplToJson(
      this,
    );
  }
}

abstract class _ProductOrderPaymentDetailsVo
    extends ProductOrderPaymentDetailsVo {
  factory _ProductOrderPaymentDetailsVo(
          {String? paymentMethod,
          String? paymentStatus,
          String? transactionId,
          String? bankName,
          List<ProductOrderPaymentReceiptVo>? paymentReceipts}) =
      _$ProductOrderPaymentDetailsVoImpl;
  _ProductOrderPaymentDetailsVo._() : super._();

  factory _ProductOrderPaymentDetailsVo.fromJson(Map<String, dynamic> json) =
      _$ProductOrderPaymentDetailsVoImpl.fromJson;

  @override
  String? get paymentMethod;
  set paymentMethod(String? value);
  @override
  String? get paymentStatus;
  set paymentStatus(String? value);
  @override
  String? get transactionId;
  set transactionId(String? value);
  @override
  String? get bankName;
  set bankName(String? value);
  @override
  List<ProductOrderPaymentReceiptVo>? get paymentReceipts;
  set paymentReceipts(List<ProductOrderPaymentReceiptVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductOrderPaymentDetailsVoImplCopyWith<
          _$ProductOrderPaymentDetailsVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
