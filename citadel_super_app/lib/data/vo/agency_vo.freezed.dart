// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agency_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgencyVo _$AgencyVoFromJson(Map<String, dynamic> json) {
  return _AgencyVo.fromJson(json);
}

/// @nodoc
mixin _$AgencyVo {
  String? get agencyCode => throw _privateConstructorUsedError;
  set agencyCode(String? value) => throw _privateConstructorUsedError;
  String? get agencyId => throw _privateConstructorUsedError;
  set agencyId(String? value) => throw _privateConstructorUsedError;
  String? get agencyName => throw _privateConstructorUsedError;
  set agencyName(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgencyVoCopyWith<AgencyVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgencyVoCopyWith<$Res> {
  factory $AgencyVoCopyWith(AgencyVo value, $Res Function(AgencyVo) then) =
      _$AgencyVoCopyWithImpl<$Res, AgencyVo>;
  @useResult
  $Res call({String? agencyCode, String? agencyId, String? agencyName});
}

/// @nodoc
class _$AgencyVoCopyWithImpl<$Res, $Val extends AgencyVo>
    implements $AgencyVoCopyWith<$Res> {
  _$AgencyVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? agencyCode = freezed,
    Object? agencyId = freezed,
    Object? agencyName = freezed,
  }) {
    return _then(_value.copyWith(
      agencyCode: freezed == agencyCode
          ? _value.agencyCode
          : agencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      agencyId: freezed == agencyId
          ? _value.agencyId
          : agencyId // ignore: cast_nullable_to_non_nullable
              as String?,
      agencyName: freezed == agencyName
          ? _value.agencyName
          : agencyName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgencyVoImplCopyWith<$Res>
    implements $AgencyVoCopyWith<$Res> {
  factory _$$AgencyVoImplCopyWith(
          _$AgencyVoImpl value, $Res Function(_$AgencyVoImpl) then) =
      __$$AgencyVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? agencyCode, String? agencyId, String? agencyName});
}

/// @nodoc
class __$$AgencyVoImplCopyWithImpl<$Res>
    extends _$AgencyVoCopyWithImpl<$Res, _$AgencyVoImpl>
    implements _$$AgencyVoImplCopyWith<$Res> {
  __$$AgencyVoImplCopyWithImpl(
      _$AgencyVoImpl _value, $Res Function(_$AgencyVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? agencyCode = freezed,
    Object? agencyId = freezed,
    Object? agencyName = freezed,
  }) {
    return _then(_$AgencyVoImpl(
      agencyCode: freezed == agencyCode
          ? _value.agencyCode
          : agencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      agencyId: freezed == agencyId
          ? _value.agencyId
          : agencyId // ignore: cast_nullable_to_non_nullable
              as String?,
      agencyName: freezed == agencyName
          ? _value.agencyName
          : agencyName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgencyVoImpl extends _AgencyVo {
  _$AgencyVoImpl({this.agencyCode, this.agencyId, this.agencyName}) : super._();

  factory _$AgencyVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgencyVoImplFromJson(json);

  @override
  String? agencyCode;
  @override
  String? agencyId;
  @override
  String? agencyName;

  @override
  String toString() {
    return 'AgencyVo(agencyCode: $agencyCode, agencyId: $agencyId, agencyName: $agencyName)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgencyVoImplCopyWith<_$AgencyVoImpl> get copyWith =>
      __$$AgencyVoImplCopyWithImpl<_$AgencyVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgencyVoImplToJson(
      this,
    );
  }
}

abstract class _AgencyVo extends AgencyVo {
  factory _AgencyVo(
      {String? agencyCode,
      String? agencyId,
      String? agencyName}) = _$AgencyVoImpl;
  _AgencyVo._() : super._();

  factory _AgencyVo.fromJson(Map<String, dynamic> json) =
      _$AgencyVoImpl.fromJson;

  @override
  String? get agencyCode;
  set agencyCode(String? value);
  @override
  String? get agencyId;
  set agencyId(String? value);
  @override
  String? get agencyName;
  set agencyName(String? value);
  @override
  @JsonKey(ignore: true)
  _$$AgencyVoImplCopyWith<_$AgencyVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
