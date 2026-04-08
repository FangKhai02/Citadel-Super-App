// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_validate_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ImageValidateResponseVo _$ImageValidateResponseVoFromJson(
    Map<String, dynamic> json) {
  return _ImageValidateResponseVo.fromJson(json);
}

/// @nodoc
mixin _$ImageValidateResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  bool? get valid => throw _privateConstructorUsedError;
  set valid(bool? value) => throw _privateConstructorUsedError;
  double? get confidence => throw _privateConstructorUsedError;
  set confidence(double? value) => throw _privateConstructorUsedError;
  double? get livenessScore => throw _privateConstructorUsedError;
  set livenessScore(double? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageValidateResponseVoCopyWith<ImageValidateResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageValidateResponseVoCopyWith<$Res> {
  factory $ImageValidateResponseVoCopyWith(ImageValidateResponseVo value,
          $Res Function(ImageValidateResponseVo) then) =
      _$ImageValidateResponseVoCopyWithImpl<$Res, ImageValidateResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      bool? valid,
      double? confidence,
      double? livenessScore});
}

/// @nodoc
class _$ImageValidateResponseVoCopyWithImpl<$Res,
        $Val extends ImageValidateResponseVo>
    implements $ImageValidateResponseVoCopyWith<$Res> {
  _$ImageValidateResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? valid = freezed,
    Object? confidence = freezed,
    Object? livenessScore = freezed,
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
      valid: freezed == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as bool?,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double?,
      livenessScore: freezed == livenessScore
          ? _value.livenessScore
          : livenessScore // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ImageValidateResponseVoImplCopyWith<$Res>
    implements $ImageValidateResponseVoCopyWith<$Res> {
  factory _$$ImageValidateResponseVoImplCopyWith(
          _$ImageValidateResponseVoImpl value,
          $Res Function(_$ImageValidateResponseVoImpl) then) =
      __$$ImageValidateResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      bool? valid,
      double? confidence,
      double? livenessScore});
}

/// @nodoc
class __$$ImageValidateResponseVoImplCopyWithImpl<$Res>
    extends _$ImageValidateResponseVoCopyWithImpl<$Res,
        _$ImageValidateResponseVoImpl>
    implements _$$ImageValidateResponseVoImplCopyWith<$Res> {
  __$$ImageValidateResponseVoImplCopyWithImpl(
      _$ImageValidateResponseVoImpl _value,
      $Res Function(_$ImageValidateResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? valid = freezed,
    Object? confidence = freezed,
    Object? livenessScore = freezed,
  }) {
    return _then(_$ImageValidateResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      valid: freezed == valid
          ? _value.valid
          : valid // ignore: cast_nullable_to_non_nullable
              as bool?,
      confidence: freezed == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double?,
      livenessScore: freezed == livenessScore
          ? _value.livenessScore
          : livenessScore // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ImageValidateResponseVoImpl extends _ImageValidateResponseVo {
  _$ImageValidateResponseVoImpl(
      {this.code,
      this.message,
      this.valid,
      this.confidence,
      this.livenessScore})
      : super._();

  factory _$ImageValidateResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageValidateResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  bool? valid;
  @override
  double? confidence;
  @override
  double? livenessScore;

  @override
  String toString() {
    return 'ImageValidateResponseVo(code: $code, message: $message, valid: $valid, confidence: $confidence, livenessScore: $livenessScore)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageValidateResponseVoImplCopyWith<_$ImageValidateResponseVoImpl>
      get copyWith => __$$ImageValidateResponseVoImplCopyWithImpl<
          _$ImageValidateResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageValidateResponseVoImplToJson(
      this,
    );
  }
}

abstract class _ImageValidateResponseVo extends ImageValidateResponseVo {
  factory _ImageValidateResponseVo(
      {String? code,
      String? message,
      bool? valid,
      double? confidence,
      double? livenessScore}) = _$ImageValidateResponseVoImpl;
  _ImageValidateResponseVo._() : super._();

  factory _ImageValidateResponseVo.fromJson(Map<String, dynamic> json) =
      _$ImageValidateResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  bool? get valid;
  set valid(bool? value);
  @override
  double? get confidence;
  set confidence(double? value);
  @override
  double? get livenessScore;
  set livenessScore(double? value);
  @override
  @JsonKey(ignore: true)
  _$$ImageValidateResponseVoImplCopyWith<_$ImageValidateResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
