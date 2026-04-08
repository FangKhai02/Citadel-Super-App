// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agency_agent_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgencyAgentVo _$AgencyAgentVoFromJson(Map<String, dynamic> json) {
  return _AgencyAgentVo.fromJson(json);
}

/// @nodoc
mixin _$AgencyAgentVo {
  String? get agentId => throw _privateConstructorUsedError;
  set agentId(String? value) => throw _privateConstructorUsedError;
  String? get agentName => throw _privateConstructorUsedError;
  set agentName(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgencyAgentVoCopyWith<AgencyAgentVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgencyAgentVoCopyWith<$Res> {
  factory $AgencyAgentVoCopyWith(
          AgencyAgentVo value, $Res Function(AgencyAgentVo) then) =
      _$AgencyAgentVoCopyWithImpl<$Res, AgencyAgentVo>;
  @useResult
  $Res call({String? agentId, String? agentName});
}

/// @nodoc
class _$AgencyAgentVoCopyWithImpl<$Res, $Val extends AgencyAgentVo>
    implements $AgencyAgentVoCopyWith<$Res> {
  _$AgencyAgentVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? agentId = freezed,
    Object? agentName = freezed,
  }) {
    return _then(_value.copyWith(
      agentId: freezed == agentId
          ? _value.agentId
          : agentId // ignore: cast_nullable_to_non_nullable
              as String?,
      agentName: freezed == agentName
          ? _value.agentName
          : agentName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgencyAgentVoImplCopyWith<$Res>
    implements $AgencyAgentVoCopyWith<$Res> {
  factory _$$AgencyAgentVoImplCopyWith(
          _$AgencyAgentVoImpl value, $Res Function(_$AgencyAgentVoImpl) then) =
      __$$AgencyAgentVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? agentId, String? agentName});
}

/// @nodoc
class __$$AgencyAgentVoImplCopyWithImpl<$Res>
    extends _$AgencyAgentVoCopyWithImpl<$Res, _$AgencyAgentVoImpl>
    implements _$$AgencyAgentVoImplCopyWith<$Res> {
  __$$AgencyAgentVoImplCopyWithImpl(
      _$AgencyAgentVoImpl _value, $Res Function(_$AgencyAgentVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? agentId = freezed,
    Object? agentName = freezed,
  }) {
    return _then(_$AgencyAgentVoImpl(
      agentId: freezed == agentId
          ? _value.agentId
          : agentId // ignore: cast_nullable_to_non_nullable
              as String?,
      agentName: freezed == agentName
          ? _value.agentName
          : agentName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgencyAgentVoImpl extends _AgencyAgentVo {
  _$AgencyAgentVoImpl({this.agentId, this.agentName}) : super._();

  factory _$AgencyAgentVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgencyAgentVoImplFromJson(json);

  @override
  String? agentId;
  @override
  String? agentName;

  @override
  String toString() {
    return 'AgencyAgentVo(agentId: $agentId, agentName: $agentName)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgencyAgentVoImplCopyWith<_$AgencyAgentVoImpl> get copyWith =>
      __$$AgencyAgentVoImplCopyWithImpl<_$AgencyAgentVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgencyAgentVoImplToJson(
      this,
    );
  }
}

abstract class _AgencyAgentVo extends AgencyAgentVo {
  factory _AgencyAgentVo({String? agentId, String? agentName}) =
      _$AgencyAgentVoImpl;
  _AgencyAgentVo._() : super._();

  factory _AgencyAgentVo.fromJson(Map<String, dynamic> json) =
      _$AgencyAgentVoImpl.fromJson;

  @override
  String? get agentId;
  set agentId(String? value);
  @override
  String? get agentName;
  set agentName(String? value);
  @override
  @JsonKey(ignore: true)
  _$$AgencyAgentVoImplCopyWith<_$AgencyAgentVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
