// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SettingsResponseVo _$SettingsResponseVoFromJson(Map<String, dynamic> json) {
  return _SettingsResponseVo.fromJson(json);
}

/// @nodoc
mixin _$SettingsResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<SettingsItemVo>? get settings => throw _privateConstructorUsedError;
  set settings(List<SettingsItemVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingsResponseVoCopyWith<SettingsResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsResponseVoCopyWith<$Res> {
  factory $SettingsResponseVoCopyWith(
          SettingsResponseVo value, $Res Function(SettingsResponseVo) then) =
      _$SettingsResponseVoCopyWithImpl<$Res, SettingsResponseVo>;
  @useResult
  $Res call({String? code, String? message, List<SettingsItemVo>? settings});
}

/// @nodoc
class _$SettingsResponseVoCopyWithImpl<$Res, $Val extends SettingsResponseVo>
    implements $SettingsResponseVoCopyWith<$Res> {
  _$SettingsResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? settings = freezed,
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
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as List<SettingsItemVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingsResponseVoImplCopyWith<$Res>
    implements $SettingsResponseVoCopyWith<$Res> {
  factory _$$SettingsResponseVoImplCopyWith(_$SettingsResponseVoImpl value,
          $Res Function(_$SettingsResponseVoImpl) then) =
      __$$SettingsResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, List<SettingsItemVo>? settings});
}

/// @nodoc
class __$$SettingsResponseVoImplCopyWithImpl<$Res>
    extends _$SettingsResponseVoCopyWithImpl<$Res, _$SettingsResponseVoImpl>
    implements _$$SettingsResponseVoImplCopyWith<$Res> {
  __$$SettingsResponseVoImplCopyWithImpl(_$SettingsResponseVoImpl _value,
      $Res Function(_$SettingsResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? settings = freezed,
  }) {
    return _then(_$SettingsResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as List<SettingsItemVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingsResponseVoImpl extends _SettingsResponseVo {
  _$SettingsResponseVoImpl({this.code, this.message, this.settings})
      : super._();

  factory _$SettingsResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<SettingsItemVo>? settings;

  @override
  String toString() {
    return 'SettingsResponseVo(code: $code, message: $message, settings: $settings)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsResponseVoImplCopyWith<_$SettingsResponseVoImpl> get copyWith =>
      __$$SettingsResponseVoImplCopyWithImpl<_$SettingsResponseVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsResponseVoImplToJson(
      this,
    );
  }
}

abstract class _SettingsResponseVo extends SettingsResponseVo {
  factory _SettingsResponseVo(
      {String? code,
      String? message,
      List<SettingsItemVo>? settings}) = _$SettingsResponseVoImpl;
  _SettingsResponseVo._() : super._();

  factory _SettingsResponseVo.fromJson(Map<String, dynamic> json) =
      _$SettingsResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<SettingsItemVo>? get settings;
  set settings(List<SettingsItemVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$SettingsResponseVoImplCopyWith<_$SettingsResponseVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
