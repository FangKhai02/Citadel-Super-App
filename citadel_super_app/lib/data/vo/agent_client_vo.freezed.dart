// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_client_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentClientVo _$AgentClientVoFromJson(Map<String, dynamic> json) {
  return _AgentClientVo.fromJson(json);
}

/// @nodoc
mixin _$AgentClientVo {
  String? get clientType => throw _privateConstructorUsedError;
  set clientType(String? value) => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  set name(String? value) => throw _privateConstructorUsedError;
  String? get clientId => throw _privateConstructorUsedError;
  set clientId(String? value) => throw _privateConstructorUsedError;
  int? get joinedDate => throw _privateConstructorUsedError;
  set joinedDate(int? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentClientVoCopyWith<AgentClientVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentClientVoCopyWith<$Res> {
  factory $AgentClientVoCopyWith(
          AgentClientVo value, $Res Function(AgentClientVo) then) =
      _$AgentClientVoCopyWithImpl<$Res, AgentClientVo>;
  @useResult
  $Res call(
      {String? clientType, String? name, String? clientId, int? joinedDate});
}

/// @nodoc
class _$AgentClientVoCopyWithImpl<$Res, $Val extends AgentClientVo>
    implements $AgentClientVoCopyWith<$Res> {
  _$AgentClientVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientType = freezed,
    Object? name = freezed,
    Object? clientId = freezed,
    Object? joinedDate = freezed,
  }) {
    return _then(_value.copyWith(
      clientType: freezed == clientType
          ? _value.clientType
          : clientType // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      joinedDate: freezed == joinedDate
          ? _value.joinedDate
          : joinedDate // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentClientVoImplCopyWith<$Res>
    implements $AgentClientVoCopyWith<$Res> {
  factory _$$AgentClientVoImplCopyWith(
          _$AgentClientVoImpl value, $Res Function(_$AgentClientVoImpl) then) =
      __$$AgentClientVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? clientType, String? name, String? clientId, int? joinedDate});
}

/// @nodoc
class __$$AgentClientVoImplCopyWithImpl<$Res>
    extends _$AgentClientVoCopyWithImpl<$Res, _$AgentClientVoImpl>
    implements _$$AgentClientVoImplCopyWith<$Res> {
  __$$AgentClientVoImplCopyWithImpl(
      _$AgentClientVoImpl _value, $Res Function(_$AgentClientVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientType = freezed,
    Object? name = freezed,
    Object? clientId = freezed,
    Object? joinedDate = freezed,
  }) {
    return _then(_$AgentClientVoImpl(
      clientType: freezed == clientType
          ? _value.clientType
          : clientType // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      joinedDate: freezed == joinedDate
          ? _value.joinedDate
          : joinedDate // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentClientVoImpl extends _AgentClientVo {
  _$AgentClientVoImpl(
      {this.clientType, this.name, this.clientId, this.joinedDate})
      : super._();

  factory _$AgentClientVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgentClientVoImplFromJson(json);

  @override
  String? clientType;
  @override
  String? name;
  @override
  String? clientId;
  @override
  int? joinedDate;

  @override
  String toString() {
    return 'AgentClientVo(clientType: $clientType, name: $name, clientId: $clientId, joinedDate: $joinedDate)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentClientVoImplCopyWith<_$AgentClientVoImpl> get copyWith =>
      __$$AgentClientVoImplCopyWithImpl<_$AgentClientVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentClientVoImplToJson(
      this,
    );
  }
}

abstract class _AgentClientVo extends AgentClientVo {
  factory _AgentClientVo(
      {String? clientType,
      String? name,
      String? clientId,
      int? joinedDate}) = _$AgentClientVoImpl;
  _AgentClientVo._() : super._();

  factory _AgentClientVo.fromJson(Map<String, dynamic> json) =
      _$AgentClientVoImpl.fromJson;

  @override
  String? get clientType;
  set clientType(String? value);
  @override
  String? get name;
  set name(String? value);
  @override
  String? get clientId;
  set clientId(String? value);
  @override
  int? get joinedDate;
  set joinedDate(int? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentClientVoImplCopyWith<_$AgentClientVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
