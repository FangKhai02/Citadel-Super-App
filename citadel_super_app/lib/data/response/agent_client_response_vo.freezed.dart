// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_client_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentClientResponseVo _$AgentClientResponseVoFromJson(
    Map<String, dynamic> json) {
  return _AgentClientResponseVo.fromJson(json);
}

/// @nodoc
mixin _$AgentClientResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  int? get totalClients => throw _privateConstructorUsedError;
  set totalClients(int? value) => throw _privateConstructorUsedError;
  int? get totalNewClients => throw _privateConstructorUsedError;
  set totalNewClients(int? value) => throw _privateConstructorUsedError;
  List<AgentClientVo>? get clients => throw _privateConstructorUsedError;
  set clients(List<AgentClientVo>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentClientResponseVoCopyWith<AgentClientResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentClientResponseVoCopyWith<$Res> {
  factory $AgentClientResponseVoCopyWith(AgentClientResponseVo value,
          $Res Function(AgentClientResponseVo) then) =
      _$AgentClientResponseVoCopyWithImpl<$Res, AgentClientResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      int? totalClients,
      int? totalNewClients,
      List<AgentClientVo>? clients});
}

/// @nodoc
class _$AgentClientResponseVoCopyWithImpl<$Res,
        $Val extends AgentClientResponseVo>
    implements $AgentClientResponseVoCopyWith<$Res> {
  _$AgentClientResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? totalClients = freezed,
    Object? totalNewClients = freezed,
    Object? clients = freezed,
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
      totalClients: freezed == totalClients
          ? _value.totalClients
          : totalClients // ignore: cast_nullable_to_non_nullable
              as int?,
      totalNewClients: freezed == totalNewClients
          ? _value.totalNewClients
          : totalNewClients // ignore: cast_nullable_to_non_nullable
              as int?,
      clients: freezed == clients
          ? _value.clients
          : clients // ignore: cast_nullable_to_non_nullable
              as List<AgentClientVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentClientResponseVoImplCopyWith<$Res>
    implements $AgentClientResponseVoCopyWith<$Res> {
  factory _$$AgentClientResponseVoImplCopyWith(
          _$AgentClientResponseVoImpl value,
          $Res Function(_$AgentClientResponseVoImpl) then) =
      __$$AgentClientResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      int? totalClients,
      int? totalNewClients,
      List<AgentClientVo>? clients});
}

/// @nodoc
class __$$AgentClientResponseVoImplCopyWithImpl<$Res>
    extends _$AgentClientResponseVoCopyWithImpl<$Res,
        _$AgentClientResponseVoImpl>
    implements _$$AgentClientResponseVoImplCopyWith<$Res> {
  __$$AgentClientResponseVoImplCopyWithImpl(_$AgentClientResponseVoImpl _value,
      $Res Function(_$AgentClientResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? totalClients = freezed,
    Object? totalNewClients = freezed,
    Object? clients = freezed,
  }) {
    return _then(_$AgentClientResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      totalClients: freezed == totalClients
          ? _value.totalClients
          : totalClients // ignore: cast_nullable_to_non_nullable
              as int?,
      totalNewClients: freezed == totalNewClients
          ? _value.totalNewClients
          : totalNewClients // ignore: cast_nullable_to_non_nullable
              as int?,
      clients: freezed == clients
          ? _value.clients
          : clients // ignore: cast_nullable_to_non_nullable
              as List<AgentClientVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentClientResponseVoImpl extends _AgentClientResponseVo {
  _$AgentClientResponseVoImpl(
      {this.code,
      this.message,
      this.totalClients,
      this.totalNewClients,
      this.clients})
      : super._();

  factory _$AgentClientResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgentClientResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  int? totalClients;
  @override
  int? totalNewClients;
  @override
  List<AgentClientVo>? clients;

  @override
  String toString() {
    return 'AgentClientResponseVo(code: $code, message: $message, totalClients: $totalClients, totalNewClients: $totalNewClients, clients: $clients)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentClientResponseVoImplCopyWith<_$AgentClientResponseVoImpl>
      get copyWith => __$$AgentClientResponseVoImplCopyWithImpl<
          _$AgentClientResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentClientResponseVoImplToJson(
      this,
    );
  }
}

abstract class _AgentClientResponseVo extends AgentClientResponseVo {
  factory _AgentClientResponseVo(
      {String? code,
      String? message,
      int? totalClients,
      int? totalNewClients,
      List<AgentClientVo>? clients}) = _$AgentClientResponseVoImpl;
  _AgentClientResponseVo._() : super._();

  factory _AgentClientResponseVo.fromJson(Map<String, dynamic> json) =
      _$AgentClientResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  int? get totalClients;
  set totalClients(int? value);
  @override
  int? get totalNewClients;
  set totalNewClients(int? value);
  @override
  List<AgentClientVo>? get clients;
  set clients(List<AgentClientVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentClientResponseVoImplCopyWith<_$AgentClientResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
