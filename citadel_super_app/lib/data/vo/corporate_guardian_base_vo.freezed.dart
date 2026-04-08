// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_guardian_base_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateGuardianBaseVo _$CorporateGuardianBaseVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateGuardianBaseVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateGuardianBaseVo {
  int? get corporateGuardianId => throw _privateConstructorUsedError;
  set corporateGuardianId(int? value) => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  set fullName(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateGuardianBaseVoCopyWith<CorporateGuardianBaseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateGuardianBaseVoCopyWith<$Res> {
  factory $CorporateGuardianBaseVoCopyWith(CorporateGuardianBaseVo value,
          $Res Function(CorporateGuardianBaseVo) then) =
      _$CorporateGuardianBaseVoCopyWithImpl<$Res, CorporateGuardianBaseVo>;
  @useResult
  $Res call({int? corporateGuardianId, String? fullName});
}

/// @nodoc
class _$CorporateGuardianBaseVoCopyWithImpl<$Res,
        $Val extends CorporateGuardianBaseVo>
    implements $CorporateGuardianBaseVoCopyWith<$Res> {
  _$CorporateGuardianBaseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corporateGuardianId = freezed,
    Object? fullName = freezed,
  }) {
    return _then(_value.copyWith(
      corporateGuardianId: freezed == corporateGuardianId
          ? _value.corporateGuardianId
          : corporateGuardianId // ignore: cast_nullable_to_non_nullable
              as int?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorporateGuardianBaseVoImplCopyWith<$Res>
    implements $CorporateGuardianBaseVoCopyWith<$Res> {
  factory _$$CorporateGuardianBaseVoImplCopyWith(
          _$CorporateGuardianBaseVoImpl value,
          $Res Function(_$CorporateGuardianBaseVoImpl) then) =
      __$$CorporateGuardianBaseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? corporateGuardianId, String? fullName});
}

/// @nodoc
class __$$CorporateGuardianBaseVoImplCopyWithImpl<$Res>
    extends _$CorporateGuardianBaseVoCopyWithImpl<$Res,
        _$CorporateGuardianBaseVoImpl>
    implements _$$CorporateGuardianBaseVoImplCopyWith<$Res> {
  __$$CorporateGuardianBaseVoImplCopyWithImpl(
      _$CorporateGuardianBaseVoImpl _value,
      $Res Function(_$CorporateGuardianBaseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corporateGuardianId = freezed,
    Object? fullName = freezed,
  }) {
    return _then(_$CorporateGuardianBaseVoImpl(
      corporateGuardianId: freezed == corporateGuardianId
          ? _value.corporateGuardianId
          : corporateGuardianId // ignore: cast_nullable_to_non_nullable
              as int?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateGuardianBaseVoImpl extends _CorporateGuardianBaseVo {
  _$CorporateGuardianBaseVoImpl({this.corporateGuardianId, this.fullName})
      : super._();

  factory _$CorporateGuardianBaseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CorporateGuardianBaseVoImplFromJson(json);

  @override
  int? corporateGuardianId;
  @override
  String? fullName;

  @override
  String toString() {
    return 'CorporateGuardianBaseVo(corporateGuardianId: $corporateGuardianId, fullName: $fullName)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateGuardianBaseVoImplCopyWith<_$CorporateGuardianBaseVoImpl>
      get copyWith => __$$CorporateGuardianBaseVoImplCopyWithImpl<
          _$CorporateGuardianBaseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateGuardianBaseVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateGuardianBaseVo extends CorporateGuardianBaseVo {
  factory _CorporateGuardianBaseVo(
      {int? corporateGuardianId,
      String? fullName}) = _$CorporateGuardianBaseVoImpl;
  _CorporateGuardianBaseVo._() : super._();

  factory _CorporateGuardianBaseVo.fromJson(Map<String, dynamic> json) =
      _$CorporateGuardianBaseVoImpl.fromJson;

  @override
  int? get corporateGuardianId;
  set corporateGuardianId(int? value);
  @override
  String? get fullName;
  set fullName(String? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateGuardianBaseVoImplCopyWith<_$CorporateGuardianBaseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
