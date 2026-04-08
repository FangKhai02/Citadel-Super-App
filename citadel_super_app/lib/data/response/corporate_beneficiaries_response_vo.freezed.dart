// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_beneficiaries_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateBeneficiariesResponseVo _$CorporateBeneficiariesResponseVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateBeneficiariesResponseVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateBeneficiariesResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<CorporateBeneficiaryBaseVo>? get corporateBeneficiaries =>
      throw _privateConstructorUsedError;
  set corporateBeneficiaries(List<CorporateBeneficiaryBaseVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateBeneficiariesResponseVoCopyWith<CorporateBeneficiariesResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateBeneficiariesResponseVoCopyWith<$Res> {
  factory $CorporateBeneficiariesResponseVoCopyWith(
          CorporateBeneficiariesResponseVo value,
          $Res Function(CorporateBeneficiariesResponseVo) then) =
      _$CorporateBeneficiariesResponseVoCopyWithImpl<$Res,
          CorporateBeneficiariesResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<CorporateBeneficiaryBaseVo>? corporateBeneficiaries});
}

/// @nodoc
class _$CorporateBeneficiariesResponseVoCopyWithImpl<$Res,
        $Val extends CorporateBeneficiariesResponseVo>
    implements $CorporateBeneficiariesResponseVoCopyWith<$Res> {
  _$CorporateBeneficiariesResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? corporateBeneficiaries = freezed,
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
      corporateBeneficiaries: freezed == corporateBeneficiaries
          ? _value.corporateBeneficiaries
          : corporateBeneficiaries // ignore: cast_nullable_to_non_nullable
              as List<CorporateBeneficiaryBaseVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorporateBeneficiariesResponseVoImplCopyWith<$Res>
    implements $CorporateBeneficiariesResponseVoCopyWith<$Res> {
  factory _$$CorporateBeneficiariesResponseVoImplCopyWith(
          _$CorporateBeneficiariesResponseVoImpl value,
          $Res Function(_$CorporateBeneficiariesResponseVoImpl) then) =
      __$$CorporateBeneficiariesResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<CorporateBeneficiaryBaseVo>? corporateBeneficiaries});
}

/// @nodoc
class __$$CorporateBeneficiariesResponseVoImplCopyWithImpl<$Res>
    extends _$CorporateBeneficiariesResponseVoCopyWithImpl<$Res,
        _$CorporateBeneficiariesResponseVoImpl>
    implements _$$CorporateBeneficiariesResponseVoImplCopyWith<$Res> {
  __$$CorporateBeneficiariesResponseVoImplCopyWithImpl(
      _$CorporateBeneficiariesResponseVoImpl _value,
      $Res Function(_$CorporateBeneficiariesResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? corporateBeneficiaries = freezed,
  }) {
    return _then(_$CorporateBeneficiariesResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateBeneficiaries: freezed == corporateBeneficiaries
          ? _value.corporateBeneficiaries
          : corporateBeneficiaries // ignore: cast_nullable_to_non_nullable
              as List<CorporateBeneficiaryBaseVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateBeneficiariesResponseVoImpl
    extends _CorporateBeneficiariesResponseVo {
  _$CorporateBeneficiariesResponseVoImpl(
      {this.code, this.message, this.corporateBeneficiaries})
      : super._();

  factory _$CorporateBeneficiariesResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateBeneficiariesResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<CorporateBeneficiaryBaseVo>? corporateBeneficiaries;

  @override
  String toString() {
    return 'CorporateBeneficiariesResponseVo(code: $code, message: $message, corporateBeneficiaries: $corporateBeneficiaries)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateBeneficiariesResponseVoImplCopyWith<
          _$CorporateBeneficiariesResponseVoImpl>
      get copyWith => __$$CorporateBeneficiariesResponseVoImplCopyWithImpl<
          _$CorporateBeneficiariesResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateBeneficiariesResponseVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateBeneficiariesResponseVo
    extends CorporateBeneficiariesResponseVo {
  factory _CorporateBeneficiariesResponseVo(
          {String? code,
          String? message,
          List<CorporateBeneficiaryBaseVo>? corporateBeneficiaries}) =
      _$CorporateBeneficiariesResponseVoImpl;
  _CorporateBeneficiariesResponseVo._() : super._();

  factory _CorporateBeneficiariesResponseVo.fromJson(
          Map<String, dynamic> json) =
      _$CorporateBeneficiariesResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<CorporateBeneficiaryBaseVo>? get corporateBeneficiaries;
  set corporateBeneficiaries(List<CorporateBeneficiaryBaseVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateBeneficiariesResponseVoImplCopyWith<
          _$CorporateBeneficiariesResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
