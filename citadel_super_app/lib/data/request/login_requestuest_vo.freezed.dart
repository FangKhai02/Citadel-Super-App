// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_requestuest_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginRequestuestVo _$LoginRequestuestVoFromJson(Map<String, dynamic> json) {
  return _LoginRequestuestVo.fromJson(json);
}

/// @nodoc
mixin _$LoginRequestuestVo {
  String? get email => throw _privateConstructorUsedError;
  set email(String? value) => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  set password(String? value) => throw _privateConstructorUsedError;
  String? get oneSignalSubscriptionId => throw _privateConstructorUsedError;
  set oneSignalSubscriptionId(String? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginRequestuestVoCopyWith<LoginRequestuestVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRequestuestVoCopyWith<$Res> {
  factory $LoginRequestuestVoCopyWith(
          LoginRequestuestVo value, $Res Function(LoginRequestuestVo) then) =
      _$LoginRequestuestVoCopyWithImpl<$Res, LoginRequestuestVo>;
  @useResult
  $Res call({String? email, String? password, String? oneSignalSubscriptionId});
}

/// @nodoc
class _$LoginRequestuestVoCopyWithImpl<$Res, $Val extends LoginRequestuestVo>
    implements $LoginRequestuestVoCopyWith<$Res> {
  _$LoginRequestuestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? oneSignalSubscriptionId = freezed,
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
      oneSignalSubscriptionId: freezed == oneSignalSubscriptionId
          ? _value.oneSignalSubscriptionId
          : oneSignalSubscriptionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginRequestuestVoImplCopyWith<$Res>
    implements $LoginRequestuestVoCopyWith<$Res> {
  factory _$$LoginRequestuestVoImplCopyWith(_$LoginRequestuestVoImpl value,
          $Res Function(_$LoginRequestuestVoImpl) then) =
      __$$LoginRequestuestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? email, String? password, String? oneSignalSubscriptionId});
}

/// @nodoc
class __$$LoginRequestuestVoImplCopyWithImpl<$Res>
    extends _$LoginRequestuestVoCopyWithImpl<$Res, _$LoginRequestuestVoImpl>
    implements _$$LoginRequestuestVoImplCopyWith<$Res> {
  __$$LoginRequestuestVoImplCopyWithImpl(_$LoginRequestuestVoImpl _value,
      $Res Function(_$LoginRequestuestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? oneSignalSubscriptionId = freezed,
  }) {
    return _then(_$LoginRequestuestVoImpl(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      oneSignalSubscriptionId: freezed == oneSignalSubscriptionId
          ? _value.oneSignalSubscriptionId
          : oneSignalSubscriptionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginRequestuestVoImpl extends _LoginRequestuestVo {
  _$LoginRequestuestVoImpl(
      {this.email, this.password, this.oneSignalSubscriptionId})
      : super._();

  factory _$LoginRequestuestVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginRequestuestVoImplFromJson(json);

  @override
  String? email;
  @override
  String? password;
  @override
  String? oneSignalSubscriptionId;

  @override
  String toString() {
    return 'LoginRequestuestVo(email: $email, password: $password, oneSignalSubscriptionId: $oneSignalSubscriptionId)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginRequestuestVoImplCopyWith<_$LoginRequestuestVoImpl> get copyWith =>
      __$$LoginRequestuestVoImplCopyWithImpl<_$LoginRequestuestVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginRequestuestVoImplToJson(
      this,
    );
  }
}

abstract class _LoginRequestuestVo extends LoginRequestuestVo {
  factory _LoginRequestuestVo(
      {String? email,
      String? password,
      String? oneSignalSubscriptionId}) = _$LoginRequestuestVoImpl;
  _LoginRequestuestVo._() : super._();

  factory _LoginRequestuestVo.fromJson(Map<String, dynamic> json) =
      _$LoginRequestuestVoImpl.fromJson;

  @override
  String? get email;
  set email(String? value);
  @override
  String? get password;
  set password(String? value);
  @override
  String? get oneSignalSubscriptionId;
  set oneSignalSubscriptionId(String? value);
  @override
  @JsonKey(ignore: true)
  _$$LoginRequestuestVoImplCopyWith<_$LoginRequestuestVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
