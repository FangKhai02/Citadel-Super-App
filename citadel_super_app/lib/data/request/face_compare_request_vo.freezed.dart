// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'face_compare_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FaceCompareRequestVo _$FaceCompareRequestVoFromJson(Map<String, dynamic> json) {
  return _FaceCompareRequestVo.fromJson(json);
}

/// @nodoc
mixin _$FaceCompareRequestVo {
  String? get documentImage => throw _privateConstructorUsedError;
  set documentImage(String? value) =>
      throw _privateConstructorUsedError; // Base64 encoded ID document image
  String? get selfieImage =>
      throw _privateConstructorUsedError; // Base64 encoded ID document image
  set selfieImage(String? value) =>
      throw _privateConstructorUsedError; // Base64 encoded selfie image
  String? get documentType =>
      throw _privateConstructorUsedError; // Base64 encoded selfie image
  set documentType(String? value) =>
      throw _privateConstructorUsedError; // MYKAD, PASSPORT, IKAD, MYTENTERA, MYPR, MYKID
  String? get fullName =>
      throw _privateConstructorUsedError; // MYKAD, PASSPORT, IKAD, MYTENTERA, MYPR, MYKID
  set fullName(String? value) => throw _privateConstructorUsedError;
  String? get documentNumber => throw _privateConstructorUsedError;
  set documentNumber(String? value) => throw _privateConstructorUsedError;
  String? get dateOfBirth => throw _privateConstructorUsedError;
  set dateOfBirth(String? value) =>
      throw _privateConstructorUsedError; // Format: yyyy-MM-dd
  String? get gender =>
      throw _privateConstructorUsedError; // Format: yyyy-MM-dd
  set gender(String? value) =>
      throw _privateConstructorUsedError; // MALE, FEMALE, OTHER
  String? get nationality =>
      throw _privateConstructorUsedError; // MALE, FEMALE, OTHER
  set nationality(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FaceCompareRequestVoCopyWith<FaceCompareRequestVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaceCompareRequestVoCopyWith<$Res> {
  factory $FaceCompareRequestVoCopyWith(FaceCompareRequestVo value,
          $Res Function(FaceCompareRequestVo) then) =
      _$FaceCompareRequestVoCopyWithImpl<$Res, FaceCompareRequestVo>;
  @useResult
  $Res call(
      {String? documentImage,
      String? selfieImage,
      String? documentType,
      String? fullName,
      String? documentNumber,
      String? dateOfBirth,
      String? gender,
      String? nationality});
}

/// @nodoc
class _$FaceCompareRequestVoCopyWithImpl<$Res,
        $Val extends FaceCompareRequestVo>
    implements $FaceCompareRequestVoCopyWith<$Res> {
  _$FaceCompareRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documentImage = freezed,
    Object? selfieImage = freezed,
    Object? documentType = freezed,
    Object? fullName = freezed,
    Object? documentNumber = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
    Object? nationality = freezed,
  }) {
    return _then(_value.copyWith(
      documentImage: freezed == documentImage
          ? _value.documentImage
          : documentImage // ignore: cast_nullable_to_non_nullable
              as String?,
      selfieImage: freezed == selfieImage
          ? _value.selfieImage
          : selfieImage // ignore: cast_nullable_to_non_nullable
              as String?,
      documentType: freezed == documentType
          ? _value.documentType
          : documentType // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      documentNumber: freezed == documentNumber
          ? _value.documentNumber
          : documentNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FaceCompareRequestVoImplCopyWith<$Res>
    implements $FaceCompareRequestVoCopyWith<$Res> {
  factory _$$FaceCompareRequestVoImplCopyWith(_$FaceCompareRequestVoImpl value,
          $Res Function(_$FaceCompareRequestVoImpl) then) =
      __$$FaceCompareRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? documentImage,
      String? selfieImage,
      String? documentType,
      String? fullName,
      String? documentNumber,
      String? dateOfBirth,
      String? gender,
      String? nationality});
}

/// @nodoc
class __$$FaceCompareRequestVoImplCopyWithImpl<$Res>
    extends _$FaceCompareRequestVoCopyWithImpl<$Res, _$FaceCompareRequestVoImpl>
    implements _$$FaceCompareRequestVoImplCopyWith<$Res> {
  __$$FaceCompareRequestVoImplCopyWithImpl(_$FaceCompareRequestVoImpl _value,
      $Res Function(_$FaceCompareRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? documentImage = freezed,
    Object? selfieImage = freezed,
    Object? documentType = freezed,
    Object? fullName = freezed,
    Object? documentNumber = freezed,
    Object? dateOfBirth = freezed,
    Object? gender = freezed,
    Object? nationality = freezed,
  }) {
    return _then(_$FaceCompareRequestVoImpl(
      documentImage: freezed == documentImage
          ? _value.documentImage
          : documentImage // ignore: cast_nullable_to_non_nullable
              as String?,
      selfieImage: freezed == selfieImage
          ? _value.selfieImage
          : selfieImage // ignore: cast_nullable_to_non_nullable
              as String?,
      documentType: freezed == documentType
          ? _value.documentType
          : documentType // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      documentNumber: freezed == documentNumber
          ? _value.documentNumber
          : documentNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FaceCompareRequestVoImpl extends _FaceCompareRequestVo {
  _$FaceCompareRequestVoImpl(
      {this.documentImage,
      this.selfieImage,
      this.documentType,
      this.fullName,
      this.documentNumber,
      this.dateOfBirth,
      this.gender,
      this.nationality})
      : super._();

  factory _$FaceCompareRequestVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FaceCompareRequestVoImplFromJson(json);

  @override
  String? documentImage;
// Base64 encoded ID document image
  @override
  String? selfieImage;
// Base64 encoded selfie image
  @override
  String? documentType;
// MYKAD, PASSPORT, IKAD, MYTENTERA, MYPR, MYKID
  @override
  String? fullName;
  @override
  String? documentNumber;
  @override
  String? dateOfBirth;
// Format: yyyy-MM-dd
  @override
  String? gender;
// MALE, FEMALE, OTHER
  @override
  String? nationality;

  @override
  String toString() {
    return 'FaceCompareRequestVo(documentImage: $documentImage, selfieImage: $selfieImage, documentType: $documentType, fullName: $fullName, documentNumber: $documentNumber, dateOfBirth: $dateOfBirth, gender: $gender, nationality: $nationality)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FaceCompareRequestVoImplCopyWith<_$FaceCompareRequestVoImpl>
      get copyWith =>
          __$$FaceCompareRequestVoImplCopyWithImpl<_$FaceCompareRequestVoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FaceCompareRequestVoImplToJson(
      this,
    );
  }
}

abstract class _FaceCompareRequestVo extends FaceCompareRequestVo {
  factory _FaceCompareRequestVo(
      {String? documentImage,
      String? selfieImage,
      String? documentType,
      String? fullName,
      String? documentNumber,
      String? dateOfBirth,
      String? gender,
      String? nationality}) = _$FaceCompareRequestVoImpl;
  _FaceCompareRequestVo._() : super._();

  factory _FaceCompareRequestVo.fromJson(Map<String, dynamic> json) =
      _$FaceCompareRequestVoImpl.fromJson;

  @override
  String? get documentImage;
  set documentImage(String? value);
  @override // Base64 encoded ID document image
  String? get selfieImage; // Base64 encoded ID document image
  set selfieImage(String? value);
  @override // Base64 encoded selfie image
  String? get documentType; // Base64 encoded selfie image
  set documentType(String? value);
  @override // MYKAD, PASSPORT, IKAD, MYTENTERA, MYPR, MYKID
  String? get fullName; // MYKAD, PASSPORT, IKAD, MYTENTERA, MYPR, MYKID
  set fullName(String? value);
  @override
  String? get documentNumber;
  set documentNumber(String? value);
  @override
  String? get dateOfBirth;
  set dateOfBirth(String? value);
  @override // Format: yyyy-MM-dd
  String? get gender; // Format: yyyy-MM-dd
  set gender(String? value);
  @override // MALE, FEMALE, OTHER
  String? get nationality; // MALE, FEMALE, OTHER
  set nationality(String? value);
  @override
  @JsonKey(ignore: true)
  _$$FaceCompareRequestVoImplCopyWith<_$FaceCompareRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
