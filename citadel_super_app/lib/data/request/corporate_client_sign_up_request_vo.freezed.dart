// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_client_sign_up_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateClientSignUpRequestVo _$CorporateClientSignUpRequestVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateClientSignUpRequestVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateClientSignUpRequestVo {
  CorporateDetailsRequestVo? get corporateDetails =>
      throw _privateConstructorUsedError;
  set corporateDetails(CorporateDetailsRequestVo? value) =>
      throw _privateConstructorUsedError;
  String? get annualIncomeDeclaration => throw _privateConstructorUsedError;
  set annualIncomeDeclaration(String? value) =>
      throw _privateConstructorUsedError;
  String? get sourceOfIncome => throw _privateConstructorUsedError;
  set sourceOfIncome(String? value) => throw _privateConstructorUsedError;
  String? get digitalSignature => throw _privateConstructorUsedError;
  set digitalSignature(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateClientSignUpRequestVoCopyWith<CorporateClientSignUpRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateClientSignUpRequestVoCopyWith<$Res> {
  factory $CorporateClientSignUpRequestVoCopyWith(
          CorporateClientSignUpRequestVo value,
          $Res Function(CorporateClientSignUpRequestVo) then) =
      _$CorporateClientSignUpRequestVoCopyWithImpl<$Res,
          CorporateClientSignUpRequestVo>;
  @useResult
  $Res call(
      {CorporateDetailsRequestVo? corporateDetails,
      String? annualIncomeDeclaration,
      String? sourceOfIncome,
      String? digitalSignature});

  $CorporateDetailsRequestVoCopyWith<$Res>? get corporateDetails;
}

/// @nodoc
class _$CorporateClientSignUpRequestVoCopyWithImpl<$Res,
        $Val extends CorporateClientSignUpRequestVo>
    implements $CorporateClientSignUpRequestVoCopyWith<$Res> {
  _$CorporateClientSignUpRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corporateDetails = freezed,
    Object? annualIncomeDeclaration = freezed,
    Object? sourceOfIncome = freezed,
    Object? digitalSignature = freezed,
  }) {
    return _then(_value.copyWith(
      corporateDetails: freezed == corporateDetails
          ? _value.corporateDetails
          : corporateDetails // ignore: cast_nullable_to_non_nullable
              as CorporateDetailsRequestVo?,
      annualIncomeDeclaration: freezed == annualIncomeDeclaration
          ? _value.annualIncomeDeclaration
          : annualIncomeDeclaration // ignore: cast_nullable_to_non_nullable
              as String?,
      sourceOfIncome: freezed == sourceOfIncome
          ? _value.sourceOfIncome
          : sourceOfIncome // ignore: cast_nullable_to_non_nullable
              as String?,
      digitalSignature: freezed == digitalSignature
          ? _value.digitalSignature
          : digitalSignature // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CorporateDetailsRequestVoCopyWith<$Res>? get corporateDetails {
    if (_value.corporateDetails == null) {
      return null;
    }

    return $CorporateDetailsRequestVoCopyWith<$Res>(_value.corporateDetails!,
        (value) {
      return _then(_value.copyWith(corporateDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CorporateClientSignUpRequestVoImplCopyWith<$Res>
    implements $CorporateClientSignUpRequestVoCopyWith<$Res> {
  factory _$$CorporateClientSignUpRequestVoImplCopyWith(
          _$CorporateClientSignUpRequestVoImpl value,
          $Res Function(_$CorporateClientSignUpRequestVoImpl) then) =
      __$$CorporateClientSignUpRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CorporateDetailsRequestVo? corporateDetails,
      String? annualIncomeDeclaration,
      String? sourceOfIncome,
      String? digitalSignature});

  @override
  $CorporateDetailsRequestVoCopyWith<$Res>? get corporateDetails;
}

/// @nodoc
class __$$CorporateClientSignUpRequestVoImplCopyWithImpl<$Res>
    extends _$CorporateClientSignUpRequestVoCopyWithImpl<$Res,
        _$CorporateClientSignUpRequestVoImpl>
    implements _$$CorporateClientSignUpRequestVoImplCopyWith<$Res> {
  __$$CorporateClientSignUpRequestVoImplCopyWithImpl(
      _$CorporateClientSignUpRequestVoImpl _value,
      $Res Function(_$CorporateClientSignUpRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? corporateDetails = freezed,
    Object? annualIncomeDeclaration = freezed,
    Object? sourceOfIncome = freezed,
    Object? digitalSignature = freezed,
  }) {
    return _then(_$CorporateClientSignUpRequestVoImpl(
      corporateDetails: freezed == corporateDetails
          ? _value.corporateDetails
          : corporateDetails // ignore: cast_nullable_to_non_nullable
              as CorporateDetailsRequestVo?,
      annualIncomeDeclaration: freezed == annualIncomeDeclaration
          ? _value.annualIncomeDeclaration
          : annualIncomeDeclaration // ignore: cast_nullable_to_non_nullable
              as String?,
      sourceOfIncome: freezed == sourceOfIncome
          ? _value.sourceOfIncome
          : sourceOfIncome // ignore: cast_nullable_to_non_nullable
              as String?,
      digitalSignature: freezed == digitalSignature
          ? _value.digitalSignature
          : digitalSignature // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateClientSignUpRequestVoImpl
    extends _CorporateClientSignUpRequestVo {
  _$CorporateClientSignUpRequestVoImpl(
      {this.corporateDetails,
      this.annualIncomeDeclaration,
      this.sourceOfIncome,
      this.digitalSignature})
      : super._();

  factory _$CorporateClientSignUpRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateClientSignUpRequestVoImplFromJson(json);

  @override
  CorporateDetailsRequestVo? corporateDetails;
  @override
  String? annualIncomeDeclaration;
  @override
  String? sourceOfIncome;
  @override
  String? digitalSignature;

  @override
  String toString() {
    return 'CorporateClientSignUpRequestVo(corporateDetails: $corporateDetails, annualIncomeDeclaration: $annualIncomeDeclaration, sourceOfIncome: $sourceOfIncome, digitalSignature: $digitalSignature)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateClientSignUpRequestVoImplCopyWith<
          _$CorporateClientSignUpRequestVoImpl>
      get copyWith => __$$CorporateClientSignUpRequestVoImplCopyWithImpl<
          _$CorporateClientSignUpRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateClientSignUpRequestVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateClientSignUpRequestVo
    extends CorporateClientSignUpRequestVo {
  factory _CorporateClientSignUpRequestVo(
      {CorporateDetailsRequestVo? corporateDetails,
      String? annualIncomeDeclaration,
      String? sourceOfIncome,
      String? digitalSignature}) = _$CorporateClientSignUpRequestVoImpl;
  _CorporateClientSignUpRequestVo._() : super._();

  factory _CorporateClientSignUpRequestVo.fromJson(Map<String, dynamic> json) =
      _$CorporateClientSignUpRequestVoImpl.fromJson;

  @override
  CorporateDetailsRequestVo? get corporateDetails;
  set corporateDetails(CorporateDetailsRequestVo? value);
  @override
  String? get annualIncomeDeclaration;
  set annualIncomeDeclaration(String? value);
  @override
  String? get sourceOfIncome;
  set sourceOfIncome(String? value);
  @override
  String? get digitalSignature;
  set digitalSignature(String? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateClientSignUpRequestVoImplCopyWith<
          _$CorporateClientSignUpRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
