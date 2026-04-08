// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_order_payment_upload_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductOrderPaymentUploadResponseVo
    _$ProductOrderPaymentUploadResponseVoFromJson(Map<String, dynamic> json) {
  return _ProductOrderPaymentUploadResponseVo.fromJson(json);
}

/// @nodoc
mixin _$ProductOrderPaymentUploadResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<ProductOrderPaymentReceiptVo>? get paymentReceipts =>
      throw _privateConstructorUsedError;
  set paymentReceipts(List<ProductOrderPaymentReceiptVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductOrderPaymentUploadResponseVoCopyWith<
          ProductOrderPaymentUploadResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductOrderPaymentUploadResponseVoCopyWith<$Res> {
  factory $ProductOrderPaymentUploadResponseVoCopyWith(
          ProductOrderPaymentUploadResponseVo value,
          $Res Function(ProductOrderPaymentUploadResponseVo) then) =
      _$ProductOrderPaymentUploadResponseVoCopyWithImpl<$Res,
          ProductOrderPaymentUploadResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<ProductOrderPaymentReceiptVo>? paymentReceipts});
}

/// @nodoc
class _$ProductOrderPaymentUploadResponseVoCopyWithImpl<$Res,
        $Val extends ProductOrderPaymentUploadResponseVo>
    implements $ProductOrderPaymentUploadResponseVoCopyWith<$Res> {
  _$ProductOrderPaymentUploadResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? paymentReceipts = freezed,
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
      paymentReceipts: freezed == paymentReceipts
          ? _value.paymentReceipts
          : paymentReceipts // ignore: cast_nullable_to_non_nullable
              as List<ProductOrderPaymentReceiptVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductOrderPaymentUploadResponseVoImplCopyWith<$Res>
    implements $ProductOrderPaymentUploadResponseVoCopyWith<$Res> {
  factory _$$ProductOrderPaymentUploadResponseVoImplCopyWith(
          _$ProductOrderPaymentUploadResponseVoImpl value,
          $Res Function(_$ProductOrderPaymentUploadResponseVoImpl) then) =
      __$$ProductOrderPaymentUploadResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<ProductOrderPaymentReceiptVo>? paymentReceipts});
}

/// @nodoc
class __$$ProductOrderPaymentUploadResponseVoImplCopyWithImpl<$Res>
    extends _$ProductOrderPaymentUploadResponseVoCopyWithImpl<$Res,
        _$ProductOrderPaymentUploadResponseVoImpl>
    implements _$$ProductOrderPaymentUploadResponseVoImplCopyWith<$Res> {
  __$$ProductOrderPaymentUploadResponseVoImplCopyWithImpl(
      _$ProductOrderPaymentUploadResponseVoImpl _value,
      $Res Function(_$ProductOrderPaymentUploadResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? paymentReceipts = freezed,
  }) {
    return _then(_$ProductOrderPaymentUploadResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
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
class _$ProductOrderPaymentUploadResponseVoImpl
    extends _ProductOrderPaymentUploadResponseVo {
  _$ProductOrderPaymentUploadResponseVoImpl(
      {this.code, this.message, this.paymentReceipts})
      : super._();

  factory _$ProductOrderPaymentUploadResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ProductOrderPaymentUploadResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<ProductOrderPaymentReceiptVo>? paymentReceipts;

  @override
  String toString() {
    return 'ProductOrderPaymentUploadResponseVo(code: $code, message: $message, paymentReceipts: $paymentReceipts)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductOrderPaymentUploadResponseVoImplCopyWith<
          _$ProductOrderPaymentUploadResponseVoImpl>
      get copyWith => __$$ProductOrderPaymentUploadResponseVoImplCopyWithImpl<
          _$ProductOrderPaymentUploadResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductOrderPaymentUploadResponseVoImplToJson(
      this,
    );
  }
}

abstract class _ProductOrderPaymentUploadResponseVo
    extends ProductOrderPaymentUploadResponseVo {
  factory _ProductOrderPaymentUploadResponseVo(
          {String? code,
          String? message,
          List<ProductOrderPaymentReceiptVo>? paymentReceipts}) =
      _$ProductOrderPaymentUploadResponseVoImpl;
  _ProductOrderPaymentUploadResponseVo._() : super._();

  factory _ProductOrderPaymentUploadResponseVo.fromJson(
          Map<String, dynamic> json) =
      _$ProductOrderPaymentUploadResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<ProductOrderPaymentReceiptVo>? get paymentReceipts;
  set paymentReceipts(List<ProductOrderPaymentReceiptVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductOrderPaymentUploadResponseVoImplCopyWith<
          _$ProductOrderPaymentUploadResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
