// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_profile_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentProfileResponseVo _$AgentProfileResponseVoFromJson(
    Map<String, dynamic> json) {
  return _AgentProfileResponseVo.fromJson(json);
}

/// @nodoc
mixin _$AgentProfileResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  AgentPersonalDetailsVo? get personalDetails =>
      throw _privateConstructorUsedError;
  set personalDetails(AgentPersonalDetailsVo? value) =>
      throw _privateConstructorUsedError;
  AgentVo? get agentDetails => throw _privateConstructorUsedError;
  set agentDetails(AgentVo? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentProfileResponseVoCopyWith<AgentProfileResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentProfileResponseVoCopyWith<$Res> {
  factory $AgentProfileResponseVoCopyWith(AgentProfileResponseVo value,
          $Res Function(AgentProfileResponseVo) then) =
      _$AgentProfileResponseVoCopyWithImpl<$Res, AgentProfileResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      AgentPersonalDetailsVo? personalDetails,
      AgentVo? agentDetails});

  $AgentPersonalDetailsVoCopyWith<$Res>? get personalDetails;
  $AgentVoCopyWith<$Res>? get agentDetails;
}

/// @nodoc
class _$AgentProfileResponseVoCopyWithImpl<$Res,
        $Val extends AgentProfileResponseVo>
    implements $AgentProfileResponseVoCopyWith<$Res> {
  _$AgentProfileResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? personalDetails = freezed,
    Object? agentDetails = freezed,
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
      personalDetails: freezed == personalDetails
          ? _value.personalDetails
          : personalDetails // ignore: cast_nullable_to_non_nullable
              as AgentPersonalDetailsVo?,
      agentDetails: freezed == agentDetails
          ? _value.agentDetails
          : agentDetails // ignore: cast_nullable_to_non_nullable
              as AgentVo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AgentPersonalDetailsVoCopyWith<$Res>? get personalDetails {
    if (_value.personalDetails == null) {
      return null;
    }

    return $AgentPersonalDetailsVoCopyWith<$Res>(_value.personalDetails!,
        (value) {
      return _then(_value.copyWith(personalDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AgentVoCopyWith<$Res>? get agentDetails {
    if (_value.agentDetails == null) {
      return null;
    }

    return $AgentVoCopyWith<$Res>(_value.agentDetails!, (value) {
      return _then(_value.copyWith(agentDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AgentProfileResponseVoImplCopyWith<$Res>
    implements $AgentProfileResponseVoCopyWith<$Res> {
  factory _$$AgentProfileResponseVoImplCopyWith(
          _$AgentProfileResponseVoImpl value,
          $Res Function(_$AgentProfileResponseVoImpl) then) =
      __$$AgentProfileResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      AgentPersonalDetailsVo? personalDetails,
      AgentVo? agentDetails});

  @override
  $AgentPersonalDetailsVoCopyWith<$Res>? get personalDetails;
  @override
  $AgentVoCopyWith<$Res>? get agentDetails;
}

/// @nodoc
class __$$AgentProfileResponseVoImplCopyWithImpl<$Res>
    extends _$AgentProfileResponseVoCopyWithImpl<$Res,
        _$AgentProfileResponseVoImpl>
    implements _$$AgentProfileResponseVoImplCopyWith<$Res> {
  __$$AgentProfileResponseVoImplCopyWithImpl(
      _$AgentProfileResponseVoImpl _value,
      $Res Function(_$AgentProfileResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? personalDetails = freezed,
    Object? agentDetails = freezed,
  }) {
    return _then(_$AgentProfileResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      personalDetails: freezed == personalDetails
          ? _value.personalDetails
          : personalDetails // ignore: cast_nullable_to_non_nullable
              as AgentPersonalDetailsVo?,
      agentDetails: freezed == agentDetails
          ? _value.agentDetails
          : agentDetails // ignore: cast_nullable_to_non_nullable
              as AgentVo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentProfileResponseVoImpl extends _AgentProfileResponseVo {
  _$AgentProfileResponseVoImpl(
      {this.code, this.message, this.personalDetails, this.agentDetails})
      : super._();

  factory _$AgentProfileResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgentProfileResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  AgentPersonalDetailsVo? personalDetails;
  @override
  AgentVo? agentDetails;

  @override
  String toString() {
    return 'AgentProfileResponseVo(code: $code, message: $message, personalDetails: $personalDetails, agentDetails: $agentDetails)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentProfileResponseVoImplCopyWith<_$AgentProfileResponseVoImpl>
      get copyWith => __$$AgentProfileResponseVoImplCopyWithImpl<
          _$AgentProfileResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentProfileResponseVoImplToJson(
      this,
    );
  }
}

abstract class _AgentProfileResponseVo extends AgentProfileResponseVo {
  factory _AgentProfileResponseVo(
      {String? code,
      String? message,
      AgentPersonalDetailsVo? personalDetails,
      AgentVo? agentDetails}) = _$AgentProfileResponseVoImpl;
  _AgentProfileResponseVo._() : super._();

  factory _AgentProfileResponseVo.fromJson(Map<String, dynamic> json) =
      _$AgentProfileResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  AgentPersonalDetailsVo? get personalDetails;
  set personalDetails(AgentPersonalDetailsVo? value);
  @override
  AgentVo? get agentDetails;
  set agentDetails(AgentVo? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentProfileResponseVoImplCopyWith<_$AgentProfileResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
