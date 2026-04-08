// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_client_edit_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateClientEditRequestVo _$CorporateClientEditRequestVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateClientEditRequestVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateClientEditRequestVo {
  String? get annualIncomeDeclaration => throw _privateConstructorUsedError;
  set annualIncomeDeclaration(String? value) =>
      throw _privateConstructorUsedError;
  String? get sourceOfIncome => throw _privateConstructorUsedError;
  set sourceOfIncome(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateClientEditRequestVoCopyWith<CorporateClientEditRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateClientEditRequestVoCopyWith<$Res> {
  factory $CorporateClientEditRequestVoCopyWith(
          CorporateClientEditRequestVo value,
          $Res Function(CorporateClientEditRequestVo) then) =
      _$CorporateClientEditRequestVoCopyWithImpl<$Res,
          CorporateClientEditRequestVo>;
  @useResult
  $Res call({String? annualIncomeDeclaration, String? sourceOfIncome});
}

/// @nodoc
class _$CorporateClientEditRequestVoCopyWithImpl<$Res,
        $Val extends CorporateClientEditRequestVo>
    implements $CorporateClientEditRequestVoCopyWith<$Res> {
  _$CorporateClientEditRequestVoCopyWithImpl(this._value, this._then);

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
abstract class _$$CorporateClientEditRequestVoImplCopyWith<$Res>
    implements $CorporateClientEditRequestVoCopyWith<$Res> {
  factory _$$CorporateClientEditRequestVoImplCopyWith(
          _$CorporateClientEditRequestVoImpl value,
          $Res Function(_$CorporateClientEditRequestVoImpl) then) =
      __$$CorporateClientEditRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? annualIncomeDeclaration, String? sourceOfIncome});
}

/// @nodoc
class __$$CorporateClientEditRequestVoImplCopyWithImpl<$Res>
    extends _$CorporateClientEditRequestVoCopyWithImpl<$Res,
        _$CorporateClientEditRequestVoImpl>
    implements _$$CorporateClientEditRequestVoImplCopyWith<$Res> {
  __$$CorporateClientEditRequestVoImplCopyWithImpl(
      _$CorporateClientEditRequestVoImpl _value,
      $Res Function(_$CorporateClientEditRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? annualIncomeDeclaration = freezed,
    Object? sourceOfIncome = freezed,
  }) {
    return _then(_$CorporateClientEditRequestVoImpl(
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
class _$CorporateClientEditRequestVoImpl extends _CorporateClientEditRequestVo {
  _$CorporateClientEditRequestVoImpl(
      {this.annualIncomeDeclaration, this.sourceOfIncome})
      : super._();

  factory _$CorporateClientEditRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateClientEditRequestVoImplFromJson(json);

  @override
  String? annualIncomeDeclaration;
  @override
  String? sourceOfIncome;

  @override
  String toString() {
    return 'CorporateClientEditRequestVo(annualIncomeDeclaration: $annualIncomeDeclaration, sourceOfIncome: $sourceOfIncome)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateClientEditRequestVoImplCopyWith<
          _$CorporateClientEditRequestVoImpl>
      get copyWith => __$$CorporateClientEditRequestVoImplCopyWithImpl<
          _$CorporateClientEditRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateClientEditRequestVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateClientEditRequestVo
    extends CorporateClientEditRequestVo {
  factory _CorporateClientEditRequestVo(
      {String? annualIncomeDeclaration,
      String? sourceOfIncome}) = _$CorporateClientEditRequestVoImpl;
  _CorporateClientEditRequestVo._() : super._();

  factory _CorporateClientEditRequestVo.fromJson(Map<String, dynamic> json) =
      _$CorporateClientEditRequestVoImpl.fromJson;

  @override
  String? get annualIncomeDeclaration;
  set annualIncomeDeclaration(String? value);
  @override
  String? get sourceOfIncome;
  set sourceOfIncome(String? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateClientEditRequestVoImplCopyWith<
          _$CorporateClientEditRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
