// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_profile_edit_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateProfileEditRequestVo _$CorporateProfileEditRequestVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateProfileEditRequestVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateProfileEditRequestVo {
  String? get annualIncomeDeclaration => throw _privateConstructorUsedError;
  set annualIncomeDeclaration(String? value) =>
      throw _privateConstructorUsedError;
  String? get sourceOfIncome => throw _privateConstructorUsedError;
  set sourceOfIncome(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateProfileEditRequestVoCopyWith<CorporateProfileEditRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateProfileEditRequestVoCopyWith<$Res> {
  factory $CorporateProfileEditRequestVoCopyWith(
          CorporateProfileEditRequestVo value,
          $Res Function(CorporateProfileEditRequestVo) then) =
      _$CorporateProfileEditRequestVoCopyWithImpl<$Res,
          CorporateProfileEditRequestVo>;
  @useResult
  $Res call({String? annualIncomeDeclaration, String? sourceOfIncome});
}

/// @nodoc
class _$CorporateProfileEditRequestVoCopyWithImpl<$Res,
        $Val extends CorporateProfileEditRequestVo>
    implements $CorporateProfileEditRequestVoCopyWith<$Res> {
  _$CorporateProfileEditRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? annualIncomeDeclaration = freezed,
    Object? sourceOfIncome = freezed,
  }) {
    return _then(_value.copyWith(
      annualIncomeDeclaration: freezed == annualIncomeDeclaration
          ? _value.annualIncomeDeclaration
          : annualIncomeDeclaration // ignore: cast_nullable_to_non_nullable
              as String?,
      sourceOfIncome: freezed == sourceOfIncome
          ? _value.sourceOfIncome
          : sourceOfIncome // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorporateProfileEditRequestVoImplCopyWith<$Res>
    implements $CorporateProfileEditRequestVoCopyWith<$Res> {
  factory _$$CorporateProfileEditRequestVoImplCopyWith(
          _$CorporateProfileEditRequestVoImpl value,
          $Res Function(_$CorporateProfileEditRequestVoImpl) then) =
      __$$CorporateProfileEditRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? annualIncomeDeclaration, String? sourceOfIncome});
}

/// @nodoc
class __$$CorporateProfileEditRequestVoImplCopyWithImpl<$Res>
    extends _$CorporateProfileEditRequestVoCopyWithImpl<$Res,
        _$CorporateProfileEditRequestVoImpl>
    implements _$$CorporateProfileEditRequestVoImplCopyWith<$Res> {
  __$$CorporateProfileEditRequestVoImplCopyWithImpl(
      _$CorporateProfileEditRequestVoImpl _value,
      $Res Function(_$CorporateProfileEditRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? annualIncomeDeclaration = freezed,
    Object? sourceOfIncome = freezed,
  }) {
    return _then(_$CorporateProfileEditRequestVoImpl(
      annualIncomeDeclaration: freezed == annualIncomeDeclaration
          ? _value.annualIncomeDeclaration
          : annualIncomeDeclaration // ignore: cast_nullable_to_non_nullable
              as String?,
      sourceOfIncome: freezed == sourceOfIncome
          ? _value.sourceOfIncome
          : sourceOfIncome // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateProfileEditRequestVoImpl
    extends _CorporateProfileEditRequestVo {
  _$CorporateProfileEditRequestVoImpl(
      {this.annualIncomeDeclaration, this.sourceOfIncome})
      : super._();

  factory _$CorporateProfileEditRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateProfileEditRequestVoImplFromJson(json);

  @override
  String? annualIncomeDeclaration;
  @override
  String? sourceOfIncome;

  @override
  String toString() {
    return 'CorporateProfileEditRequestVo(annualIncomeDeclaration: $annualIncomeDeclaration, sourceOfIncome: $sourceOfIncome)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateProfileEditRequestVoImplCopyWith<
          _$CorporateProfileEditRequestVoImpl>
      get copyWith => __$$CorporateProfileEditRequestVoImplCopyWithImpl<
          _$CorporateProfileEditRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateProfileEditRequestVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateProfileEditRequestVo
    extends CorporateProfileEditRequestVo {
  factory _CorporateProfileEditRequestVo(
      {String? annualIncomeDeclaration,
      String? sourceOfIncome}) = _$CorporateProfileEditRequestVoImpl;
  _CorporateProfileEditRequestVo._() : super._();

  factory _CorporateProfileEditRequestVo.fromJson(Map<String, dynamic> json) =
      _$CorporateProfileEditRequestVoImpl.fromJson;

  @override
  String? get annualIncomeDeclaration;
  set annualIncomeDeclaration(String? value);
  @override
  String? get sourceOfIncome;
  set sourceOfIncome(String? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateProfileEditRequestVoImplCopyWith<
          _$CorporateProfileEditRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
