// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_secure_tag_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClientSecureTagVo _$ClientSecureTagVoFromJson(Map<String, dynamic> json) {
  return _ClientSecureTagVo.fromJson(json);
}

/// @nodoc
mixin _$ClientSecureTagVo {
  String? get agentName => throw _privateConstructorUsedError;
  set agentName(String? value) => throw _privateConstructorUsedError;
  String? get agentId => throw _privateConstructorUsedError;
  set agentId(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientSecureTagVoCopyWith<ClientSecureTagVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientSecureTagVoCopyWith<$Res> {
  factory $ClientSecureTagVoCopyWith(
          ClientSecureTagVo value, $Res Function(ClientSecureTagVo) then) =
      _$ClientSecureTagVoCopyWithImpl<$Res, ClientSecureTagVo>;
  @useResult
  $Res call({String? agentName, String? agentId});
}

/// @nodoc
class _$ClientSecureTagVoCopyWithImpl<$Res, $Val extends ClientSecureTagVo>
    implements $ClientSecureTagVoCopyWith<$Res> {
  _$ClientSecureTagVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? agentName = freezed,
    Object? agentId = freezed,
  }) {
    return _then(_value.copyWith(
      agentName: freezed == agentName
          ? _value.agentName
          : agentName // ignore: cast_nullable_to_non_nullable
              as String?,
      agentId: freezed == agentId
          ? _value.agentId
          : agentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientSecureTagVoImplCopyWith<$Res>
    implements $ClientSecureTagVoCopyWith<$Res> {
  factory _$$ClientSecureTagVoImplCopyWith(_$ClientSecureTagVoImpl value,
          $Res Function(_$ClientSecureTagVoImpl) then) =
      __$$ClientSecureTagVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? agentName, String? agentId});
}

/// @nodoc
class __$$ClientSecureTagVoImplCopyWithImpl<$Res>
    extends _$ClientSecureTagVoCopyWithImpl<$Res, _$ClientSecureTagVoImpl>
    implements _$$ClientSecureTagVoImplCopyWith<$Res> {
  __$$ClientSecureTagVoImplCopyWithImpl(_$ClientSecureTagVoImpl _value,
      $Res Function(_$ClientSecureTagVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? agentName = freezed,
    Object? agentId = freezed,
  }) {
    return _then(_$ClientSecureTagVoImpl(
      agentName: freezed == agentName
          ? _value.agentName
          : agentName // ignore: cast_nullable_to_non_nullable
              as String?,
      agentId: freezed == agentId
          ? _value.agentId
          : agentId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientSecureTagVoImpl extends _ClientSecureTagVo {
  _$ClientSecureTagVoImpl({this.agentName, this.agentId}) : super._();

  factory _$ClientSecureTagVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientSecureTagVoImplFromJson(json);

  @override
  String? agentName;
  @override
  String? agentId;

  @override
  String toString() {
    return 'ClientSecureTagVo(agentName: $agentName, agentId: $agentId)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientSecureTagVoImplCopyWith<_$ClientSecureTagVoImpl> get copyWith =>
      __$$ClientSecureTagVoImplCopyWithImpl<_$ClientSecureTagVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientSecureTagVoImplToJson(
      this,
    );
  }
}

abstract class _ClientSecureTagVo extends ClientSecureTagVo {
  factory _ClientSecureTagVo({String? agentName, String? agentId}) =
      _$ClientSecureTagVoImpl;
  _ClientSecureTagVo._() : super._();

  factory _ClientSecureTagVo.fromJson(Map<String, dynamic> json) =
      _$ClientSecureTagVoImpl.fromJson;

  @override
  String? get agentName;
  set agentName(String? value);
  @override
  String? get agentId;
  set agentId(String? value);
  @override
  @JsonKey(ignore: true)
  _$$ClientSecureTagVoImplCopyWith<_$ClientSecureTagVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
