// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'constant_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConstantVo _$ConstantVoFromJson(Map<String, dynamic> json) {
  return _ConstantVo.fromJson(json);
}

/// @nodoc
mixin _$ConstantVo {
  String? get category => throw _privateConstructorUsedError;
  set category(String? value) => throw _privateConstructorUsedError;
  List<KeyValueMapVo>? get list => throw _privateConstructorUsedError;
  set list(List<KeyValueMapVo>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConstantVoCopyWith<ConstantVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConstantVoCopyWith<$Res> {
  factory $ConstantVoCopyWith(
          ConstantVo value, $Res Function(ConstantVo) then) =
      _$ConstantVoCopyWithImpl<$Res, ConstantVo>;
  @useResult
  $Res call({String? category, List<KeyValueMapVo>? list});
}

/// @nodoc
class _$ConstantVoCopyWithImpl<$Res, $Val extends ConstantVo>
    implements $ConstantVoCopyWith<$Res> {
  _$ConstantVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? list = freezed,
  }) {
    return _then(_value.copyWith(
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      list: freezed == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<KeyValueMapVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConstantVoImplCopyWith<$Res>
    implements $ConstantVoCopyWith<$Res> {
  factory _$$ConstantVoImplCopyWith(
          _$ConstantVoImpl value, $Res Function(_$ConstantVoImpl) then) =
      __$$ConstantVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? category, List<KeyValueMapVo>? list});
}

/// @nodoc
class __$$ConstantVoImplCopyWithImpl<$Res>
    extends _$ConstantVoCopyWithImpl<$Res, _$ConstantVoImpl>
    implements _$$ConstantVoImplCopyWith<$Res> {
  __$$ConstantVoImplCopyWithImpl(
      _$ConstantVoImpl _value, $Res Function(_$ConstantVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = freezed,
    Object? list = freezed,
  }) {
    return _then(_$ConstantVoImpl(
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      list: freezed == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<KeyValueMapVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConstantVoImpl extends _ConstantVo {
  _$ConstantVoImpl({this.category, this.list}) : super._();

  factory _$ConstantVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConstantVoImplFromJson(json);

  @override
  String? category;
  @override
  List<KeyValueMapVo>? list;

  @override
  String toString() {
    return 'ConstantVo(category: $category, list: $list)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConstantVoImplCopyWith<_$ConstantVoImpl> get copyWith =>
      __$$ConstantVoImplCopyWithImpl<_$ConstantVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConstantVoImplToJson(
      this,
    );
  }
}

abstract class _ConstantVo extends ConstantVo {
  factory _ConstantVo({String? category, List<KeyValueMapVo>? list}) =
      _$ConstantVoImpl;
  _ConstantVo._() : super._();

  factory _ConstantVo.fromJson(Map<String, dynamic> json) =
      _$ConstantVoImpl.fromJson;

  @override
  String? get category;
  set category(String? value);
  @override
  List<KeyValueMapVo>? get list;
  set list(List<KeyValueMapVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$ConstantVoImplCopyWith<_$ConstantVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
