// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_validate_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ImageValidateRequestVo _$ImageValidateRequestVoFromJson(
    Map<String, dynamic> json) {
  return _ImageValidateRequestVo.fromJson(json);
}

/// @nodoc
mixin _$ImageValidateRequestVo {
  String? get idPhoto => throw _privateConstructorUsedError;
  set idPhoto(String? value) => throw _privateConstructorUsedError;
  String? get selfie => throw _privateConstructorUsedError;
  set selfie(String? value) => throw _privateConstructorUsedError;
  String? get idNumber => throw _privateConstructorUsedError;
  set idNumber(String? value) => throw _privateConstructorUsedError;
  double? get confidence => throw _privateConstructorUsedError;
  set confidence(double? value) => throw _privateConstructorUsedError;
  double? get livenessScore => throw _privateConstructorUsedError;
  set livenessScore(double? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImageValidateRequestVoCopyWith<ImageValidateRequestVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImageValidateRequestVoCopyWith<$Res> {
  factory $ImageValidateRequestVoCopyWith(ImageValidateRequestVo value,
          $Res Function(ImageValidateRequestVo) then) =
      _$ImageValidateRequestVoCopyWithImpl<$Res, ImageValidateRequestVo>;
  @useResult
  $Res call(
      {String? idPhoto,
      String? selfie,
      String? idNumber,
      double? confidence,
      double? livenessScore});
}

/// @nodoc
class _$ImageValidateRequestVoCopyWithImpl<$Res,
        $Val extends ImageValidateRequestVo>
    implements $ImageValidateRequestVoCopyWith<$Res> {
  _$ImageValidateRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idPhoto = freezed,
    Object? selfie = freezed,
    Object? idNumber = freezed,
    Object? confidence = freezed,
    Object? livenessScore = freezed,
  }) {
    return _then(_value.copyWith(
      idPhoto: freezed == idPhoto
          ? _value.idPhoto
          : idPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      selfie: freezed == selfie
          ? _value.selfie
          : selfie // ignore: cast_nullable_to_non_nullable
              as String?,
      idNumber: freezed == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$ImageValidateRequestVoImplCopyWith<$Res>
    implements $ImageValidateRequestVoCopyWith<$Res> {
  factory _$$ImageValidateRequestVoImplCopyWith(
          _$ImageValidateRequestVoImpl value,
          $Res Function(_$ImageValidateRequestVoImpl) then) =
      __$$ImageValidateRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? idPhoto,
      String? selfie,
      String? idNumber,
      double? confidence,
      double? livenessScore});
}

/// @nodoc
class __$$ImageValidateRequestVoImplCopyWithImpl<$Res>
    extends _$ImageValidateRequestVoCopyWithImpl<$Res,
        _$ImageValidateRequestVoImpl>
    implements _$$ImageValidateRequestVoImplCopyWith<$Res> {
  __$$ImageValidateRequestVoImplCopyWithImpl(
      _$ImageValidateRequestVoImpl _value,
      $Res Function(_$ImageValidateRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? idPhoto = freezed,
    Object? selfie = freezed,
    Object? idNumber = freezed,
    Object? confidence = freezed,
    Object? livenessScore = freezed,
  }) {
    return _then(_$ImageValidateRequestVoImpl(
      idPhoto: freezed == idPhoto
          ? _value.idPhoto
          : idPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      selfie: freezed == selfie
          ? _value.selfie
          : selfie // ignore: cast_nullable_to_non_nullable
              as String?,
      idNumber: freezed == idNumber
          ? _value.idNumber
          : idNumber // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$ImageValidateRequestVoImpl extends _ImageValidateRequestVo {
  _$ImageValidateRequestVoImpl(
      {this.idPhoto,
      this.selfie,
      this.idNumber,
      this.confidence,
      this.livenessScore})
      : super._();

  factory _$ImageValidateRequestVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ImageValidateRequestVoImplFromJson(json);

  @override
  String? idPhoto;
  @override
  String? selfie;
  @override
  String? idNumber;
  @override
  double? confidence;
  @override
  double? livenessScore;

  @override
  String toString() {
    return 'ImageValidateRequestVo(idPhoto: $idPhoto, selfie: $selfie, idNumber: $idNumber, confidence: $confidence, livenessScore: $livenessScore)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ImageValidateRequestVoImplCopyWith<_$ImageValidateRequestVoImpl>
      get copyWith => __$$ImageValidateRequestVoImplCopyWithImpl<
          _$ImageValidateRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ImageValidateRequestVoImplToJson(
      this,
    );
  }
}

abstract class _ImageValidateRequestVo extends ImageValidateRequestVo {
  factory _ImageValidateRequestVo(
      {String? idPhoto,
      String? selfie,
      String? idNumber,
      double? confidence,
      double? livenessScore}) = _$ImageValidateRequestVoImpl;
  _ImageValidateRequestVo._() : super._();

  factory _ImageValidateRequestVo.fromJson(Map<String, dynamic> json) =
      _$ImageValidateRequestVoImpl.fromJson;

  @override
  String? get idPhoto;
  set idPhoto(String? value);
  @override
  String? get selfie;
  set selfie(String? value);
  @override
  String? get idNumber;
  set idNumber(String? value);
  @override
  double? get confidence;
  set confidence(double? value);
  @override
  double? get livenessScore;
  set livenessScore(double? value);
  @override
  @JsonKey(ignore: true)
  _$$ImageValidateRequestVoImplCopyWith<_$ImageValidateRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
