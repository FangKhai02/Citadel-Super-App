// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_wealth_source_details_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClientWealthSourceDetailsVo _$ClientWealthSourceDetailsVoFromJson(
    Map<String, dynamic> json) {
  return _ClientWealthSourceDetailsVo.fromJson(json);
}

/// @nodoc
mixin _$ClientWealthSourceDetailsVo {
  String? get annualIncomeDeclaration => throw _privateConstructorUsedError;
  set annualIncomeDeclaration(String? value) =>
      throw _privateConstructorUsedError;
  String? get sourceOfIncome => throw _privateConstructorUsedError;
  set sourceOfIncome(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientWealthSourceDetailsVoCopyWith<ClientWealthSourceDetailsVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientWealthSourceDetailsVoCopyWith<$Res> {
  factory $ClientWealthSourceDetailsVoCopyWith(
          ClientWealthSourceDetailsVo value,
          $Res Function(ClientWealthSourceDetailsVo) then) =
      _$ClientWealthSourceDetailsVoCopyWithImpl<$Res,
          ClientWealthSourceDetailsVo>;
  @useResult
  $Res call({String? annualIncomeDeclaration, String? sourceOfIncome});
}

/// @nodoc
class _$ClientWealthSourceDetailsVoCopyWithImpl<$Res,
        $Val extends ClientWealthSourceDetailsVo>
    implements $ClientWealthSourceDetailsVoCopyWith<$Res> {
  _$ClientWealthSourceDetailsVoCopyWithImpl(this._value, this._then);

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
abstract class _$$ClientWealthSourceDetailsVoImplCopyWith<$Res>
    implements $ClientWealthSourceDetailsVoCopyWith<$Res> {
  factory _$$ClientWealthSourceDetailsVoImplCopyWith(
          _$ClientWealthSourceDetailsVoImpl value,
          $Res Function(_$ClientWealthSourceDetailsVoImpl) then) =
      __$$ClientWealthSourceDetailsVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? annualIncomeDeclaration, String? sourceOfIncome});
}

/// @nodoc
class __$$ClientWealthSourceDetailsVoImplCopyWithImpl<$Res>
    extends _$ClientWealthSourceDetailsVoCopyWithImpl<$Res,
        _$ClientWealthSourceDetailsVoImpl>
    implements _$$ClientWealthSourceDetailsVoImplCopyWith<$Res> {
  __$$ClientWealthSourceDetailsVoImplCopyWithImpl(
      _$ClientWealthSourceDetailsVoImpl _value,
      $Res Function(_$ClientWealthSourceDetailsVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? annualIncomeDeclaration = freezed,
    Object? sourceOfIncome = freezed,
  }) {
    return _then(_$ClientWealthSourceDetailsVoImpl(
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
class _$ClientWealthSourceDetailsVoImpl extends _ClientWealthSourceDetailsVo {
  _$ClientWealthSourceDetailsVoImpl(
      {this.annualIncomeDeclaration, this.sourceOfIncome})
      : super._();

  factory _$ClientWealthSourceDetailsVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ClientWealthSourceDetailsVoImplFromJson(json);

  @override
  String? annualIncomeDeclaration;
  @override
  String? sourceOfIncome;

  @override
  String toString() {
    return 'ClientWealthSourceDetailsVo(annualIncomeDeclaration: $annualIncomeDeclaration, sourceOfIncome: $sourceOfIncome)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientWealthSourceDetailsVoImplCopyWith<_$ClientWealthSourceDetailsVoImpl>
      get copyWith => __$$ClientWealthSourceDetailsVoImplCopyWithImpl<
          _$ClientWealthSourceDetailsVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientWealthSourceDetailsVoImplToJson(
      this,
    );
  }
}

abstract class _ClientWealthSourceDetailsVo
    extends ClientWealthSourceDetailsVo {
  factory _ClientWealthSourceDetailsVo(
      {String? annualIncomeDeclaration,
      String? sourceOfIncome}) = _$ClientWealthSourceDetailsVoImpl;
  _ClientWealthSourceDetailsVo._() : super._();

  factory _ClientWealthSourceDetailsVo.fromJson(Map<String, dynamic> json) =
      _$ClientWealthSourceDetailsVoImpl.fromJson;

  @override
  String? get annualIncomeDeclaration;
  set annualIncomeDeclaration(String? value);
  @override
  String? get sourceOfIncome;
  set sourceOfIncome(String? value);
  @override
  @JsonKey(ignore: true)
  _$$ClientWealthSourceDetailsVoImplCopyWith<_$ClientWealthSourceDetailsVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
