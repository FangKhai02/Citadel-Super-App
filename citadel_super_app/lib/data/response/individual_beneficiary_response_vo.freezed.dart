// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'individual_beneficiary_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IndividualBeneficiaryResponseVo _$IndividualBeneficiaryResponseVoFromJson(
    Map<String, dynamic> json) {
  return _IndividualBeneficiaryResponseVo.fromJson(json);
}

/// @nodoc
mixin _$IndividualBeneficiaryResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  bool? get isUnderAge => throw _privateConstructorUsedError;
  set isUnderAge(bool? value) => throw _privateConstructorUsedError;
  GuardianVo? get guardianVo => throw _privateConstructorUsedError;
  set guardianVo(GuardianVo? value) => throw _privateConstructorUsedError;
  int? get individualBeneficiaryId => throw _privateConstructorUsedError;
  set individualBeneficiaryId(int? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IndividualBeneficiaryResponseVoCopyWith<IndividualBeneficiaryResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IndividualBeneficiaryResponseVoCopyWith<$Res> {
  factory $IndividualBeneficiaryResponseVoCopyWith(
          IndividualBeneficiaryResponseVo value,
          $Res Function(IndividualBeneficiaryResponseVo) then) =
      _$IndividualBeneficiaryResponseVoCopyWithImpl<$Res,
          IndividualBeneficiaryResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      bool? isUnderAge,
      GuardianVo? guardianVo,
      int? individualBeneficiaryId});

  $GuardianVoCopyWith<$Res>? get guardianVo;
}

/// @nodoc
class _$IndividualBeneficiaryResponseVoCopyWithImpl<$Res,
        $Val extends IndividualBeneficiaryResponseVo>
    implements $IndividualBeneficiaryResponseVoCopyWith<$Res> {
  _$IndividualBeneficiaryResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? isUnderAge = freezed,
    Object? guardianVo = freezed,
    Object? individualBeneficiaryId = freezed,
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
      isUnderAge: freezed == isUnderAge
          ? _value.isUnderAge
          : isUnderAge // ignore: cast_nullable_to_non_nullable
              as bool?,
      guardianVo: freezed == guardianVo
          ? _value.guardianVo
          : guardianVo // ignore: cast_nullable_to_non_nullable
              as GuardianVo?,
      individualBeneficiaryId: freezed == individualBeneficiaryId
          ? _value.individualBeneficiaryId
          : individualBeneficiaryId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GuardianVoCopyWith<$Res>? get guardianVo {
    if (_value.guardianVo == null) {
      return null;
    }

    return $GuardianVoCopyWith<$Res>(_value.guardianVo!, (value) {
      return _then(_value.copyWith(guardianVo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IndividualBeneficiaryResponseVoImplCopyWith<$Res>
    implements $IndividualBeneficiaryResponseVoCopyWith<$Res> {
  factory _$$IndividualBeneficiaryResponseVoImplCopyWith(
          _$IndividualBeneficiaryResponseVoImpl value,
          $Res Function(_$IndividualBeneficiaryResponseVoImpl) then) =
      __$$IndividualBeneficiaryResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      bool? isUnderAge,
      GuardianVo? guardianVo,
      int? individualBeneficiaryId});

  @override
  $GuardianVoCopyWith<$Res>? get guardianVo;
}

/// @nodoc
class __$$IndividualBeneficiaryResponseVoImplCopyWithImpl<$Res>
    extends _$IndividualBeneficiaryResponseVoCopyWithImpl<$Res,
        _$IndividualBeneficiaryResponseVoImpl>
    implements _$$IndividualBeneficiaryResponseVoImplCopyWith<$Res> {
  __$$IndividualBeneficiaryResponseVoImplCopyWithImpl(
      _$IndividualBeneficiaryResponseVoImpl _value,
      $Res Function(_$IndividualBeneficiaryResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? isUnderAge = freezed,
    Object? guardianVo = freezed,
    Object? individualBeneficiaryId = freezed,
  }) {
    return _then(_$IndividualBeneficiaryResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      isUnderAge: freezed == isUnderAge
          ? _value.isUnderAge
          : isUnderAge // ignore: cast_nullable_to_non_nullable
              as bool?,
      guardianVo: freezed == guardianVo
          ? _value.guardianVo
          : guardianVo // ignore: cast_nullable_to_non_nullable
              as GuardianVo?,
      individualBeneficiaryId: freezed == individualBeneficiaryId
          ? _value.individualBeneficiaryId
          : individualBeneficiaryId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IndividualBeneficiaryResponseVoImpl
    extends _IndividualBeneficiaryResponseVo {
  _$IndividualBeneficiaryResponseVoImpl(
      {this.code,
      this.message,
      this.isUnderAge,
      this.guardianVo,
      this.individualBeneficiaryId})
      : super._();

  factory _$IndividualBeneficiaryResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$IndividualBeneficiaryResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  bool? isUnderAge;
  @override
  GuardianVo? guardianVo;
  @override
  int? individualBeneficiaryId;

  @override
  String toString() {
    return 'IndividualBeneficiaryResponseVo(code: $code, message: $message, isUnderAge: $isUnderAge, guardianVo: $guardianVo, individualBeneficiaryId: $individualBeneficiaryId)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IndividualBeneficiaryResponseVoImplCopyWith<
          _$IndividualBeneficiaryResponseVoImpl>
      get copyWith => __$$IndividualBeneficiaryResponseVoImplCopyWithImpl<
          _$IndividualBeneficiaryResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IndividualBeneficiaryResponseVoImplToJson(
      this,
    );
  }
}

abstract class _IndividualBeneficiaryResponseVo
    extends IndividualBeneficiaryResponseVo {
  factory _IndividualBeneficiaryResponseVo(
      {String? code,
      String? message,
      bool? isUnderAge,
      GuardianVo? guardianVo,
      int? individualBeneficiaryId}) = _$IndividualBeneficiaryResponseVoImpl;
  _IndividualBeneficiaryResponseVo._() : super._();

  factory _IndividualBeneficiaryResponseVo.fromJson(Map<String, dynamic> json) =
      _$IndividualBeneficiaryResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  bool? get isUnderAge;
  set isUnderAge(bool? value);
  @override
  GuardianVo? get guardianVo;
  set guardianVo(GuardianVo? value);
  @override
  int? get individualBeneficiaryId;
  set individualBeneficiaryId(int? value);
  @override
  @JsonKey(ignore: true)
  _$$IndividualBeneficiaryResponseVoImplCopyWith<
          _$IndividualBeneficiaryResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
