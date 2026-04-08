// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_down_line_commission_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentDownLineCommissionResponseVo _$AgentDownLineCommissionResponseVoFromJson(
    Map<String, dynamic> json) {
  return _AgentDownLineCommissionResponseVo.fromJson(json);
}

/// @nodoc
mixin _$AgentDownLineCommissionResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<AgentDownLineCommissionVo>? get downLineCommissionList =>
      throw _privateConstructorUsedError;
  set downLineCommissionList(List<AgentDownLineCommissionVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentDownLineCommissionResponseVoCopyWith<AgentDownLineCommissionResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentDownLineCommissionResponseVoCopyWith<$Res> {
  factory $AgentDownLineCommissionResponseVoCopyWith(
          AgentDownLineCommissionResponseVo value,
          $Res Function(AgentDownLineCommissionResponseVo) then) =
      _$AgentDownLineCommissionResponseVoCopyWithImpl<$Res,
          AgentDownLineCommissionResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<AgentDownLineCommissionVo>? downLineCommissionList});
}

/// @nodoc
class _$AgentDownLineCommissionResponseVoCopyWithImpl<$Res,
        $Val extends AgentDownLineCommissionResponseVo>
    implements $AgentDownLineCommissionResponseVoCopyWith<$Res> {
  _$AgentDownLineCommissionResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? downLineCommissionList = freezed,
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
      downLineCommissionList: freezed == downLineCommissionList
          ? _value.downLineCommissionList
          : downLineCommissionList // ignore: cast_nullable_to_non_nullable
              as List<AgentDownLineCommissionVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentDownLineCommissionResponseVoImplCopyWith<$Res>
    implements $AgentDownLineCommissionResponseVoCopyWith<$Res> {
  factory _$$AgentDownLineCommissionResponseVoImplCopyWith(
          _$AgentDownLineCommissionResponseVoImpl value,
          $Res Function(_$AgentDownLineCommissionResponseVoImpl) then) =
      __$$AgentDownLineCommissionResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<AgentDownLineCommissionVo>? downLineCommissionList});
}

/// @nodoc
class __$$AgentDownLineCommissionResponseVoImplCopyWithImpl<$Res>
    extends _$AgentDownLineCommissionResponseVoCopyWithImpl<$Res,
        _$AgentDownLineCommissionResponseVoImpl>
    implements _$$AgentDownLineCommissionResponseVoImplCopyWith<$Res> {
  __$$AgentDownLineCommissionResponseVoImplCopyWithImpl(
      _$AgentDownLineCommissionResponseVoImpl _value,
      $Res Function(_$AgentDownLineCommissionResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? downLineCommissionList = freezed,
  }) {
    return _then(_$AgentDownLineCommissionResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      downLineCommissionList: freezed == downLineCommissionList
          ? _value.downLineCommissionList
          : downLineCommissionList // ignore: cast_nullable_to_non_nullable
              as List<AgentDownLineCommissionVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentDownLineCommissionResponseVoImpl
    extends _AgentDownLineCommissionResponseVo {
  _$AgentDownLineCommissionResponseVoImpl(
      {this.code, this.message, this.downLineCommissionList})
      : super._();

  factory _$AgentDownLineCommissionResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AgentDownLineCommissionResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<AgentDownLineCommissionVo>? downLineCommissionList;

  @override
  String toString() {
    return 'AgentDownLineCommissionResponseVo(code: $code, message: $message, downLineCommissionList: $downLineCommissionList)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentDownLineCommissionResponseVoImplCopyWith<
          _$AgentDownLineCommissionResponseVoImpl>
      get copyWith => __$$AgentDownLineCommissionResponseVoImplCopyWithImpl<
          _$AgentDownLineCommissionResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentDownLineCommissionResponseVoImplToJson(
      this,
    );
  }
}

abstract class _AgentDownLineCommissionResponseVo
    extends AgentDownLineCommissionResponseVo {
  factory _AgentDownLineCommissionResponseVo(
          {String? code,
          String? message,
          List<AgentDownLineCommissionVo>? downLineCommissionList}) =
      _$AgentDownLineCommissionResponseVoImpl;
  _AgentDownLineCommissionResponseVo._() : super._();

  factory _AgentDownLineCommissionResponseVo.fromJson(
          Map<String, dynamic> json) =
      _$AgentDownLineCommissionResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<AgentDownLineCommissionVo>? get downLineCommissionList;
  set downLineCommissionList(List<AgentDownLineCommissionVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentDownLineCommissionResponseVoImplCopyWith<
          _$AgentDownLineCommissionResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
