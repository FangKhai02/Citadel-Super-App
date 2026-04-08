// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_guardians_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateGuardiansResponseVo _$CorporateGuardiansResponseVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateGuardiansResponseVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateGuardiansResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<CorporateGuardianBaseVo>? get corporateGuardians =>
      throw _privateConstructorUsedError;
  set corporateGuardians(List<CorporateGuardianBaseVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateGuardiansResponseVoCopyWith<CorporateGuardiansResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateGuardiansResponseVoCopyWith<$Res> {
  factory $CorporateGuardiansResponseVoCopyWith(
          CorporateGuardiansResponseVo value,
          $Res Function(CorporateGuardiansResponseVo) then) =
      _$CorporateGuardiansResponseVoCopyWithImpl<$Res,
          CorporateGuardiansResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<CorporateGuardianBaseVo>? corporateGuardians});
}

/// @nodoc
class _$CorporateGuardiansResponseVoCopyWithImpl<$Res,
        $Val extends CorporateGuardiansResponseVo>
    implements $CorporateGuardiansResponseVoCopyWith<$Res> {
  _$CorporateGuardiansResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? corporateGuardians = freezed,
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
      corporateGuardians: freezed == corporateGuardians
          ? _value.corporateGuardians
          : corporateGuardians // ignore: cast_nullable_to_non_nullable
              as List<CorporateGuardianBaseVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorporateGuardiansResponseVoImplCopyWith<$Res>
    implements $CorporateGuardiansResponseVoCopyWith<$Res> {
  factory _$$CorporateGuardiansResponseVoImplCopyWith(
          _$CorporateGuardiansResponseVoImpl value,
          $Res Function(_$CorporateGuardiansResponseVoImpl) then) =
      __$$CorporateGuardiansResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<CorporateGuardianBaseVo>? corporateGuardians});
}

/// @nodoc
class __$$CorporateGuardiansResponseVoImplCopyWithImpl<$Res>
    extends _$CorporateGuardiansResponseVoCopyWithImpl<$Res,
        _$CorporateGuardiansResponseVoImpl>
    implements _$$CorporateGuardiansResponseVoImplCopyWith<$Res> {
  __$$CorporateGuardiansResponseVoImplCopyWithImpl(
      _$CorporateGuardiansResponseVoImpl _value,
      $Res Function(_$CorporateGuardiansResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? corporateGuardians = freezed,
  }) {
    return _then(_$CorporateGuardiansResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateGuardians: freezed == corporateGuardians
          ? _value.corporateGuardians
          : corporateGuardians // ignore: cast_nullable_to_non_nullable
              as List<CorporateGuardianBaseVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateGuardiansResponseVoImpl extends _CorporateGuardiansResponseVo {
  _$CorporateGuardiansResponseVoImpl(
      {this.code, this.message, this.corporateGuardians})
      : super._();

  factory _$CorporateGuardiansResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateGuardiansResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<CorporateGuardianBaseVo>? corporateGuardians;

  @override
  String toString() {
    return 'CorporateGuardiansResponseVo(code: $code, message: $message, corporateGuardians: $corporateGuardians)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateGuardiansResponseVoImplCopyWith<
          _$CorporateGuardiansResponseVoImpl>
      get copyWith => __$$CorporateGuardiansResponseVoImplCopyWithImpl<
          _$CorporateGuardiansResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateGuardiansResponseVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateGuardiansResponseVo
    extends CorporateGuardiansResponseVo {
  factory _CorporateGuardiansResponseVo(
          {String? code,
          String? message,
          List<CorporateGuardianBaseVo>? corporateGuardians}) =
      _$CorporateGuardiansResponseVoImpl;
  _CorporateGuardiansResponseVo._() : super._();

  factory _CorporateGuardiansResponseVo.fromJson(Map<String, dynamic> json) =
      _$CorporateGuardiansResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<CorporateGuardianBaseVo>? get corporateGuardians;
  set corporateGuardians(List<CorporateGuardianBaseVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateGuardiansResponseVoImplCopyWith<
          _$CorporateGuardiansResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
