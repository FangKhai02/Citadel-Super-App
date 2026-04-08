// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ResetPasswordRequestVo _$ResetPasswordRequestVoFromJson(
    Map<String, dynamic> json) {
  return _ResetPasswordRequestVo.fromJson(json);
}

/// @nodoc
mixin _$ResetPasswordRequestVo {
  String? get email => throw _privateConstructorUsedError;
  set email(String? value) => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  set password(String? value) => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  set token(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ResetPasswordRequestVoCopyWith<ResetPasswordRequestVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResetPasswordRequestVoCopyWith<$Res> {
  factory $ResetPasswordRequestVoCopyWith(ResetPasswordRequestVo value,
          $Res Function(ResetPasswordRequestVo) then) =
      _$ResetPasswordRequestVoCopyWithImpl<$Res, ResetPasswordRequestVo>;
  @useResult
  $Res call({String? email, String? password, String? token});
}

/// @nodoc
class _$ResetPasswordRequestVoCopyWithImpl<$Res,
        $Val extends ResetPasswordRequestVo>
    implements $ResetPasswordRequestVoCopyWith<$Res> {
  _$ResetPasswordRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ResetPasswordRequestVoImplCopyWith<$Res>
    implements $ResetPasswordRequestVoCopyWith<$Res> {
  factory _$$ResetPasswordRequestVoImplCopyWith(
          _$ResetPasswordRequestVoImpl value,
          $Res Function(_$ResetPasswordRequestVoImpl) then) =
      __$$ResetPasswordRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? email, String? password, String? token});
}

/// @nodoc
class __$$ResetPasswordRequestVoImplCopyWithImpl<$Res>
    extends _$ResetPasswordRequestVoCopyWithImpl<$Res,
        _$ResetPasswordRequestVoImpl>
    implements _$$ResetPasswordRequestVoImplCopyWith<$Res> {
  __$$ResetPasswordRequestVoImplCopyWithImpl(
      _$ResetPasswordRequestVoImpl _value,
      $Res Function(_$ResetPasswordRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? token = freezed,
  }) {
    return _then(_$ResetPasswordRequestVoImpl(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ResetPasswordRequestVoImpl extends _ResetPasswordRequestVo {
  _$ResetPasswordRequestVoImpl({this.email, this.password, this.token})
      : super._();

  factory _$ResetPasswordRequestVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResetPasswordRequestVoImplFromJson(json);

  @override
  String? email;
  @override
  String? password;
  @override
  String? token;

  @override
  String toString() {
    return 'ResetPasswordRequestVo(email: $email, password: $password, token: $token)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResetPasswordRequestVoImplCopyWith<_$ResetPasswordRequestVoImpl>
      get copyWith => __$$ResetPasswordRequestVoImplCopyWithImpl<
          _$ResetPasswordRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ResetPasswordRequestVoImplToJson(
      this,
    );
  }
}

abstract class _ResetPasswordRequestVo extends ResetPasswordRequestVo {
  factory _ResetPasswordRequestVo(
      {String? email,
      String? password,
      String? token}) = _$ResetPasswordRequestVoImpl;
  _ResetPasswordRequestVo._() : super._();

  factory _ResetPasswordRequestVo.fromJson(Map<String, dynamic> json) =
      _$ResetPasswordRequestVoImpl.fromJson;

  @override
  String? get email;
  set email(String? value);
  @override
  String? get password;
  set password(String? value);
  @override
  String? get token;
  set token(String? value);
  @override
  @JsonKey(ignore: true)
  _$$ResetPasswordRequestVoImplCopyWith<_$ResetPasswordRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
