// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_secure_tag_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentSecureTagVo _$AgentSecureTagVoFromJson(Map<String, dynamic> json) {
  return _AgentSecureTagVo.fromJson(json);
}

/// @nodoc
mixin _$AgentSecureTagVo {
  String? get status => throw _privateConstructorUsedError;
  set status(String? value) => throw _privateConstructorUsedError;
  String? get clientName => throw _privateConstructorUsedError;
  set clientName(String? value) => throw _privateConstructorUsedError;
  String? get clientId => throw _privateConstructorUsedError;
  set clientId(String? value) => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  set token(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentSecureTagVoCopyWith<AgentSecureTagVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentSecureTagVoCopyWith<$Res> {
  factory $AgentSecureTagVoCopyWith(
          AgentSecureTagVo value, $Res Function(AgentSecureTagVo) then) =
      _$AgentSecureTagVoCopyWithImpl<$Res, AgentSecureTagVo>;
  @useResult
  $Res call(
      {String? status, String? clientName, String? clientId, String? token});
}

/// @nodoc
class _$AgentSecureTagVoCopyWithImpl<$Res, $Val extends AgentSecureTagVo>
    implements $AgentSecureTagVoCopyWith<$Res> {
  _$AgentSecureTagVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? clientName = freezed,
    Object? clientId = freezed,
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      clientName: freezed == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentSecureTagVoImplCopyWith<$Res>
    implements $AgentSecureTagVoCopyWith<$Res> {
  factory _$$AgentSecureTagVoImplCopyWith(_$AgentSecureTagVoImpl value,
          $Res Function(_$AgentSecureTagVoImpl) then) =
      __$$AgentSecureTagVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? status, String? clientName, String? clientId, String? token});
}

/// @nodoc
class __$$AgentSecureTagVoImplCopyWithImpl<$Res>
    extends _$AgentSecureTagVoCopyWithImpl<$Res, _$AgentSecureTagVoImpl>
    implements _$$AgentSecureTagVoImplCopyWith<$Res> {
  __$$AgentSecureTagVoImplCopyWithImpl(_$AgentSecureTagVoImpl _value,
      $Res Function(_$AgentSecureTagVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? clientName = freezed,
    Object? clientId = freezed,
    Object? token = freezed,
  }) {
    return _then(_$AgentSecureTagVoImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      clientName: freezed == clientName
          ? _value.clientName
          : clientName // ignore: cast_nullable_to_non_nullable
              as String?,
      clientId: freezed == clientId
          ? _value.clientId
          : clientId // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentSecureTagVoImpl extends _AgentSecureTagVo {
  _$AgentSecureTagVoImpl(
      {this.status, this.clientName, this.clientId, this.token})
      : super._();

  factory _$AgentSecureTagVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgentSecureTagVoImplFromJson(json);

  @override
  String? status;
  @override
  String? clientName;
  @override
  String? clientId;
  @override
  String? token;

  @override
  String toString() {
    return 'AgentSecureTagVo(status: $status, clientName: $clientName, clientId: $clientId, token: $token)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentSecureTagVoImplCopyWith<_$AgentSecureTagVoImpl> get copyWith =>
      __$$AgentSecureTagVoImplCopyWithImpl<_$AgentSecureTagVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentSecureTagVoImplToJson(
      this,
    );
  }
}

abstract class _AgentSecureTagVo extends AgentSecureTagVo {
  factory _AgentSecureTagVo(
      {String? status,
      String? clientName,
      String? clientId,
      String? token}) = _$AgentSecureTagVoImpl;
  _AgentSecureTagVo._() : super._();

  factory _AgentSecureTagVo.fromJson(Map<String, dynamic> json) =
      _$AgentSecureTagVoImpl.fromJson;

  @override
  String? get status;
  set status(String? value);
  @override
  String? get clientName;
  set clientName(String? value);
  @override
  String? get clientId;
  set clientId(String? value);
  @override
  String? get token;
  set token(String? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentSecureTagVoImplCopyWith<_$AgentSecureTagVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
