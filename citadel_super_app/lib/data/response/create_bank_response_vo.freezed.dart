// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_bank_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateBankResponseVo _$CreateBankResponseVoFromJson(Map<String, dynamic> json) {
  return _CreateBankResponseVo.fromJson(json);
}

/// @nodoc
mixin _$CreateBankResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  BankDetailsVo? get bankDetails => throw _privateConstructorUsedError;
  set bankDetails(BankDetailsVo? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateBankResponseVoCopyWith<CreateBankResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateBankResponseVoCopyWith<$Res> {
  factory $CreateBankResponseVoCopyWith(CreateBankResponseVo value,
          $Res Function(CreateBankResponseVo) then) =
      _$CreateBankResponseVoCopyWithImpl<$Res, CreateBankResponseVo>;
  @useResult
  $Res call({String? code, String? message, BankDetailsVo? bankDetails});

  $BankDetailsVoCopyWith<$Res>? get bankDetails;
}

/// @nodoc
class _$CreateBankResponseVoCopyWithImpl<$Res,
        $Val extends CreateBankResponseVo>
    implements $CreateBankResponseVoCopyWith<$Res> {
  _$CreateBankResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? bankDetails = freezed,
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
      bankDetails: freezed == bankDetails
          ? _value.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as BankDetailsVo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BankDetailsVoCopyWith<$Res>? get bankDetails {
    if (_value.bankDetails == null) {
      return null;
    }

    return $BankDetailsVoCopyWith<$Res>(_value.bankDetails!, (value) {
      return _then(_value.copyWith(bankDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateBankResponseVoImplCopyWith<$Res>
    implements $CreateBankResponseVoCopyWith<$Res> {
  factory _$$CreateBankResponseVoImplCopyWith(_$CreateBankResponseVoImpl value,
          $Res Function(_$CreateBankResponseVoImpl) then) =
      __$$CreateBankResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, BankDetailsVo? bankDetails});

  @override
  $BankDetailsVoCopyWith<$Res>? get bankDetails;
}

/// @nodoc
class __$$CreateBankResponseVoImplCopyWithImpl<$Res>
    extends _$CreateBankResponseVoCopyWithImpl<$Res, _$CreateBankResponseVoImpl>
    implements _$$CreateBankResponseVoImplCopyWith<$Res> {
  __$$CreateBankResponseVoImplCopyWithImpl(_$CreateBankResponseVoImpl _value,
      $Res Function(_$CreateBankResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? bankDetails = freezed,
  }) {
    return _then(_$CreateBankResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      bankDetails: freezed == bankDetails
          ? _value.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as BankDetailsVo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateBankResponseVoImpl extends _CreateBankResponseVo {
  _$CreateBankResponseVoImpl({this.code, this.message, this.bankDetails})
      : super._();

  factory _$CreateBankResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateBankResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  BankDetailsVo? bankDetails;

  @override
  String toString() {
    return 'CreateBankResponseVo(code: $code, message: $message, bankDetails: $bankDetails)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateBankResponseVoImplCopyWith<_$CreateBankResponseVoImpl>
      get copyWith =>
          __$$CreateBankResponseVoImplCopyWithImpl<_$CreateBankResponseVoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateBankResponseVoImplToJson(
      this,
    );
  }
}

abstract class _CreateBankResponseVo extends CreateBankResponseVo {
  factory _CreateBankResponseVo(
      {String? code,
      String? message,
      BankDetailsVo? bankDetails}) = _$CreateBankResponseVoImpl;
  _CreateBankResponseVo._() : super._();

  factory _CreateBankResponseVo.fromJson(Map<String, dynamic> json) =
      _$CreateBankResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  BankDetailsVo? get bankDetails;
  set bankDetails(BankDetailsVo? value);
  @override
  @JsonKey(ignore: true)
  _$$CreateBankResponseVoImplCopyWith<_$CreateBankResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
