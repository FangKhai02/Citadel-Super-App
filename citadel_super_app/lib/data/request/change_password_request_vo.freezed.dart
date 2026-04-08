// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'change_password_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChangePasswordRequestVo _$ChangePasswordRequestVoFromJson(
    Map<String, dynamic> json) {
  return _ChangePasswordRequestVo.fromJson(json);
}

/// @nodoc
mixin _$ChangePasswordRequestVo {
  String? get oldPassword => throw _privateConstructorUsedError;
  set oldPassword(String? value) => throw _privateConstructorUsedError;
  String? get newPassword => throw _privateConstructorUsedError;
  set newPassword(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChangePasswordRequestVoCopyWith<ChangePasswordRequestVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangePasswordRequestVoCopyWith<$Res> {
  factory $ChangePasswordRequestVoCopyWith(ChangePasswordRequestVo value,
          $Res Function(ChangePasswordRequestVo) then) =
      _$ChangePasswordRequestVoCopyWithImpl<$Res, ChangePasswordRequestVo>;
  @useResult
  $Res call({String? oldPassword, String? newPassword});
}

/// @nodoc
class _$ChangePasswordRequestVoCopyWithImpl<$Res,
        $Val extends ChangePasswordRequestVo>
    implements $ChangePasswordRequestVoCopyWith<$Res> {
  _$ChangePasswordRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldPassword = freezed,
    Object? newPassword = freezed,
  }) {
    return _then(_value.copyWith(
      oldPassword: freezed == oldPassword
          ? _value.oldPassword
          : oldPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      newPassword: freezed == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangePasswordRequestVoImplCopyWith<$Res>
    implements $ChangePasswordRequestVoCopyWith<$Res> {
  factory _$$ChangePasswordRequestVoImplCopyWith(
          _$ChangePasswordRequestVoImpl value,
          $Res Function(_$ChangePasswordRequestVoImpl) then) =
      __$$ChangePasswordRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? oldPassword, String? newPassword});
}

/// @nodoc
class __$$ChangePasswordRequestVoImplCopyWithImpl<$Res>
    extends _$ChangePasswordRequestVoCopyWithImpl<$Res,
        _$ChangePasswordRequestVoImpl>
    implements _$$ChangePasswordRequestVoImplCopyWith<$Res> {
  __$$ChangePasswordRequestVoImplCopyWithImpl(
      _$ChangePasswordRequestVoImpl _value,
      $Res Function(_$ChangePasswordRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? oldPassword = freezed,
    Object? newPassword = freezed,
  }) {
    return _then(_$ChangePasswordRequestVoImpl(
      oldPassword: freezed == oldPassword
          ? _value.oldPassword
          : oldPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      newPassword: freezed == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangePasswordRequestVoImpl extends _ChangePasswordRequestVo {
  _$ChangePasswordRequestVoImpl({this.oldPassword, this.newPassword})
      : super._();

  factory _$ChangePasswordRequestVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChangePasswordRequestVoImplFromJson(json);

  @override
  String? oldPassword;
  @override
  String? newPassword;

  @override
  String toString() {
    return 'ChangePasswordRequestVo(oldPassword: $oldPassword, newPassword: $newPassword)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePasswordRequestVoImplCopyWith<_$ChangePasswordRequestVoImpl>
      get copyWith => __$$ChangePasswordRequestVoImplCopyWithImpl<
          _$ChangePasswordRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangePasswordRequestVoImplToJson(
      this,
    );
  }
}

abstract class _ChangePasswordRequestVo extends ChangePasswordRequestVo {
  factory _ChangePasswordRequestVo({String? oldPassword, String? newPassword}) =
      _$ChangePasswordRequestVoImpl;
  _ChangePasswordRequestVo._() : super._();

  factory _ChangePasswordRequestVo.fromJson(Map<String, dynamic> json) =
      _$ChangePasswordRequestVoImpl.fromJson;

  @override
  String? get oldPassword;
  set oldPassword(String? value);
  @override
  String? get newPassword;
  set newPassword(String? value);
  @override
  @JsonKey(ignore: true)
  _$$ChangePasswordRequestVoImplCopyWith<_$ChangePasswordRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
