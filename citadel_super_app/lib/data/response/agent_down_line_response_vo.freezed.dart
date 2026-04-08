// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_down_line_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentDownLineResponseVo _$AgentDownLineResponseVoFromJson(
    Map<String, dynamic> json) {
  return _AgentDownLineResponseVo.fromJson(json);
}

/// @nodoc
mixin _$AgentDownLineResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  int? get totalDownLine => throw _privateConstructorUsedError;
  set totalDownLine(int? value) => throw _privateConstructorUsedError;
  int? get newRecruitThisMonth => throw _privateConstructorUsedError;
  set newRecruitThisMonth(int? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentDownLineResponseVoCopyWith<AgentDownLineResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentDownLineResponseVoCopyWith<$Res> {
  factory $AgentDownLineResponseVoCopyWith(AgentDownLineResponseVo value,
          $Res Function(AgentDownLineResponseVo) then) =
      _$AgentDownLineResponseVoCopyWithImpl<$Res, AgentDownLineResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      int? totalDownLine,
      int? newRecruitThisMonth});
}

/// @nodoc
class _$AgentDownLineResponseVoCopyWithImpl<$Res,
        $Val extends AgentDownLineResponseVo>
    implements $AgentDownLineResponseVoCopyWith<$Res> {
  _$AgentDownLineResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? totalDownLine = freezed,
    Object? newRecruitThisMonth = freezed,
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
      totalDownLine: freezed == totalDownLine
          ? _value.totalDownLine
          : totalDownLine // ignore: cast_nullable_to_non_nullable
              as int?,
      newRecruitThisMonth: freezed == newRecruitThisMonth
          ? _value.newRecruitThisMonth
          : newRecruitThisMonth // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentDownLineResponseVoImplCopyWith<$Res>
    implements $AgentDownLineResponseVoCopyWith<$Res> {
  factory _$$AgentDownLineResponseVoImplCopyWith(
          _$AgentDownLineResponseVoImpl value,
          $Res Function(_$AgentDownLineResponseVoImpl) then) =
      __$$AgentDownLineResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      int? totalDownLine,
      int? newRecruitThisMonth});
}

/// @nodoc
class __$$AgentDownLineResponseVoImplCopyWithImpl<$Res>
    extends _$AgentDownLineResponseVoCopyWithImpl<$Res,
        _$AgentDownLineResponseVoImpl>
    implements _$$AgentDownLineResponseVoImplCopyWith<$Res> {
  __$$AgentDownLineResponseVoImplCopyWithImpl(
      _$AgentDownLineResponseVoImpl _value,
      $Res Function(_$AgentDownLineResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? totalDownLine = freezed,
    Object? newRecruitThisMonth = freezed,
  }) {
    return _then(_$AgentDownLineResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      totalDownLine: freezed == totalDownLine
          ? _value.totalDownLine
          : totalDownLine // ignore: cast_nullable_to_non_nullable
              as int?,
      newRecruitThisMonth: freezed == newRecruitThisMonth
          ? _value.newRecruitThisMonth
          : newRecruitThisMonth // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentDownLineResponseVoImpl extends _AgentDownLineResponseVo {
  _$AgentDownLineResponseVoImpl(
      {this.code, this.message, this.totalDownLine, this.newRecruitThisMonth})
      : super._();

  factory _$AgentDownLineResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgentDownLineResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  int? totalDownLine;
  @override
  int? newRecruitThisMonth;

  @override
  String toString() {
    return 'AgentDownLineResponseVo(code: $code, message: $message, totalDownLine: $totalDownLine, newRecruitThisMonth: $newRecruitThisMonth)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentDownLineResponseVoImplCopyWith<_$AgentDownLineResponseVoImpl>
      get copyWith => __$$AgentDownLineResponseVoImplCopyWithImpl<
          _$AgentDownLineResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentDownLineResponseVoImplToJson(
      this,
    );
  }
}

abstract class _AgentDownLineResponseVo extends AgentDownLineResponseVo {
  factory _AgentDownLineResponseVo(
      {String? code,
      String? message,
      int? totalDownLine,
      int? newRecruitThisMonth}) = _$AgentDownLineResponseVoImpl;
  _AgentDownLineResponseVo._() : super._();

  factory _AgentDownLineResponseVo.fromJson(Map<String, dynamic> json) =
      _$AgentDownLineResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  int? get totalDownLine;
  set totalDownLine(int? value);
  @override
  int? get newRecruitThisMonth;
  set newRecruitThisMonth(int? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentDownLineResponseVoImplCopyWith<_$AgentDownLineResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
