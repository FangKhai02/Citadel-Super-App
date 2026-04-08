// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_down_line_list_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentDownLineListResponseVo _$AgentDownLineListResponseVoFromJson(
    Map<String, dynamic> json) {
  return _AgentDownLineListResponseVo.fromJson(json);
}

/// @nodoc
mixin _$AgentDownLineListResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<AgentVo>? get agentDownLineList => throw _privateConstructorUsedError;
  set agentDownLineList(List<AgentVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentDownLineListResponseVoCopyWith<AgentDownLineListResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentDownLineListResponseVoCopyWith<$Res> {
  factory $AgentDownLineListResponseVoCopyWith(
          AgentDownLineListResponseVo value,
          $Res Function(AgentDownLineListResponseVo) then) =
      _$AgentDownLineListResponseVoCopyWithImpl<$Res,
          AgentDownLineListResponseVo>;
  @useResult
  $Res call({String? code, String? message, List<AgentVo>? agentDownLineList});
}

/// @nodoc
class _$AgentDownLineListResponseVoCopyWithImpl<$Res,
        $Val extends AgentDownLineListResponseVo>
    implements $AgentDownLineListResponseVoCopyWith<$Res> {
  _$AgentDownLineListResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? agentDownLineList = freezed,
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
      agentDownLineList: freezed == agentDownLineList
          ? _value.agentDownLineList
          : agentDownLineList // ignore: cast_nullable_to_non_nullable
              as List<AgentVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentDownLineListResponseVoImplCopyWith<$Res>
    implements $AgentDownLineListResponseVoCopyWith<$Res> {
  factory _$$AgentDownLineListResponseVoImplCopyWith(
          _$AgentDownLineListResponseVoImpl value,
          $Res Function(_$AgentDownLineListResponseVoImpl) then) =
      __$$AgentDownLineListResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, List<AgentVo>? agentDownLineList});
}

/// @nodoc
class __$$AgentDownLineListResponseVoImplCopyWithImpl<$Res>
    extends _$AgentDownLineListResponseVoCopyWithImpl<$Res,
        _$AgentDownLineListResponseVoImpl>
    implements _$$AgentDownLineListResponseVoImplCopyWith<$Res> {
  __$$AgentDownLineListResponseVoImplCopyWithImpl(
      _$AgentDownLineListResponseVoImpl _value,
      $Res Function(_$AgentDownLineListResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? agentDownLineList = freezed,
  }) {
    return _then(_$AgentDownLineListResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      agentDownLineList: freezed == agentDownLineList
          ? _value.agentDownLineList
          : agentDownLineList // ignore: cast_nullable_to_non_nullable
              as List<AgentVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentDownLineListResponseVoImpl extends _AgentDownLineListResponseVo {
  _$AgentDownLineListResponseVoImpl(
      {this.code, this.message, this.agentDownLineList})
      : super._();

  factory _$AgentDownLineListResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AgentDownLineListResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<AgentVo>? agentDownLineList;

  @override
  String toString() {
    return 'AgentDownLineListResponseVo(code: $code, message: $message, agentDownLineList: $agentDownLineList)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentDownLineListResponseVoImplCopyWith<_$AgentDownLineListResponseVoImpl>
      get copyWith => __$$AgentDownLineListResponseVoImplCopyWithImpl<
          _$AgentDownLineListResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentDownLineListResponseVoImplToJson(
      this,
    );
  }
}

abstract class _AgentDownLineListResponseVo
    extends AgentDownLineListResponseVo {
  factory _AgentDownLineListResponseVo(
      {String? code,
      String? message,
      List<AgentVo>? agentDownLineList}) = _$AgentDownLineListResponseVoImpl;
  _AgentDownLineListResponseVo._() : super._();

  factory _AgentDownLineListResponseVo.fromJson(Map<String, dynamic> json) =
      _$AgentDownLineListResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<AgentVo>? get agentDownLineList;
  set agentDownLineList(List<AgentVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentDownLineListResponseVoImplCopyWith<_$AgentDownLineListResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
