// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'face_compare_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FaceCompareResponseVo _$FaceCompareResponseVoFromJson(
    Map<String, dynamic> json) {
  return _FaceCompareResponseVo.fromJson(json);
}

/// @nodoc
mixin _$FaceCompareResponseVo {
  bool? get verified => throw _privateConstructorUsedError;
  set verified(bool? value) =>
      throw _privateConstructorUsedError; // true if face match passed (score <= 0.45)
  double? get score =>
      throw _privateConstructorUsedError; // true if face match passed (score <= 0.45)
  set score(double? value) =>
      throw _privateConstructorUsedError; // Euclidean distance (lower = more similar)
  String? get message =>
      throw _privateConstructorUsedError; // Euclidean distance (lower = more similar)
  set message(String? value) =>
      throw _privateConstructorUsedError; // Human-readable message
  bool? get degraded =>
      throw _privateConstructorUsedError; // Human-readable message
  set degraded(bool? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FaceCompareResponseVoCopyWith<FaceCompareResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaceCompareResponseVoCopyWith<$Res> {
  factory $FaceCompareResponseVoCopyWith(FaceCompareResponseVo value,
          $Res Function(FaceCompareResponseVo) then) =
      _$FaceCompareResponseVoCopyWithImpl<$Res, FaceCompareResponseVo>;
  @useResult
  $Res call({bool? verified, double? score, String? message, bool? degraded});
}

/// @nodoc
class _$FaceCompareResponseVoCopyWithImpl<$Res,
        $Val extends FaceCompareResponseVo>
    implements $FaceCompareResponseVoCopyWith<$Res> {
  _$FaceCompareResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verified = freezed,
    Object? score = freezed,
    Object? message = freezed,
    Object? degraded = freezed,
  }) {
    return _then(_value.copyWith(
      verified: freezed == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      degraded: freezed == degraded
          ? _value.degraded
          : degraded // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FaceCompareResponseVoImplCopyWith<$Res>
    implements $FaceCompareResponseVoCopyWith<$Res> {
  factory _$$FaceCompareResponseVoImplCopyWith(
          _$FaceCompareResponseVoImpl value,
          $Res Function(_$FaceCompareResponseVoImpl) then) =
      __$$FaceCompareResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? verified, double? score, String? message, bool? degraded});
}

/// @nodoc
class __$$FaceCompareResponseVoImplCopyWithImpl<$Res>
    extends _$FaceCompareResponseVoCopyWithImpl<$Res,
        _$FaceCompareResponseVoImpl>
    implements _$$FaceCompareResponseVoImplCopyWith<$Res> {
  __$$FaceCompareResponseVoImplCopyWithImpl(_$FaceCompareResponseVoImpl _value,
      $Res Function(_$FaceCompareResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verified = freezed,
    Object? score = freezed,
    Object? message = freezed,
    Object? degraded = freezed,
  }) {
    return _then(_$FaceCompareResponseVoImpl(
      verified: freezed == verified
          ? _value.verified
          : verified // ignore: cast_nullable_to_non_nullable
              as bool?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      degraded: freezed == degraded
          ? _value.degraded
          : degraded // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FaceCompareResponseVoImpl extends _FaceCompareResponseVo {
  _$FaceCompareResponseVoImpl(
      {this.verified, this.score, this.message, this.degraded})
      : super._();

  factory _$FaceCompareResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FaceCompareResponseVoImplFromJson(json);

  @override
  bool? verified;
// true if face match passed (score <= 0.45)
  @override
  double? score;
// Euclidean distance (lower = more similar)
  @override
  String? message;
// Human-readable message
  @override
  bool? degraded;

  @override
  String toString() {
    return 'FaceCompareResponseVo(verified: $verified, score: $score, message: $message, degraded: $degraded)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FaceCompareResponseVoImplCopyWith<_$FaceCompareResponseVoImpl>
      get copyWith => __$$FaceCompareResponseVoImplCopyWithImpl<
          _$FaceCompareResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FaceCompareResponseVoImplToJson(
      this,
    );
  }
}

abstract class _FaceCompareResponseVo extends FaceCompareResponseVo {
  factory _FaceCompareResponseVo(
      {bool? verified,
      double? score,
      String? message,
      bool? degraded}) = _$FaceCompareResponseVoImpl;
  _FaceCompareResponseVo._() : super._();

  factory _FaceCompareResponseVo.fromJson(Map<String, dynamic> json) =
      _$FaceCompareResponseVoImpl.fromJson;

  @override
  bool? get verified;
  set verified(bool? value);
  @override // true if face match passed (score <= 0.45)
  double? get score; // true if face match passed (score <= 0.45)
  set score(double? value);
  @override // Euclidean distance (lower = more similar)
  String? get message; // Euclidean distance (lower = more similar)
  set message(String? value);
  @override // Human-readable message
  bool? get degraded; // Human-readable message
  set degraded(bool? value);
  @override
  @JsonKey(ignore: true)
  _$$FaceCompareResponseVoImplCopyWith<_$FaceCompareResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
