// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key_value_map_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KeyValueMapVo _$KeyValueMapVoFromJson(Map<String, dynamic> json) {
  return _KeyValueMapVo.fromJson(json);
}

/// @nodoc
mixin _$KeyValueMapVo {
  String? get key => throw _privateConstructorUsedError;
  set key(String? value) => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
  set value(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KeyValueMapVoCopyWith<KeyValueMapVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyValueMapVoCopyWith<$Res> {
  factory $KeyValueMapVoCopyWith(
          KeyValueMapVo value, $Res Function(KeyValueMapVo) then) =
      _$KeyValueMapVoCopyWithImpl<$Res, KeyValueMapVo>;
  @useResult
  $Res call({String? key, String? value});
}

/// @nodoc
class _$KeyValueMapVoCopyWithImpl<$Res, $Val extends KeyValueMapVo>
    implements $KeyValueMapVoCopyWith<$Res> {
  _$KeyValueMapVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? value = freezed,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$KeyValueMapVoImplCopyWith<$Res>
    implements $KeyValueMapVoCopyWith<$Res> {
  factory _$$KeyValueMapVoImplCopyWith(
          _$KeyValueMapVoImpl value, $Res Function(_$KeyValueMapVoImpl) then) =
      __$$KeyValueMapVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? key, String? value});
}

/// @nodoc
class __$$KeyValueMapVoImplCopyWithImpl<$Res>
    extends _$KeyValueMapVoCopyWithImpl<$Res, _$KeyValueMapVoImpl>
    implements _$$KeyValueMapVoImplCopyWith<$Res> {
  __$$KeyValueMapVoImplCopyWithImpl(
      _$KeyValueMapVoImpl _value, $Res Function(_$KeyValueMapVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = freezed,
    Object? value = freezed,
  }) {
    return _then(_$KeyValueMapVoImpl(
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$KeyValueMapVoImpl extends _KeyValueMapVo {
  _$KeyValueMapVoImpl({this.key, this.value}) : super._();

  factory _$KeyValueMapVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$KeyValueMapVoImplFromJson(json);

  @override
  String? key;
  @override
  String? value;

  @override
  String toString() {
    return 'KeyValueMapVo(key: $key, value: $value)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyValueMapVoImplCopyWith<_$KeyValueMapVoImpl> get copyWith =>
      __$$KeyValueMapVoImplCopyWithImpl<_$KeyValueMapVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KeyValueMapVoImplToJson(
      this,
    );
  }
}

abstract class _KeyValueMapVo extends KeyValueMapVo {
  factory _KeyValueMapVo({String? key, String? value}) = _$KeyValueMapVoImpl;
  _KeyValueMapVo._() : super._();

  factory _KeyValueMapVo.fromJson(Map<String, dynamic> json) =
      _$KeyValueMapVoImpl.fromJson;

  @override
  String? get key;
  set key(String? value);
  @override
  String? get value;
  set value(String? value);
  @override
  @JsonKey(ignore: true)
  _$$KeyValueMapVoImplCopyWith<_$KeyValueMapVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
