// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_user_delete_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WebUserDeleteRequestVo _$WebUserDeleteRequestVoFromJson(
    Map<String, dynamic> json) {
  return _WebUserDeleteRequestVo.fromJson(json);
}

/// @nodoc
mixin _$WebUserDeleteRequestVo {
  String? get email => throw _privateConstructorUsedError;
  set email(String? value) => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  set password(String? value) => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  set reason(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WebUserDeleteRequestVoCopyWith<WebUserDeleteRequestVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebUserDeleteRequestVoCopyWith<$Res> {
  factory $WebUserDeleteRequestVoCopyWith(WebUserDeleteRequestVo value,
          $Res Function(WebUserDeleteRequestVo) then) =
      _$WebUserDeleteRequestVoCopyWithImpl<$Res, WebUserDeleteRequestVo>;
  @useResult
  $Res call({String? email, String? password, String? reason});
}

/// @nodoc
class _$WebUserDeleteRequestVoCopyWithImpl<$Res,
        $Val extends WebUserDeleteRequestVo>
    implements $WebUserDeleteRequestVoCopyWith<$Res> {
  _$WebUserDeleteRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? reason = freezed,
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
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebUserDeleteRequestVoImplCopyWith<$Res>
    implements $WebUserDeleteRequestVoCopyWith<$Res> {
  factory _$$WebUserDeleteRequestVoImplCopyWith(
          _$WebUserDeleteRequestVoImpl value,
          $Res Function(_$WebUserDeleteRequestVoImpl) then) =
      __$$WebUserDeleteRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? email, String? password, String? reason});
}

/// @nodoc
class __$$WebUserDeleteRequestVoImplCopyWithImpl<$Res>
    extends _$WebUserDeleteRequestVoCopyWithImpl<$Res,
        _$WebUserDeleteRequestVoImpl>
    implements _$$WebUserDeleteRequestVoImplCopyWith<$Res> {
  __$$WebUserDeleteRequestVoImplCopyWithImpl(
      _$WebUserDeleteRequestVoImpl _value,
      $Res Function(_$WebUserDeleteRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? password = freezed,
    Object? reason = freezed,
  }) {
    return _then(_$WebUserDeleteRequestVoImpl(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WebUserDeleteRequestVoImpl extends _WebUserDeleteRequestVo {
  _$WebUserDeleteRequestVoImpl({this.email, this.password, this.reason})
      : super._();

  factory _$WebUserDeleteRequestVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$WebUserDeleteRequestVoImplFromJson(json);

  @override
  String? email;
  @override
  String? password;
  @override
  String? reason;

  @override
  String toString() {
    return 'WebUserDeleteRequestVo(email: $email, password: $password, reason: $reason)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebUserDeleteRequestVoImplCopyWith<_$WebUserDeleteRequestVoImpl>
      get copyWith => __$$WebUserDeleteRequestVoImplCopyWithImpl<
          _$WebUserDeleteRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WebUserDeleteRequestVoImplToJson(
      this,
    );
  }
}

abstract class _WebUserDeleteRequestVo extends WebUserDeleteRequestVo {
  factory _WebUserDeleteRequestVo(
      {String? email,
      String? password,
      String? reason}) = _$WebUserDeleteRequestVoImpl;
  _WebUserDeleteRequestVo._() : super._();

  factory _WebUserDeleteRequestVo.fromJson(Map<String, dynamic> json) =
      _$WebUserDeleteRequestVoImpl.fromJson;

  @override
  String? get email;
  set email(String? value);
  @override
  String? get password;
  set password(String? value);
  @override
  String? get reason;
  set reason(String? value);
  @override
  @JsonKey(ignore: true)
  _$$WebUserDeleteRequestVoImplCopyWith<_$WebUserDeleteRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
