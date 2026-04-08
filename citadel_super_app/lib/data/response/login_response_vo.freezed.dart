// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginResponseVo _$LoginResponseVoFromJson(Map<String, dynamic> json) {
  return _LoginResponseVo.fromJson(json);
}

/// @nodoc
mixin _$LoginResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  String? get apiKey => throw _privateConstructorUsedError;
  set apiKey(String? value) => throw _privateConstructorUsedError;
  bool? get hasPin => throw _privateConstructorUsedError;
  set hasPin(bool? value) => throw _privateConstructorUsedError;
  String? get userType => throw _privateConstructorUsedError;
  set userType(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginResponseVoCopyWith<LoginResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginResponseVoCopyWith<$Res> {
  factory $LoginResponseVoCopyWith(
          LoginResponseVo value, $Res Function(LoginResponseVo) then) =
      _$LoginResponseVoCopyWithImpl<$Res, LoginResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      String? apiKey,
      bool? hasPin,
      String? userType});
}

/// @nodoc
class _$LoginResponseVoCopyWithImpl<$Res, $Val extends LoginResponseVo>
    implements $LoginResponseVoCopyWith<$Res> {
  _$LoginResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? apiKey = freezed,
    Object? hasPin = freezed,
    Object? userType = freezed,
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
      apiKey: freezed == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      hasPin: freezed == hasPin
          ? _value.hasPin
          : hasPin // ignore: cast_nullable_to_non_nullable
              as bool?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginResponseVoImplCopyWith<$Res>
    implements $LoginResponseVoCopyWith<$Res> {
  factory _$$LoginResponseVoImplCopyWith(_$LoginResponseVoImpl value,
          $Res Function(_$LoginResponseVoImpl) then) =
      __$$LoginResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      String? apiKey,
      bool? hasPin,
      String? userType});
}

/// @nodoc
class __$$LoginResponseVoImplCopyWithImpl<$Res>
    extends _$LoginResponseVoCopyWithImpl<$Res, _$LoginResponseVoImpl>
    implements _$$LoginResponseVoImplCopyWith<$Res> {
  __$$LoginResponseVoImplCopyWithImpl(
      _$LoginResponseVoImpl _value, $Res Function(_$LoginResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? apiKey = freezed,
    Object? hasPin = freezed,
    Object? userType = freezed,
  }) {
    return _then(_$LoginResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      apiKey: freezed == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String?,
      hasPin: freezed == hasPin
          ? _value.hasPin
          : hasPin // ignore: cast_nullable_to_non_nullable
              as bool?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginResponseVoImpl extends _LoginResponseVo {
  _$LoginResponseVoImpl(
      {this.code, this.message, this.apiKey, this.hasPin, this.userType})
      : super._();

  factory _$LoginResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  String? apiKey;
  @override
  bool? hasPin;
  @override
  String? userType;

  @override
  String toString() {
    return 'LoginResponseVo(code: $code, message: $message, apiKey: $apiKey, hasPin: $hasPin, userType: $userType)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginResponseVoImplCopyWith<_$LoginResponseVoImpl> get copyWith =>
      __$$LoginResponseVoImplCopyWithImpl<_$LoginResponseVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginResponseVoImplToJson(
      this,
    );
  }
}

abstract class _LoginResponseVo extends LoginResponseVo {
  factory _LoginResponseVo(
      {String? code,
      String? message,
      String? apiKey,
      bool? hasPin,
      String? userType}) = _$LoginResponseVoImpl;
  _LoginResponseVo._() : super._();

  factory _LoginResponseVo.fromJson(Map<String, dynamic> json) =
      _$LoginResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  String? get apiKey;
  set apiKey(String? value);
  @override
  bool? get hasPin;
  set hasPin(bool? value);
  @override
  String? get userType;
  set userType(String? value);
  @override
  @JsonKey(ignore: true)
  _$$LoginResponseVoImplCopyWith<_$LoginResponseVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
