// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_bank_details_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductBankDetailsResponseVo _$ProductBankDetailsResponseVoFromJson(
    Map<String, dynamic> json) {
  return _ProductBankDetailsResponseVo.fromJson(json);
}

/// @nodoc
mixin _$ProductBankDetailsResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  String? get bankName => throw _privateConstructorUsedError;
  set bankName(String? value) => throw _privateConstructorUsedError;
  String? get bankAccountName => throw _privateConstructorUsedError;
  set bankAccountName(String? value) => throw _privateConstructorUsedError;
  String? get bankAccountNumber => throw _privateConstructorUsedError;
  set bankAccountNumber(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductBankDetailsResponseVoCopyWith<ProductBankDetailsResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductBankDetailsResponseVoCopyWith<$Res> {
  factory $ProductBankDetailsResponseVoCopyWith(
          ProductBankDetailsResponseVo value,
          $Res Function(ProductBankDetailsResponseVo) then) =
      _$ProductBankDetailsResponseVoCopyWithImpl<$Res,
          ProductBankDetailsResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      String? bankName,
      String? bankAccountName,
      String? bankAccountNumber});
}

/// @nodoc
class _$ProductBankDetailsResponseVoCopyWithImpl<$Res,
        $Val extends ProductBankDetailsResponseVo>
    implements $ProductBankDetailsResponseVoCopyWith<$Res> {
  _$ProductBankDetailsResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? bankName = freezed,
    Object? bankAccountName = freezed,
    Object? bankAccountNumber = freezed,
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
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      bankAccountName: freezed == bankAccountName
          ? _value.bankAccountName
          : bankAccountName // ignore: cast_nullable_to_non_nullable
              as String?,
      bankAccountNumber: freezed == bankAccountNumber
          ? _value.bankAccountNumber
          : bankAccountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductBankDetailsResponseVoImplCopyWith<$Res>
    implements $ProductBankDetailsResponseVoCopyWith<$Res> {
  factory _$$ProductBankDetailsResponseVoImplCopyWith(
          _$ProductBankDetailsResponseVoImpl value,
          $Res Function(_$ProductBankDetailsResponseVoImpl) then) =
      __$$ProductBankDetailsResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      String? bankName,
      String? bankAccountName,
      String? bankAccountNumber});
}

/// @nodoc
class __$$ProductBankDetailsResponseVoImplCopyWithImpl<$Res>
    extends _$ProductBankDetailsResponseVoCopyWithImpl<$Res,
        _$ProductBankDetailsResponseVoImpl>
    implements _$$ProductBankDetailsResponseVoImplCopyWith<$Res> {
  __$$ProductBankDetailsResponseVoImplCopyWithImpl(
      _$ProductBankDetailsResponseVoImpl _value,
      $Res Function(_$ProductBankDetailsResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? bankName = freezed,
    Object? bankAccountName = freezed,
    Object? bankAccountNumber = freezed,
  }) {
    return _then(_$ProductBankDetailsResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      bankAccountName: freezed == bankAccountName
          ? _value.bankAccountName
          : bankAccountName // ignore: cast_nullable_to_non_nullable
              as String?,
      bankAccountNumber: freezed == bankAccountNumber
          ? _value.bankAccountNumber
          : bankAccountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductBankDetailsResponseVoImpl extends _ProductBankDetailsResponseVo {
  _$ProductBankDetailsResponseVoImpl(
      {this.code,
      this.message,
      this.bankName,
      this.bankAccountName,
      this.bankAccountNumber})
      : super._();

  factory _$ProductBankDetailsResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ProductBankDetailsResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  String? bankName;
  @override
  String? bankAccountName;
  @override
  String? bankAccountNumber;

  @override
  String toString() {
    return 'ProductBankDetailsResponseVo(code: $code, message: $message, bankName: $bankName, bankAccountName: $bankAccountName, bankAccountNumber: $bankAccountNumber)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductBankDetailsResponseVoImplCopyWith<
          _$ProductBankDetailsResponseVoImpl>
      get copyWith => __$$ProductBankDetailsResponseVoImplCopyWithImpl<
          _$ProductBankDetailsResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductBankDetailsResponseVoImplToJson(
      this,
    );
  }
}

abstract class _ProductBankDetailsResponseVo
    extends ProductBankDetailsResponseVo {
  factory _ProductBankDetailsResponseVo(
      {String? code,
      String? message,
      String? bankName,
      String? bankAccountName,
      String? bankAccountNumber}) = _$ProductBankDetailsResponseVoImpl;
  _ProductBankDetailsResponseVo._() : super._();

  factory _ProductBankDetailsResponseVo.fromJson(Map<String, dynamic> json) =
      _$ProductBankDetailsResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  String? get bankName;
  set bankName(String? value);
  @override
  String? get bankAccountName;
  set bankAccountName(String? value);
  @override
  String? get bankAccountNumber;
  set bankAccountNumber(String? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductBankDetailsResponseVoImplCopyWith<
          _$ProductBankDetailsResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
