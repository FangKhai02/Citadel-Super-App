// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rollover_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RolloverRequestVo _$RolloverRequestVoFromJson(Map<String, dynamic> json) {
  return _RolloverRequestVo.fromJson(json);
}

/// @nodoc
mixin _$RolloverRequestVo {
  double? get rolloverAmount => throw _privateConstructorUsedError;
  set rolloverAmount(double? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RolloverRequestVoCopyWith<RolloverRequestVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RolloverRequestVoCopyWith<$Res> {
  factory $RolloverRequestVoCopyWith(
          RolloverRequestVo value, $Res Function(RolloverRequestVo) then) =
      _$RolloverRequestVoCopyWithImpl<$Res, RolloverRequestVo>;
  @useResult
  $Res call({double? rolloverAmount});
}

/// @nodoc
class _$RolloverRequestVoCopyWithImpl<$Res, $Val extends RolloverRequestVo>
    implements $RolloverRequestVoCopyWith<$Res> {
  _$RolloverRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rolloverAmount = freezed,
  }) {
    return _then(_value.copyWith(
      rolloverAmount: freezed == rolloverAmount
          ? _value.rolloverAmount
          : rolloverAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RolloverRequestVoImplCopyWith<$Res>
    implements $RolloverRequestVoCopyWith<$Res> {
  factory _$$RolloverRequestVoImplCopyWith(_$RolloverRequestVoImpl value,
          $Res Function(_$RolloverRequestVoImpl) then) =
      __$$RolloverRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? rolloverAmount});
}

/// @nodoc
class __$$RolloverRequestVoImplCopyWithImpl<$Res>
    extends _$RolloverRequestVoCopyWithImpl<$Res, _$RolloverRequestVoImpl>
    implements _$$RolloverRequestVoImplCopyWith<$Res> {
  __$$RolloverRequestVoImplCopyWithImpl(_$RolloverRequestVoImpl _value,
      $Res Function(_$RolloverRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rolloverAmount = freezed,
  }) {
    return _then(_$RolloverRequestVoImpl(
      rolloverAmount: freezed == rolloverAmount
          ? _value.rolloverAmount
          : rolloverAmount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RolloverRequestVoImpl extends _RolloverRequestVo {
  _$RolloverRequestVoImpl({this.rolloverAmount}) : super._();

  factory _$RolloverRequestVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$RolloverRequestVoImplFromJson(json);

  @override
  double? rolloverAmount;

  @override
  String toString() {
    return 'RolloverRequestVo(rolloverAmount: $rolloverAmount)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RolloverRequestVoImplCopyWith<_$RolloverRequestVoImpl> get copyWith =>
      __$$RolloverRequestVoImplCopyWithImpl<_$RolloverRequestVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RolloverRequestVoImplToJson(
      this,
    );
  }
}

abstract class _RolloverRequestVo extends RolloverRequestVo {
  factory _RolloverRequestVo({double? rolloverAmount}) =
      _$RolloverRequestVoImpl;
  _RolloverRequestVo._() : super._();

  factory _RolloverRequestVo.fromJson(Map<String, dynamic> json) =
      _$RolloverRequestVoImpl.fromJson;

  @override
  double? get rolloverAmount;
  set rolloverAmount(double? value);
  @override
  @JsonKey(ignore: true)
  _$$RolloverRequestVoImplCopyWith<_$RolloverRequestVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
