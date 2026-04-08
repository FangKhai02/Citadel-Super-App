// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_guardian_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateGuardianResponseVo _$CorporateGuardianResponseVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateGuardianResponseVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateGuardianResponseVo {
  CorporateGuardianBaseVo? get corporateGuardian =>
      throw _privateConstructorUsedError;
  set corporateGuardian(CorporateGuardianBaseVo? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateGuardianResponseVoCopyWith<CorporateGuardianResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateGuardianResponseVoCopyWith<$Res> {
  factory $CorporateGuardianResponseVoCopyWith(
          CorporateGuardianResponseVo value,
          $Res Function(CorporateGuardianResponseVo) then) =
      _$CorporateGuardianResponseVoCopyWithImpl<$Res,
          CorporateGuardianResponseVo>;
  @useResult
  $Res call({CorporateGuardianBaseVo? corporateGuardian});

  $CorporateGuardianBaseVoCopyWith<$Res>? get corporateGuardian;
}

/// @nodoc
class _$CorporateGuardianResponseVoCopyWithImpl<$Res,
        $Val extends CorporateGuardianResponseVo>
    implements $CorporateGuardianResponseVoCopyWith<$Res> {
  _$CorporateGuardianResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corporateGuardian = freezed,
  }) {
    return _then(_value.copyWith(
      corporateGuardian: freezed == corporateGuardian
          ? _value.corporateGuardian
          : corporateGuardian // ignore: cast_nullable_to_non_nullable
              as CorporateGuardianBaseVo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CorporateGuardianBaseVoCopyWith<$Res>? get corporateGuardian {
    if (_value.corporateGuardian == null) {
      return null;
    }

    return $CorporateGuardianBaseVoCopyWith<$Res>(_value.corporateGuardian!,
        (value) {
      return _then(_value.copyWith(corporateGuardian: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CorporateGuardianResponseVoImplCopyWith<$Res>
    implements $CorporateGuardianResponseVoCopyWith<$Res> {
  factory _$$CorporateGuardianResponseVoImplCopyWith(
          _$CorporateGuardianResponseVoImpl value,
          $Res Function(_$CorporateGuardianResponseVoImpl) then) =
      __$$CorporateGuardianResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CorporateGuardianBaseVo? corporateGuardian});

  @override
  $CorporateGuardianBaseVoCopyWith<$Res>? get corporateGuardian;
}

/// @nodoc
class __$$CorporateGuardianResponseVoImplCopyWithImpl<$Res>
    extends _$CorporateGuardianResponseVoCopyWithImpl<$Res,
        _$CorporateGuardianResponseVoImpl>
    implements _$$CorporateGuardianResponseVoImplCopyWith<$Res> {
  __$$CorporateGuardianResponseVoImplCopyWithImpl(
      _$CorporateGuardianResponseVoImpl _value,
      $Res Function(_$CorporateGuardianResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corporateGuardian = freezed,
  }) {
    return _then(_$CorporateGuardianResponseVoImpl(
      corporateGuardian: freezed == corporateGuardian
          ? _value.corporateGuardian
          : corporateGuardian // ignore: cast_nullable_to_non_nullable
              as CorporateGuardianBaseVo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateGuardianResponseVoImpl extends _CorporateGuardianResponseVo {
  _$CorporateGuardianResponseVoImpl({this.corporateGuardian}) : super._();

  factory _$CorporateGuardianResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateGuardianResponseVoImplFromJson(json);

  @override
  CorporateGuardianBaseVo? corporateGuardian;

  @override
  String toString() {
    return 'CorporateGuardianResponseVo(corporateGuardian: $corporateGuardian)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateGuardianResponseVoImplCopyWith<_$CorporateGuardianResponseVoImpl>
      get copyWith => __$$CorporateGuardianResponseVoImplCopyWithImpl<
          _$CorporateGuardianResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateGuardianResponseVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateGuardianResponseVo
    extends CorporateGuardianResponseVo {
  factory _CorporateGuardianResponseVo(
          {CorporateGuardianBaseVo? corporateGuardian}) =
      _$CorporateGuardianResponseVoImpl;
  _CorporateGuardianResponseVo._() : super._();

  factory _CorporateGuardianResponseVo.fromJson(Map<String, dynamic> json) =
      _$CorporateGuardianResponseVoImpl.fromJson;

  @override
  CorporateGuardianBaseVo? get corporateGuardian;
  set corporateGuardian(CorporateGuardianBaseVo? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateGuardianResponseVoImplCopyWith<_$CorporateGuardianResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
