// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_item_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SettingsItemVo _$SettingsItemVoFromJson(Map<String, dynamic> json) {
  return _SettingsItemVo.fromJson(json);
}

/// @nodoc
mixin _$SettingsItemVo {
  String? get key => throw _privateConstructorUsedError;
  set key(String? value) => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
  set value(String? value) => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  set displayName(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingsItemVoCopyWith<SettingsItemVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsItemVoCopyWith<$Res> {
  factory $SettingsItemVoCopyWith(
          SettingsItemVo value, $Res Function(SettingsItemVo) then) =
      _$SettingsItemVoCopyWithImpl<$Res, SettingsItemVo>;
  @useResult
  $Res call({String? key, String? value, String? displayName});
}

/// @nodoc
class _$SettingsItemVoCopyWithImpl<$Res, $Val extends SettingsItemVo>
    implements $SettingsItemVoCopyWith<$Res> {
  _$SettingsItemVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? value = freezed,
    Object? displayName = freezed,
  }) {
    return _then(_value.copyWith(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingsItemVoImplCopyWith<$Res>
    implements $SettingsItemVoCopyWith<$Res> {
  factory _$$SettingsItemVoImplCopyWith(_$SettingsItemVoImpl value,
          $Res Function(_$SettingsItemVoImpl) then) =
      __$$SettingsItemVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? key, String? value, String? displayName});
}

/// @nodoc
class __$$SettingsItemVoImplCopyWithImpl<$Res>
    extends _$SettingsItemVoCopyWithImpl<$Res, _$SettingsItemVoImpl>
    implements _$$SettingsItemVoImplCopyWith<$Res> {
  __$$SettingsItemVoImplCopyWithImpl(
      _$SettingsItemVoImpl _value, $Res Function(_$SettingsItemVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? value = freezed,
    Object? displayName = freezed,
  }) {
    return _then(_$SettingsItemVoImpl(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingsItemVoImpl extends _SettingsItemVo {
  _$SettingsItemVoImpl({this.key, this.value, this.displayName}) : super._();

  factory _$SettingsItemVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsItemVoImplFromJson(json);

  @override
  String? key;
  @override
  String? value;
  @override
  String? displayName;

  @override
  String toString() {
    return 'SettingsItemVo(key: $key, value: $value, displayName: $displayName)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsItemVoImplCopyWith<_$SettingsItemVoImpl> get copyWith =>
      __$$SettingsItemVoImplCopyWithImpl<_$SettingsItemVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsItemVoImplToJson(
      this,
    );
  }
}

abstract class _SettingsItemVo extends SettingsItemVo {
  factory _SettingsItemVo({String? key, String? value, String? displayName}) =
      _$SettingsItemVoImpl;
  _SettingsItemVo._() : super._();

  factory _SettingsItemVo.fromJson(Map<String, dynamic> json) =
      _$SettingsItemVoImpl.fromJson;

  @override
  String? get key;
  set key(String? value);
  @override
  String? get value;
  set value(String? value);
  @override
  String? get displayName;
  set displayName(String? value);
  @override
  @JsonKey(ignore: true)
  _$$SettingsItemVoImplCopyWith<_$SettingsItemVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
