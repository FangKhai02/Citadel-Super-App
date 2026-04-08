// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fund_amount_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FundAmountVo _$FundAmountVoFromJson(Map<String, dynamic> json) {
  return _FundAmountVo.fromJson(json);
}

/// @nodoc
mixin _$FundAmountVo {
  double? get amount => throw _privateConstructorUsedError;
  set amount(double? value) => throw _privateConstructorUsedError;
  double? get dividend => throw _privateConstructorUsedError;
  set dividend(double? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FundAmountVoCopyWith<FundAmountVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FundAmountVoCopyWith<$Res> {
  factory $FundAmountVoCopyWith(
          FundAmountVo value, $Res Function(FundAmountVo) then) =
      _$FundAmountVoCopyWithImpl<$Res, FundAmountVo>;
  @useResult
  $Res call({double? amount, double? dividend});
}

/// @nodoc
class _$FundAmountVoCopyWithImpl<$Res, $Val extends FundAmountVo>
    implements $FundAmountVoCopyWith<$Res> {
  _$FundAmountVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? dividend = freezed,
  }) {
    return _then(_value.copyWith(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      dividend: freezed == dividend
          ? _value.dividend
          : dividend // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FundAmountVoImplCopyWith<$Res>
    implements $FundAmountVoCopyWith<$Res> {
  factory _$$FundAmountVoImplCopyWith(
          _$FundAmountVoImpl value, $Res Function(_$FundAmountVoImpl) then) =
      __$$FundAmountVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? amount, double? dividend});
}

/// @nodoc
class __$$FundAmountVoImplCopyWithImpl<$Res>
    extends _$FundAmountVoCopyWithImpl<$Res, _$FundAmountVoImpl>
    implements _$$FundAmountVoImplCopyWith<$Res> {
  __$$FundAmountVoImplCopyWithImpl(
      _$FundAmountVoImpl _value, $Res Function(_$FundAmountVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? dividend = freezed,
  }) {
    return _then(_$FundAmountVoImpl(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
      dividend: freezed == dividend
          ? _value.dividend
          : dividend // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FundAmountVoImpl extends _FundAmountVo {
  _$FundAmountVoImpl({this.amount, this.dividend}) : super._();

  factory _$FundAmountVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FundAmountVoImplFromJson(json);

  @override
  double? amount;
  @override
  double? dividend;

  @override
  String toString() {
    return 'FundAmountVo(amount: $amount, dividend: $dividend)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FundAmountVoImplCopyWith<_$FundAmountVoImpl> get copyWith =>
      __$$FundAmountVoImplCopyWithImpl<_$FundAmountVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FundAmountVoImplToJson(
      this,
    );
  }
}

abstract class _FundAmountVo extends FundAmountVo {
  factory _FundAmountVo({double? amount, double? dividend}) =
      _$FundAmountVoImpl;
  _FundAmountVo._() : super._();

  factory _FundAmountVo.fromJson(Map<String, dynamic> json) =
      _$FundAmountVoImpl.fromJson;

  @override
  double? get amount;
  set amount(double? value);
  @override
  double? get dividend;
  set dividend(double? value);
  @override
  @JsonKey(ignore: true)
  _$$FundAmountVoImplCopyWith<_$FundAmountVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
