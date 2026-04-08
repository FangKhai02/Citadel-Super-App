// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_earning_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentEarningResponseVo _$AgentEarningResponseVoFromJson(
    Map<String, dynamic> json) {
  return _AgentEarningResponseVo.fromJson(json);
}

/// @nodoc
mixin _$AgentEarningResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<AgentEarningVo>? get earningDetails =>
      throw _privateConstructorUsedError;
  set earningDetails(List<AgentEarningVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentEarningResponseVoCopyWith<AgentEarningResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentEarningResponseVoCopyWith<$Res> {
  factory $AgentEarningResponseVoCopyWith(AgentEarningResponseVo value,
          $Res Function(AgentEarningResponseVo) then) =
      _$AgentEarningResponseVoCopyWithImpl<$Res, AgentEarningResponseVo>;
  @useResult
  $Res call(
      {String? code, String? message, List<AgentEarningVo>? earningDetails});
}

/// @nodoc
class _$AgentEarningResponseVoCopyWithImpl<$Res,
        $Val extends AgentEarningResponseVo>
    implements $AgentEarningResponseVoCopyWith<$Res> {
  _$AgentEarningResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? earningDetails = freezed,
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
      earningDetails: freezed == earningDetails
          ? _value.earningDetails
          : earningDetails // ignore: cast_nullable_to_non_nullable
              as List<AgentEarningVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentEarningResponseVoImplCopyWith<$Res>
    implements $AgentEarningResponseVoCopyWith<$Res> {
  factory _$$AgentEarningResponseVoImplCopyWith(
          _$AgentEarningResponseVoImpl value,
          $Res Function(_$AgentEarningResponseVoImpl) then) =
      __$$AgentEarningResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code, String? message, List<AgentEarningVo>? earningDetails});
}

/// @nodoc
class __$$AgentEarningResponseVoImplCopyWithImpl<$Res>
    extends _$AgentEarningResponseVoCopyWithImpl<$Res,
        _$AgentEarningResponseVoImpl>
    implements _$$AgentEarningResponseVoImplCopyWith<$Res> {
  __$$AgentEarningResponseVoImplCopyWithImpl(
      _$AgentEarningResponseVoImpl _value,
      $Res Function(_$AgentEarningResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? earningDetails = freezed,
  }) {
    return _then(_$AgentEarningResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      earningDetails: freezed == earningDetails
          ? _value.earningDetails
          : earningDetails // ignore: cast_nullable_to_non_nullable
              as List<AgentEarningVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentEarningResponseVoImpl extends _AgentEarningResponseVo {
  _$AgentEarningResponseVoImpl({this.code, this.message, this.earningDetails})
      : super._();

  factory _$AgentEarningResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgentEarningResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<AgentEarningVo>? earningDetails;

  @override
  String toString() {
    return 'AgentEarningResponseVo(code: $code, message: $message, earningDetails: $earningDetails)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentEarningResponseVoImplCopyWith<_$AgentEarningResponseVoImpl>
      get copyWith => __$$AgentEarningResponseVoImplCopyWithImpl<
          _$AgentEarningResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentEarningResponseVoImplToJson(
      this,
    );
  }
}

abstract class _AgentEarningResponseVo extends AgentEarningResponseVo {
  factory _AgentEarningResponseVo(
      {String? code,
      String? message,
      List<AgentEarningVo>? earningDetails}) = _$AgentEarningResponseVoImpl;
  _AgentEarningResponseVo._() : super._();

  factory _AgentEarningResponseVo.fromJson(Map<String, dynamic> json) =
      _$AgentEarningResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<AgentEarningVo>? get earningDetails;
  set earningDetails(List<AgentEarningVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentEarningResponseVoImplCopyWith<_$AgentEarningResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
