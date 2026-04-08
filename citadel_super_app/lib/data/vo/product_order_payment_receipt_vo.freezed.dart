// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_order_payment_receipt_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductOrderPaymentReceiptVo _$ProductOrderPaymentReceiptVoFromJson(
    Map<String, dynamic> json) {
  return _ProductOrderPaymentReceiptVo.fromJson(json);
}

/// @nodoc
mixin _$ProductOrderPaymentReceiptVo {
  int? get id => throw _privateConstructorUsedError;
  set id(int? value) => throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;
  set fileName(String? value) => throw _privateConstructorUsedError;
  String? get file => throw _privateConstructorUsedError;
  set file(String? value) => throw _privateConstructorUsedError;
  String? get uploadStatus => throw _privateConstructorUsedError;
  set uploadStatus(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductOrderPaymentReceiptVoCopyWith<ProductOrderPaymentReceiptVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductOrderPaymentReceiptVoCopyWith<$Res> {
  factory $ProductOrderPaymentReceiptVoCopyWith(
          ProductOrderPaymentReceiptVo value,
          $Res Function(ProductOrderPaymentReceiptVo) then) =
      _$ProductOrderPaymentReceiptVoCopyWithImpl<$Res,
          ProductOrderPaymentReceiptVo>;
  @useResult
  $Res call({int? id, String? fileName, String? file, String? uploadStatus});
}

/// @nodoc
class _$ProductOrderPaymentReceiptVoCopyWithImpl<$Res,
        $Val extends ProductOrderPaymentReceiptVo>
    implements $ProductOrderPaymentReceiptVoCopyWith<$Res> {
  _$ProductOrderPaymentReceiptVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fileName = freezed,
    Object? file = freezed,
    Object? uploadStatus = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadStatus: freezed == uploadStatus
          ? _value.uploadStatus
          : uploadStatus // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductOrderPaymentReceiptVoImplCopyWith<$Res>
    implements $ProductOrderPaymentReceiptVoCopyWith<$Res> {
  factory _$$ProductOrderPaymentReceiptVoImplCopyWith(
          _$ProductOrderPaymentReceiptVoImpl value,
          $Res Function(_$ProductOrderPaymentReceiptVoImpl) then) =
      __$$ProductOrderPaymentReceiptVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? fileName, String? file, String? uploadStatus});
}

/// @nodoc
class __$$ProductOrderPaymentReceiptVoImplCopyWithImpl<$Res>
    extends _$ProductOrderPaymentReceiptVoCopyWithImpl<$Res,
        _$ProductOrderPaymentReceiptVoImpl>
    implements _$$ProductOrderPaymentReceiptVoImplCopyWith<$Res> {
  __$$ProductOrderPaymentReceiptVoImplCopyWithImpl(
      _$ProductOrderPaymentReceiptVoImpl _value,
      $Res Function(_$ProductOrderPaymentReceiptVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? fileName = freezed,
    Object? file = freezed,
    Object? uploadStatus = freezed,
  }) {
    return _then(_$ProductOrderPaymentReceiptVoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      file: freezed == file
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as String?,
      uploadStatus: freezed == uploadStatus
          ? _value.uploadStatus
          : uploadStatus // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductOrderPaymentReceiptVoImpl extends _ProductOrderPaymentReceiptVo {
  _$ProductOrderPaymentReceiptVoImpl(
      {this.id, this.fileName, this.file, this.uploadStatus})
      : super._();

  factory _$ProductOrderPaymentReceiptVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ProductOrderPaymentReceiptVoImplFromJson(json);

  @override
  int? id;
  @override
  String? fileName;
  @override
  String? file;
  @override
  String? uploadStatus;

  @override
  String toString() {
    return 'ProductOrderPaymentReceiptVo(id: $id, fileName: $fileName, file: $file, uploadStatus: $uploadStatus)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductOrderPaymentReceiptVoImplCopyWith<
          _$ProductOrderPaymentReceiptVoImpl>
      get copyWith => __$$ProductOrderPaymentReceiptVoImplCopyWithImpl<
          _$ProductOrderPaymentReceiptVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductOrderPaymentReceiptVoImplToJson(
      this,
    );
  }
}

abstract class _ProductOrderPaymentReceiptVo
    extends ProductOrderPaymentReceiptVo {
  factory _ProductOrderPaymentReceiptVo(
      {int? id,
      String? fileName,
      String? file,
      String? uploadStatus}) = _$ProductOrderPaymentReceiptVoImpl;
  _ProductOrderPaymentReceiptVo._() : super._();

  factory _ProductOrderPaymentReceiptVo.fromJson(Map<String, dynamic> json) =
      _$ProductOrderPaymentReceiptVoImpl.fromJson;

  @override
  int? get id;
  set id(int? value);
  @override
  String? get fileName;
  set fileName(String? value);
  @override
  String? get file;
  set file(String? value);
  @override
  String? get uploadStatus;
  set uploadStatus(String? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductOrderPaymentReceiptVoImplCopyWith<
          _$ProductOrderPaymentReceiptVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
