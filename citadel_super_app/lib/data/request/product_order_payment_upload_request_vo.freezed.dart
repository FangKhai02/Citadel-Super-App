// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_order_payment_upload_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductOrderPaymentUploadRequestVo _$ProductOrderPaymentUploadRequestVoFromJson(
    Map<String, dynamic> json) {
  return _ProductOrderPaymentUploadRequestVo.fromJson(json);
}

/// @nodoc
mixin _$ProductOrderPaymentUploadRequestVo {
  List<ProductOrderPaymentReceiptVo>? get receipts =>
      throw _privateConstructorUsedError;
  set receipts(List<ProductOrderPaymentReceiptVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductOrderPaymentUploadRequestVoCopyWith<
          ProductOrderPaymentUploadRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductOrderPaymentUploadRequestVoCopyWith<$Res> {
  factory $ProductOrderPaymentUploadRequestVoCopyWith(
          ProductOrderPaymentUploadRequestVo value,
          $Res Function(ProductOrderPaymentUploadRequestVo) then) =
      _$ProductOrderPaymentUploadRequestVoCopyWithImpl<$Res,
          ProductOrderPaymentUploadRequestVo>;
  @useResult
  $Res call({List<ProductOrderPaymentReceiptVo>? receipts});
}

/// @nodoc
class _$ProductOrderPaymentUploadRequestVoCopyWithImpl<$Res,
        $Val extends ProductOrderPaymentUploadRequestVo>
    implements $ProductOrderPaymentUploadRequestVoCopyWith<$Res> {
  _$ProductOrderPaymentUploadRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receipts = freezed,
  }) {
    return _then(_value.copyWith(
      receipts: freezed == receipts
          ? _value.receipts
          : receipts // ignore: cast_nullable_to_non_nullable
              as List<ProductOrderPaymentReceiptVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductOrderPaymentUploadRequestVoImplCopyWith<$Res>
    implements $ProductOrderPaymentUploadRequestVoCopyWith<$Res> {
  factory _$$ProductOrderPaymentUploadRequestVoImplCopyWith(
          _$ProductOrderPaymentUploadRequestVoImpl value,
          $Res Function(_$ProductOrderPaymentUploadRequestVoImpl) then) =
      __$$ProductOrderPaymentUploadRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ProductOrderPaymentReceiptVo>? receipts});
}

/// @nodoc
class __$$ProductOrderPaymentUploadRequestVoImplCopyWithImpl<$Res>
    extends _$ProductOrderPaymentUploadRequestVoCopyWithImpl<$Res,
        _$ProductOrderPaymentUploadRequestVoImpl>
    implements _$$ProductOrderPaymentUploadRequestVoImplCopyWith<$Res> {
  __$$ProductOrderPaymentUploadRequestVoImplCopyWithImpl(
      _$ProductOrderPaymentUploadRequestVoImpl _value,
      $Res Function(_$ProductOrderPaymentUploadRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? receipts = freezed,
  }) {
    return _then(_$ProductOrderPaymentUploadRequestVoImpl(
      receipts: freezed == receipts
          ? _value.receipts
          : receipts // ignore: cast_nullable_to_non_nullable
              as List<ProductOrderPaymentReceiptVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductOrderPaymentUploadRequestVoImpl
    extends _ProductOrderPaymentUploadRequestVo {
  _$ProductOrderPaymentUploadRequestVoImpl({this.receipts}) : super._();

  factory _$ProductOrderPaymentUploadRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ProductOrderPaymentUploadRequestVoImplFromJson(json);

  @override
  List<ProductOrderPaymentReceiptVo>? receipts;

  @override
  String toString() {
    return 'ProductOrderPaymentUploadRequestVo(receipts: $receipts)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductOrderPaymentUploadRequestVoImplCopyWith<
          _$ProductOrderPaymentUploadRequestVoImpl>
      get copyWith => __$$ProductOrderPaymentUploadRequestVoImplCopyWithImpl<
          _$ProductOrderPaymentUploadRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductOrderPaymentUploadRequestVoImplToJson(
      this,
    );
  }
}

abstract class _ProductOrderPaymentUploadRequestVo
    extends ProductOrderPaymentUploadRequestVo {
  factory _ProductOrderPaymentUploadRequestVo(
          {List<ProductOrderPaymentReceiptVo>? receipts}) =
      _$ProductOrderPaymentUploadRequestVoImpl;
  _ProductOrderPaymentUploadRequestVo._() : super._();

  factory _ProductOrderPaymentUploadRequestVo.fromJson(
          Map<String, dynamic> json) =
      _$ProductOrderPaymentUploadRequestVoImpl.fromJson;

  @override
  List<ProductOrderPaymentReceiptVo>? get receipts;
  set receipts(List<ProductOrderPaymentReceiptVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductOrderPaymentUploadRequestVoImplCopyWith<
          _$ProductOrderPaymentUploadRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
