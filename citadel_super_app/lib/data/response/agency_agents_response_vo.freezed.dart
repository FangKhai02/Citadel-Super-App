// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agency_agents_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgencyAgentsResponseVo _$AgencyAgentsResponseVoFromJson(
    Map<String, dynamic> json) {
  return _AgencyAgentsResponseVo.fromJson(json);
}

/// @nodoc
mixin _$AgencyAgentsResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<AgencyAgentVo>? get agentsList => throw _privateConstructorUsedError;
  set agentsList(List<AgencyAgentVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgencyAgentsResponseVoCopyWith<AgencyAgentsResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgencyAgentsResponseVoCopyWith<$Res> {
  factory $AgencyAgentsResponseVoCopyWith(AgencyAgentsResponseVo value,
          $Res Function(AgencyAgentsResponseVo) then) =
      _$AgencyAgentsResponseVoCopyWithImpl<$Res, AgencyAgentsResponseVo>;
  @useResult
  $Res call({String? code, String? message, List<AgencyAgentVo>? agentsList});
}

/// @nodoc
class _$AgencyAgentsResponseVoCopyWithImpl<$Res,
        $Val extends AgencyAgentsResponseVo>
    implements $AgencyAgentsResponseVoCopyWith<$Res> {
  _$AgencyAgentsResponseVoCopyWithImpl(this._value, this._then);

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
              as List<AgencyAgentVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgencyAgentsResponseVoImplCopyWith<$Res>
    implements $AgencyAgentsResponseVoCopyWith<$Res> {
  factory _$$AgencyAgentsResponseVoImplCopyWith(
          _$AgencyAgentsResponseVoImpl value,
          $Res Function(_$AgencyAgentsResponseVoImpl) then) =
      __$$AgencyAgentsResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, List<AgencyAgentVo>? agentsList});
}

/// @nodoc
class __$$AgencyAgentsResponseVoImplCopyWithImpl<$Res>
    extends _$AgencyAgentsResponseVoCopyWithImpl<$Res,
        _$AgencyAgentsResponseVoImpl>
    implements _$$AgencyAgentsResponseVoImplCopyWith<$Res> {
  __$$AgencyAgentsResponseVoImplCopyWithImpl(
      _$AgencyAgentsResponseVoImpl _value,
      $Res Function(_$AgencyAgentsResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? agentsList = freezed,
  }) {
    return _then(_$AgencyAgentsResponseVoImpl(
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
              as List<AgencyAgentVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgencyAgentsResponseVoImpl extends _AgencyAgentsResponseVo {
  _$AgencyAgentsResponseVoImpl({this.code, this.message, this.agentsList})
      : super._();

  factory _$AgencyAgentsResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgencyAgentsResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<AgencyAgentVo>? agentsList;

  @override
  String toString() {
    return 'AgencyAgentsResponseVo(code: $code, message: $message, agentsList: $agentsList)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgencyAgentsResponseVoImplCopyWith<_$AgencyAgentsResponseVoImpl>
      get copyWith => __$$AgencyAgentsResponseVoImplCopyWithImpl<
          _$AgencyAgentsResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgencyAgentsResponseVoImplToJson(
      this,
    );
  }
}

abstract class _AgencyAgentsResponseVo extends AgencyAgentsResponseVo {
  factory _AgencyAgentsResponseVo(
      {String? code,
      String? message,
      List<AgencyAgentVo>? agentsList}) = _$AgencyAgentsResponseVoImpl;
  _AgencyAgentsResponseVo._() : super._();

  factory _AgencyAgentsResponseVo.fromJson(Map<String, dynamic> json) =
      _$AgencyAgentsResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<AgencyAgentVo>? get agentsList;
  set agentsList(List<AgencyAgentVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$AgencyAgentsResponseVoImplCopyWith<_$AgencyAgentsResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
