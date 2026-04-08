// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_dividend_payout_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentDividendPayoutVo _$AgentDividendPayoutVoFromJson(
    Map<String, dynamic> json) {
  return _AgentDividendPayoutVo.fromJson(json);
}

/// @nodoc
mixin _$AgentDividendPayoutVo {
  String? get dividendPayoutId => throw _privateConstructorUsedError;
  set dividendPayoutId(String? value) => throw _privateConstructorUsedError;
  String? get productName => throw _privateConstructorUsedError;
  set productName(String? value) => throw _privateConstructorUsedError;
  String? get productCode => throw _privateConstructorUsedError;
  set productCode(String? value) => throw _privateConstructorUsedError;
  int? get dividendAmount => throw _privateConstructorUsedError;
  set dividendAmount(int? value) => throw _privateConstructorUsedError;
  int? get dividendPayoutDate => throw _privateConstructorUsedError;
  set dividendPayoutDate(int? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentDividendPayoutVoCopyWith<AgentDividendPayoutVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentDividendPayoutVoCopyWith<$Res> {
  factory $AgentDividendPayoutVoCopyWith(AgentDividendPayoutVo value,
          $Res Function(AgentDividendPayoutVo) then) =
      _$AgentDividendPayoutVoCopyWithImpl<$Res, AgentDividendPayoutVo>;
  @useResult
  $Res call(
      {String? dividendPayoutId,
      String? productName,
      String? productCode,
      int? dividendAmount,
      int? dividendPayoutDate});
}

/// @nodoc
class _$AgentDividendPayoutVoCopyWithImpl<$Res,
        $Val extends AgentDividendPayoutVo>
    implements $AgentDividendPayoutVoCopyWith<$Res> {
  _$AgentDividendPayoutVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dividendPayoutId = freezed,
    Object? productName = freezed,
    Object? productCode = freezed,
    Object? dividendAmount = freezed,
    Object? dividendPayoutDate = freezed,
  }) {
    return _then(_value.copyWith(
      dividendPayoutId: freezed == dividendPayoutId
          ? _value.dividendPayoutId
          : dividendPayoutId // ignore: cast_nullable_to_non_nullable
              as String?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productCode: freezed == productCode
          ? _value.productCode
          : productCode // ignore: cast_nullable_to_non_nullable
              as String?,
      dividendAmount: freezed == dividendAmount
          ? _value.dividendAmount
          : dividendAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      dividendPayoutDate: freezed == dividendPayoutDate
          ? _value.dividendPayoutDate
          : dividendPayoutDate // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentDividendPayoutVoImplCopyWith<$Res>
    implements $AgentDividendPayoutVoCopyWith<$Res> {
  factory _$$AgentDividendPayoutVoImplCopyWith(
          _$AgentDividendPayoutVoImpl value,
          $Res Function(_$AgentDividendPayoutVoImpl) then) =
      __$$AgentDividendPayoutVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? dividendPayoutId,
      String? productName,
      String? productCode,
      int? dividendAmount,
      int? dividendPayoutDate});
}

/// @nodoc
class __$$AgentDividendPayoutVoImplCopyWithImpl<$Res>
    extends _$AgentDividendPayoutVoCopyWithImpl<$Res,
        _$AgentDividendPayoutVoImpl>
    implements _$$AgentDividendPayoutVoImplCopyWith<$Res> {
  __$$AgentDividendPayoutVoImplCopyWithImpl(_$AgentDividendPayoutVoImpl _value,
      $Res Function(_$AgentDividendPayoutVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dividendPayoutId = freezed,
    Object? productName = freezed,
    Object? productCode = freezed,
    Object? dividendAmount = freezed,
    Object? dividendPayoutDate = freezed,
  }) {
    return _then(_$AgentDividendPayoutVoImpl(
      dividendPayoutId: freezed == dividendPayoutId
          ? _value.dividendPayoutId
          : dividendPayoutId // ignore: cast_nullable_to_non_nullable
              as String?,
      productName: freezed == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String?,
      productCode: freezed == productCode
          ? _value.productCode
          : productCode // ignore: cast_nullable_to_non_nullable
              as String?,
      dividendAmount: freezed == dividendAmount
          ? _value.dividendAmount
          : dividendAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      dividendPayoutDate: freezed == dividendPayoutDate
          ? _value.dividendPayoutDate
          : dividendPayoutDate // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentDividendPayoutVoImpl extends _AgentDividendPayoutVo {
  _$AgentDividendPayoutVoImpl(
      {this.dividendPayoutId,
      this.productName,
      this.productCode,
      this.dividendAmount,
      this.dividendPayoutDate})
      : super._();

  factory _$AgentDividendPayoutVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgentDividendPayoutVoImplFromJson(json);

  @override
  String? dividendPayoutId;
  @override
  String? productName;
  @override
  String? productCode;
  @override
  int? dividendAmount;
  @override
  int? dividendPayoutDate;

  @override
  String toString() {
    return 'AgentDividendPayoutVo(dividendPayoutId: $dividendPayoutId, productName: $productName, productCode: $productCode, dividendAmount: $dividendAmount, dividendPayoutDate: $dividendPayoutDate)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentDividendPayoutVoImplCopyWith<_$AgentDividendPayoutVoImpl>
      get copyWith => __$$AgentDividendPayoutVoImplCopyWithImpl<
          _$AgentDividendPayoutVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentDividendPayoutVoImplToJson(
      this,
    );
  }
}

abstract class _AgentDividendPayoutVo extends AgentDividendPayoutVo {
  factory _AgentDividendPayoutVo(
      {String? dividendPayoutId,
      String? productName,
      String? productCode,
      int? dividendAmount,
      int? dividendPayoutDate}) = _$AgentDividendPayoutVoImpl;
  _AgentDividendPayoutVo._() : super._();

  factory _AgentDividendPayoutVo.fromJson(Map<String, dynamic> json) =
      _$AgentDividendPayoutVoImpl.fromJson;

  @override
  String? get dividendPayoutId;
  set dividendPayoutId(String? value);
  @override
  String? get productName;
  set productName(String? value);
  @override
  String? get productCode;
  set productCode(String? value);
  @override
  int? get dividendAmount;
  set dividendAmount(int? value);
  @override
  int? get dividendPayoutDate;
  set dividendPayoutDate(int? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentDividendPayoutVoImplCopyWith<_$AgentDividendPayoutVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
