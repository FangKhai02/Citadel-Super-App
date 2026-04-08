// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_beneficiary_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateBeneficiaryResponseVo _$CorporateBeneficiaryResponseVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateBeneficiaryResponseVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateBeneficiaryResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  CorporateBeneficiaryVo? get corporateBeneficiary =>
      throw _privateConstructorUsedError;
  set corporateBeneficiary(CorporateBeneficiaryVo? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateBeneficiaryResponseVoCopyWith<CorporateBeneficiaryResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateBeneficiaryResponseVoCopyWith<$Res> {
  factory $CorporateBeneficiaryResponseVoCopyWith(
          CorporateBeneficiaryResponseVo value,
          $Res Function(CorporateBeneficiaryResponseVo) then) =
      _$CorporateBeneficiaryResponseVoCopyWithImpl<$Res,
          CorporateBeneficiaryResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      CorporateBeneficiaryVo? corporateBeneficiary});

  $CorporateBeneficiaryVoCopyWith<$Res>? get corporateBeneficiary;
}

/// @nodoc
class _$CorporateBeneficiaryResponseVoCopyWithImpl<$Res,
        $Val extends CorporateBeneficiaryResponseVo>
    implements $CorporateBeneficiaryResponseVoCopyWith<$Res> {
  _$CorporateBeneficiaryResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? corporateBeneficiary = freezed,
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
      corporateBeneficiary: freezed == corporateBeneficiary
          ? _value.corporateBeneficiary
          : corporateBeneficiary // ignore: cast_nullable_to_non_nullable
              as CorporateBeneficiaryVo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CorporateBeneficiaryVoCopyWith<$Res>? get corporateBeneficiary {
    if (_value.corporateBeneficiary == null) {
      return null;
    }

    return $CorporateBeneficiaryVoCopyWith<$Res>(_value.corporateBeneficiary!,
        (value) {
      return _then(_value.copyWith(corporateBeneficiary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CorporateBeneficiaryResponseVoImplCopyWith<$Res>
    implements $CorporateBeneficiaryResponseVoCopyWith<$Res> {
  factory _$$CorporateBeneficiaryResponseVoImplCopyWith(
          _$CorporateBeneficiaryResponseVoImpl value,
          $Res Function(_$CorporateBeneficiaryResponseVoImpl) then) =
      __$$CorporateBeneficiaryResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      CorporateBeneficiaryVo? corporateBeneficiary});

  @override
  $CorporateBeneficiaryVoCopyWith<$Res>? get corporateBeneficiary;
}

/// @nodoc
class __$$CorporateBeneficiaryResponseVoImplCopyWithImpl<$Res>
    extends _$CorporateBeneficiaryResponseVoCopyWithImpl<$Res,
        _$CorporateBeneficiaryResponseVoImpl>
    implements _$$CorporateBeneficiaryResponseVoImplCopyWith<$Res> {
  __$$CorporateBeneficiaryResponseVoImplCopyWithImpl(
      _$CorporateBeneficiaryResponseVoImpl _value,
      $Res Function(_$CorporateBeneficiaryResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? corporateBeneficiary = freezed,
  }) {
    return _then(_$CorporateBeneficiaryResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateBeneficiary: freezed == corporateBeneficiary
          ? _value.corporateBeneficiary
          : corporateBeneficiary // ignore: cast_nullable_to_non_nullable
              as CorporateBeneficiaryVo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateBeneficiaryResponseVoImpl
    extends _CorporateBeneficiaryResponseVo {
  _$CorporateBeneficiaryResponseVoImpl(
      {this.code, this.message, this.corporateBeneficiary})
      : super._();

  factory _$CorporateBeneficiaryResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateBeneficiaryResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  CorporateBeneficiaryVo? corporateBeneficiary;

  @override
  String toString() {
    return 'CorporateBeneficiaryResponseVo(code: $code, message: $message, corporateBeneficiary: $corporateBeneficiary)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateBeneficiaryResponseVoImplCopyWith<
          _$CorporateBeneficiaryResponseVoImpl>
      get copyWith => __$$CorporateBeneficiaryResponseVoImplCopyWithImpl<
          _$CorporateBeneficiaryResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateBeneficiaryResponseVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateBeneficiaryResponseVo
    extends CorporateBeneficiaryResponseVo {
  factory _CorporateBeneficiaryResponseVo(
          {String? code,
          String? message,
          CorporateBeneficiaryVo? corporateBeneficiary}) =
      _$CorporateBeneficiaryResponseVoImpl;
  _CorporateBeneficiaryResponseVo._() : super._();

  factory _CorporateBeneficiaryResponseVo.fromJson(Map<String, dynamic> json) =
      _$CorporateBeneficiaryResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  CorporateBeneficiaryVo? get corporateBeneficiary;
  set corporateBeneficiary(CorporateBeneficiaryVo? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateBeneficiaryResponseVoImplCopyWith<
          _$CorporateBeneficiaryResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
