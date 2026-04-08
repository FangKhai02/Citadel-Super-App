// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'beneficiary_guardian_relationship_update_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BeneficiaryGuardianRelationshipUpdateRequestVo
    _$BeneficiaryGuardianRelationshipUpdateRequestVoFromJson(
        Map<String, dynamic> json) {
  return _BeneficiaryGuardianRelationshipUpdateRequestVo.fromJson(json);
}

/// @nodoc
mixin _$BeneficiaryGuardianRelationshipUpdateRequestVo {
  int? get guardianId => throw _privateConstructorUsedError;
  set guardianId(int? value) => throw _privateConstructorUsedError;
  int? get beneficiaryId => throw _privateConstructorUsedError;
  set beneficiaryId(int? value) => throw _privateConstructorUsedError;
  String? get relationshipToGuardian => throw _privateConstructorUsedError;
  set relationshipToGuardian(String? value) =>
      throw _privateConstructorUsedError;
  String? get relationshipToBeneficiary => throw _privateConstructorUsedError;
  set relationshipToBeneficiary(String? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BeneficiaryGuardianRelationshipUpdateRequestVoCopyWith<
          BeneficiaryGuardianRelationshipUpdateRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BeneficiaryGuardianRelationshipUpdateRequestVoCopyWith<$Res> {
  factory $BeneficiaryGuardianRelationshipUpdateRequestVoCopyWith(
          BeneficiaryGuardianRelationshipUpdateRequestVo value,
          $Res Function(BeneficiaryGuardianRelationshipUpdateRequestVo) then) =
      _$BeneficiaryGuardianRelationshipUpdateRequestVoCopyWithImpl<$Res,
          BeneficiaryGuardianRelationshipUpdateRequestVo>;
  @useResult
  $Res call(
      {int? guardianId,
      int? beneficiaryId,
      String? relationshipToGuardian,
      String? relationshipToBeneficiary});
}

/// @nodoc
class _$BeneficiaryGuardianRelationshipUpdateRequestVoCopyWithImpl<$Res,
        $Val extends BeneficiaryGuardianRelationshipUpdateRequestVo>
    implements $BeneficiaryGuardianRelationshipUpdateRequestVoCopyWith<$Res> {
  _$BeneficiaryGuardianRelationshipUpdateRequestVoCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? guardianId = freezed,
    Object? beneficiaryId = freezed,
    Object? relationshipToGuardian = freezed,
    Object? relationshipToBeneficiary = freezed,
  }) {
    return _then(_value.copyWith(
      guardianId: freezed == guardianId
          ? _value.guardianId
          : guardianId // ignore: cast_nullable_to_non_nullable
              as int?,
      beneficiaryId: freezed == beneficiaryId
          ? _value.beneficiaryId
          : beneficiaryId // ignore: cast_nullable_to_non_nullable
              as int?,
      relationshipToGuardian: freezed == relationshipToGuardian
          ? _value.relationshipToGuardian
          : relationshipToGuardian // ignore: cast_nullable_to_non_nullable
              as String?,
      relationshipToBeneficiary: freezed == relationshipToBeneficiary
          ? _value.relationshipToBeneficiary
          : relationshipToBeneficiary // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BeneficiaryGuardianRelationshipUpdateRequestVoImplCopyWith<
        $Res>
    implements $BeneficiaryGuardianRelationshipUpdateRequestVoCopyWith<$Res> {
  factory _$$BeneficiaryGuardianRelationshipUpdateRequestVoImplCopyWith(
          _$BeneficiaryGuardianRelationshipUpdateRequestVoImpl value,
          $Res Function(_$BeneficiaryGuardianRelationshipUpdateRequestVoImpl)
              then) =
      __$$BeneficiaryGuardianRelationshipUpdateRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? guardianId,
      int? beneficiaryId,
      String? relationshipToGuardian,
      String? relationshipToBeneficiary});
}

/// @nodoc
class __$$BeneficiaryGuardianRelationshipUpdateRequestVoImplCopyWithImpl<$Res>
    extends _$BeneficiaryGuardianRelationshipUpdateRequestVoCopyWithImpl<$Res,
        _$BeneficiaryGuardianRelationshipUpdateRequestVoImpl>
    implements
        _$$BeneficiaryGuardianRelationshipUpdateRequestVoImplCopyWith<$Res> {
  __$$BeneficiaryGuardianRelationshipUpdateRequestVoImplCopyWithImpl(
      _$BeneficiaryGuardianRelationshipUpdateRequestVoImpl _value,
      $Res Function(_$BeneficiaryGuardianRelationshipUpdateRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? guardianId = freezed,
    Object? beneficiaryId = freezed,
    Object? relationshipToGuardian = freezed,
    Object? relationshipToBeneficiary = freezed,
  }) {
    return _then(_$BeneficiaryGuardianRelationshipUpdateRequestVoImpl(
      guardianId: freezed == guardianId
          ? _value.guardianId
          : guardianId // ignore: cast_nullable_to_non_nullable
              as int?,
      beneficiaryId: freezed == beneficiaryId
          ? _value.beneficiaryId
          : beneficiaryId // ignore: cast_nullable_to_non_nullable
              as int?,
      relationshipToGuardian: freezed == relationshipToGuardian
          ? _value.relationshipToGuardian
          : relationshipToGuardian // ignore: cast_nullable_to_non_nullable
              as String?,
      relationshipToBeneficiary: freezed == relationshipToBeneficiary
          ? _value.relationshipToBeneficiary
          : relationshipToBeneficiary // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BeneficiaryGuardianRelationshipUpdateRequestVoImpl
    extends _BeneficiaryGuardianRelationshipUpdateRequestVo {
  _$BeneficiaryGuardianRelationshipUpdateRequestVoImpl(
      {this.guardianId,
      this.beneficiaryId,
      this.relationshipToGuardian,
      this.relationshipToBeneficiary})
      : super._();

  factory _$BeneficiaryGuardianRelationshipUpdateRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$BeneficiaryGuardianRelationshipUpdateRequestVoImplFromJson(json);

  @override
  int? guardianId;
  @override
  int? beneficiaryId;
  @override
  String? relationshipToGuardian;
  @override
  String? relationshipToBeneficiary;

  @override
  String toString() {
    return 'BeneficiaryGuardianRelationshipUpdateRequestVo(guardianId: $guardianId, beneficiaryId: $beneficiaryId, relationshipToGuardian: $relationshipToGuardian, relationshipToBeneficiary: $relationshipToBeneficiary)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BeneficiaryGuardianRelationshipUpdateRequestVoImplCopyWith<
          _$BeneficiaryGuardianRelationshipUpdateRequestVoImpl>
      get copyWith =>
          __$$BeneficiaryGuardianRelationshipUpdateRequestVoImplCopyWithImpl<
                  _$BeneficiaryGuardianRelationshipUpdateRequestVoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BeneficiaryGuardianRelationshipUpdateRequestVoImplToJson(
      this,
    );
  }
}

abstract class _BeneficiaryGuardianRelationshipUpdateRequestVo
    extends BeneficiaryGuardianRelationshipUpdateRequestVo {
  factory _BeneficiaryGuardianRelationshipUpdateRequestVo(
          {int? guardianId,
          int? beneficiaryId,
          String? relationshipToGuardian,
          String? relationshipToBeneficiary}) =
      _$BeneficiaryGuardianRelationshipUpdateRequestVoImpl;
  _BeneficiaryGuardianRelationshipUpdateRequestVo._() : super._();

  factory _BeneficiaryGuardianRelationshipUpdateRequestVo.fromJson(
          Map<String, dynamic> json) =
      _$BeneficiaryGuardianRelationshipUpdateRequestVoImpl.fromJson;

  @override
  int? get guardianId;
  set guardianId(int? value);
  @override
  int? get beneficiaryId;
  set beneficiaryId(int? value);
  @override
  String? get relationshipToGuardian;
  set relationshipToGuardian(String? value);
  @override
  String? get relationshipToBeneficiary;
  set relationshipToBeneficiary(String? value);
  @override
  @JsonKey(ignore: true)
  _$$BeneficiaryGuardianRelationshipUpdateRequestVoImplCopyWith<
          _$BeneficiaryGuardianRelationshipUpdateRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
