// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reallocate_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReallocateRequestVo _$ReallocateRequestVoFromJson(Map<String, dynamic> json) {
  return _ReallocateRequestVo.fromJson(json);
}

/// @nodoc
mixin _$ReallocateRequestVo {
  String? get productCode => throw _privateConstructorUsedError;
  set productCode(String? value) => throw _privateConstructorUsedError;
  double? get amount => throw _privateConstructorUsedError;
  set amount(double? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReallocateRequestVoCopyWith<ReallocateRequestVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReallocateRequestVoCopyWith<$Res> {
  factory $ReallocateRequestVoCopyWith(
          ReallocateRequestVo value, $Res Function(ReallocateRequestVo) then) =
      _$ReallocateRequestVoCopyWithImpl<$Res, ReallocateRequestVo>;
  @useResult
  $Res call({String? productCode, double? amount});
}

/// @nodoc
class _$ReallocateRequestVoCopyWithImpl<$Res, $Val extends ReallocateRequestVo>
    implements $ReallocateRequestVoCopyWith<$Res> {
  _$ReallocateRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productCode = freezed,
    Object? amount = freezed,
  }) {
    return _then(_value.copyWith(
      productCode: freezed == productCode
          ? _value.productCode
          : productCode // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReallocateRequestVoImplCopyWith<$Res>
    implements $ReallocateRequestVoCopyWith<$Res> {
  factory _$$ReallocateRequestVoImplCopyWith(_$ReallocateRequestVoImpl value,
          $Res Function(_$ReallocateRequestVoImpl) then) =
      __$$ReallocateRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? productCode, double? amount});
}

/// @nodoc
class __$$ReallocateRequestVoImplCopyWithImpl<$Res>
    extends _$ReallocateRequestVoCopyWithImpl<$Res, _$ReallocateRequestVoImpl>
    implements _$$ReallocateRequestVoImplCopyWith<$Res> {
  __$$ReallocateRequestVoImplCopyWithImpl(_$ReallocateRequestVoImpl _value,
      $Res Function(_$ReallocateRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productCode = freezed,
    Object? amount = freezed,
  }) {
    return _then(_$ReallocateRequestVoImpl(
      productCode: freezed == productCode
          ? _value.productCode
          : productCode // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReallocateRequestVoImpl extends _ReallocateRequestVo {
  _$ReallocateRequestVoImpl({this.productCode, this.amount}) : super._();

  factory _$ReallocateRequestVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReallocateRequestVoImplFromJson(json);

  @override
  String? productCode;
  @override
  double? amount;

  @override
  String toString() {
    return 'ReallocateRequestVo(productCode: $productCode, amount: $amount)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReallocateRequestVoImplCopyWith<_$ReallocateRequestVoImpl> get copyWith =>
      __$$ReallocateRequestVoImplCopyWithImpl<_$ReallocateRequestVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReallocateRequestVoImplToJson(
      this,
    );
  }
}

abstract class _ReallocateRequestVo extends ReallocateRequestVo {
  factory _ReallocateRequestVo({String? productCode, double? amount}) =
      _$ReallocateRequestVoImpl;
  _ReallocateRequestVo._() : super._();

  factory _ReallocateRequestVo.fromJson(Map<String, dynamic> json) =
      _$ReallocateRequestVoImpl.fromJson;

  @override
  String? get productCode;
  set productCode(String? value);
  @override
  double? get amount;
  set amount(double? value);
  @override
  @JsonKey(ignore: true)
  _$$ReallocateRequestVoImplCopyWith<_$ReallocateRequestVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
