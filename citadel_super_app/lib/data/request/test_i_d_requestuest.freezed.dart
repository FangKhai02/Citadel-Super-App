// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_i_d_requestuest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TestIDRequestuest _$TestIDRequestuestFromJson(Map<String, dynamic> json) {
  return _TestIDRequestuest.fromJson(json);
}

/// @nodoc
mixin _$TestIDRequestuest {
  List<int>? get longIds => throw _privateConstructorUsedError;
  set longIds(List<int>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TestIDRequestuestCopyWith<TestIDRequestuest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestIDRequestuestCopyWith<$Res> {
  factory $TestIDRequestuestCopyWith(
          TestIDRequestuest value, $Res Function(TestIDRequestuest) then) =
      _$TestIDRequestuestCopyWithImpl<$Res, TestIDRequestuest>;
  @useResult
  $Res call({List<int>? longIds});
}

/// @nodoc
class _$TestIDRequestuestCopyWithImpl<$Res, $Val extends TestIDRequestuest>
    implements $TestIDRequestuestCopyWith<$Res> {
  _$TestIDRequestuestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? longIds = freezed,
  }) {
    return _then(_value.copyWith(
      longIds: freezed == longIds
          ? _value.longIds
          : longIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TestIDRequestuestImplCopyWith<$Res>
    implements $TestIDRequestuestCopyWith<$Res> {
  factory _$$TestIDRequestuestImplCopyWith(_$TestIDRequestuestImpl value,
          $Res Function(_$TestIDRequestuestImpl) then) =
      __$$TestIDRequestuestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<int>? longIds});
}

/// @nodoc
class __$$TestIDRequestuestImplCopyWithImpl<$Res>
    extends _$TestIDRequestuestCopyWithImpl<$Res, _$TestIDRequestuestImpl>
    implements _$$TestIDRequestuestImplCopyWith<$Res> {
  __$$TestIDRequestuestImplCopyWithImpl(_$TestIDRequestuestImpl _value,
      $Res Function(_$TestIDRequestuestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? longIds = freezed,
  }) {
    return _then(_$TestIDRequestuestImpl(
      longIds: freezed == longIds
          ? _value.longIds
          : longIds // ignore: cast_nullable_to_non_nullable
              as List<int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TestIDRequestuestImpl extends _TestIDRequestuest {
  _$TestIDRequestuestImpl({this.longIds}) : super._();

  factory _$TestIDRequestuestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TestIDRequestuestImplFromJson(json);

  @override
  List<int>? longIds;

  @override
  String toString() {
    return 'TestIDRequestuest(longIds: $longIds)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TestIDRequestuestImplCopyWith<_$TestIDRequestuestImpl> get copyWith =>
      __$$TestIDRequestuestImplCopyWithImpl<_$TestIDRequestuestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TestIDRequestuestImplToJson(
      this,
    );
  }
}

abstract class _TestIDRequestuest extends TestIDRequestuest {
  factory _TestIDRequestuest({List<int>? longIds}) = _$TestIDRequestuestImpl;
  _TestIDRequestuest._() : super._();

  factory _TestIDRequestuest.fromJson(Map<String, dynamic> json) =
      _$TestIDRequestuestImpl.fromJson;

  @override
  List<int>? get longIds;
  set longIds(List<int>? value);
  @override
  @JsonKey(ignore: true)
  _$$TestIDRequestuestImplCopyWith<_$TestIDRequestuestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
