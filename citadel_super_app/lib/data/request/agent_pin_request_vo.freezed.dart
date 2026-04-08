// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_pin_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentPinRequestVo _$AgentPinRequestVoFromJson(Map<String, dynamic> json) {
  return _AgentPinRequestVo.fromJson(json);
}

/// @nodoc
mixin _$AgentPinRequestVo {
  String? get newPin => throw _privateConstructorUsedError;
  set newPin(String? value) => throw _privateConstructorUsedError;
  String? get oldPin => throw _privateConstructorUsedError;
  set oldPin(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentPinRequestVoCopyWith<AgentPinRequestVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentPinRequestVoCopyWith<$Res> {
  factory $AgentPinRequestVoCopyWith(
          AgentPinRequestVo value, $Res Function(AgentPinRequestVo) then) =
      _$AgentPinRequestVoCopyWithImpl<$Res, AgentPinRequestVo>;
  @useResult
  $Res call({String? newPin, String? oldPin});
}

/// @nodoc
class _$AgentPinRequestVoCopyWithImpl<$Res, $Val extends AgentPinRequestVo>
    implements $AgentPinRequestVoCopyWith<$Res> {
  _$AgentPinRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newPin = freezed,
    Object? oldPin = freezed,
  }) {
    return _then(_value.copyWith(
      newPin: freezed == newPin
          ? _value.newPin
          : newPin // ignore: cast_nullable_to_non_nullable
              as String?,
      oldPin: freezed == oldPin
          ? _value.oldPin
          : oldPin // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentPinRequestVoImplCopyWith<$Res>
    implements $AgentPinRequestVoCopyWith<$Res> {
  factory _$$AgentPinRequestVoImplCopyWith(_$AgentPinRequestVoImpl value,
          $Res Function(_$AgentPinRequestVoImpl) then) =
      __$$AgentPinRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? newPin, String? oldPin});
}

/// @nodoc
class __$$AgentPinRequestVoImplCopyWithImpl<$Res>
    extends _$AgentPinRequestVoCopyWithImpl<$Res, _$AgentPinRequestVoImpl>
    implements _$$AgentPinRequestVoImplCopyWith<$Res> {
  __$$AgentPinRequestVoImplCopyWithImpl(_$AgentPinRequestVoImpl _value,
      $Res Function(_$AgentPinRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newPin = freezed,
    Object? oldPin = freezed,
  }) {
    return _then(_$AgentPinRequestVoImpl(
      newPin: freezed == newPin
          ? _value.newPin
          : newPin // ignore: cast_nullable_to_non_nullable
              as String?,
      oldPin: freezed == oldPin
          ? _value.oldPin
          : oldPin // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentPinRequestVoImpl extends _AgentPinRequestVo {
  _$AgentPinRequestVoImpl({this.newPin, this.oldPin}) : super._();

  factory _$AgentPinRequestVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgentPinRequestVoImplFromJson(json);

  @override
  String? newPin;
  @override
  String? oldPin;

  @override
  String toString() {
    return 'AgentPinRequestVo(newPin: $newPin, oldPin: $oldPin)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentPinRequestVoImplCopyWith<_$AgentPinRequestVoImpl> get copyWith =>
      __$$AgentPinRequestVoImplCopyWithImpl<_$AgentPinRequestVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentPinRequestVoImplToJson(
      this,
    );
  }
}

abstract class _AgentPinRequestVo extends AgentPinRequestVo {
  factory _AgentPinRequestVo({String? newPin, String? oldPin}) =
      _$AgentPinRequestVoImpl;
  _AgentPinRequestVo._() : super._();

  factory _AgentPinRequestVo.fromJson(Map<String, dynamic> json) =
      _$AgentPinRequestVoImpl.fromJson;

  @override
  String? get newPin;
  set newPin(String? value);
  @override
  String? get oldPin;
  set oldPin(String? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentPinRequestVoImplCopyWith<_$AgentPinRequestVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
