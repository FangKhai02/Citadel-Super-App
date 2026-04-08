// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agents_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentsResponseVo _$AgentsResponseVoFromJson(Map<String, dynamic> json) {
  return _AgentsResponseVo.fromJson(json);
}

/// @nodoc
mixin _$AgentsResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<AgentVo>? get agentsList => throw _privateConstructorUsedError;
  set agentsList(List<AgentVo>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentsResponseVoCopyWith<AgentsResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentsResponseVoCopyWith<$Res> {
  factory $AgentsResponseVoCopyWith(
          AgentsResponseVo value, $Res Function(AgentsResponseVo) then) =
      _$AgentsResponseVoCopyWithImpl<$Res, AgentsResponseVo>;
  @useResult
  $Res call({String? code, String? message, List<AgentVo>? agentsList});
}

/// @nodoc
class _$AgentsResponseVoCopyWithImpl<$Res, $Val extends AgentsResponseVo>
    implements $AgentsResponseVoCopyWith<$Res> {
  _$AgentsResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? agentsList = freezed,
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
      agentsList: freezed == agentsList
          ? _value.agentsList
          : agentsList // ignore: cast_nullable_to_non_nullable
              as List<AgentVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentsResponseVoImplCopyWith<$Res>
    implements $AgentsResponseVoCopyWith<$Res> {
  factory _$$AgentsResponseVoImplCopyWith(_$AgentsResponseVoImpl value,
          $Res Function(_$AgentsResponseVoImpl) then) =
      __$$AgentsResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, List<AgentVo>? agentsList});
}

/// @nodoc
class __$$AgentsResponseVoImplCopyWithImpl<$Res>
    extends _$AgentsResponseVoCopyWithImpl<$Res, _$AgentsResponseVoImpl>
    implements _$$AgentsResponseVoImplCopyWith<$Res> {
  __$$AgentsResponseVoImplCopyWithImpl(_$AgentsResponseVoImpl _value,
      $Res Function(_$AgentsResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? agentsList = freezed,
  }) {
    return _then(_$AgentsResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      agentsList: freezed == agentsList
          ? _value.agentsList
          : agentsList // ignore: cast_nullable_to_non_nullable
              as List<AgentVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentsResponseVoImpl extends _AgentsResponseVo {
  _$AgentsResponseVoImpl({this.code, this.message, this.agentsList})
      : super._();

  factory _$AgentsResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgentsResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<AgentVo>? agentsList;

  @override
  String toString() {
    return 'AgentsResponseVo(code: $code, message: $message, agentsList: $agentsList)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentsResponseVoImplCopyWith<_$AgentsResponseVoImpl> get copyWith =>
      __$$AgentsResponseVoImplCopyWithImpl<_$AgentsResponseVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentsResponseVoImplToJson(
      this,
    );
  }
}

abstract class _AgentsResponseVo extends AgentsResponseVo {
  factory _AgentsResponseVo(
      {String? code,
      String? message,
      List<AgentVo>? agentsList}) = _$AgentsResponseVoImpl;
  _AgentsResponseVo._() : super._();

  factory _AgentsResponseVo.fromJson(Map<String, dynamic> json) =
      _$AgentsResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<AgentVo>? get agentsList;
  set agentsList(List<AgentVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentsResponseVoImplCopyWith<_$AgentsResponseVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
