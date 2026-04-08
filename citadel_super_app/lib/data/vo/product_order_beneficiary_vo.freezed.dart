// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_order_beneficiary_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductOrderBeneficiaryVo _$ProductOrderBeneficiaryVoFromJson(
    Map<String, dynamic> json) {
  return _ProductOrderBeneficiaryVo.fromJson(json);
}

/// @nodoc
mixin _$ProductOrderBeneficiaryVo {
  int? get beneficiaryId => throw _privateConstructorUsedError;
  set beneficiaryId(int? value) => throw _privateConstructorUsedError;
  double? get distributionPercentage => throw _privateConstructorUsedError;
  set distributionPercentage(double? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductOrderBeneficiaryVoCopyWith<ProductOrderBeneficiaryVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductOrderBeneficiaryVoCopyWith<$Res> {
  factory $ProductOrderBeneficiaryVoCopyWith(ProductOrderBeneficiaryVo value,
          $Res Function(ProductOrderBeneficiaryVo) then) =
      _$ProductOrderBeneficiaryVoCopyWithImpl<$Res, ProductOrderBeneficiaryVo>;
  @useResult
  $Res call({int? beneficiaryId, double? distributionPercentage});
}

/// @nodoc
class _$ProductOrderBeneficiaryVoCopyWithImpl<$Res,
        $Val extends ProductOrderBeneficiaryVo>
    implements $ProductOrderBeneficiaryVoCopyWith<$Res> {
  _$ProductOrderBeneficiaryVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? beneficiaryId = freezed,
    Object? distributionPercentage = freezed,
  }) {
    return _then(_value.copyWith(
      beneficiaryId: freezed == beneficiaryId
          ? _value.beneficiaryId
          : beneficiaryId // ignore: cast_nullable_to_non_nullable
              as int?,
      distributionPercentage: freezed == distributionPercentage
          ? _value.distributionPercentage
          : distributionPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductOrderBeneficiaryVoImplCopyWith<$Res>
    implements $ProductOrderBeneficiaryVoCopyWith<$Res> {
  factory _$$ProductOrderBeneficiaryVoImplCopyWith(
          _$ProductOrderBeneficiaryVoImpl value,
          $Res Function(_$ProductOrderBeneficiaryVoImpl) then) =
      __$$ProductOrderBeneficiaryVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? beneficiaryId, double? distributionPercentage});
}

/// @nodoc
class __$$ProductOrderBeneficiaryVoImplCopyWithImpl<$Res>
    extends _$ProductOrderBeneficiaryVoCopyWithImpl<$Res,
        _$ProductOrderBeneficiaryVoImpl>
    implements _$$ProductOrderBeneficiaryVoImplCopyWith<$Res> {
  __$$ProductOrderBeneficiaryVoImplCopyWithImpl(
      _$ProductOrderBeneficiaryVoImpl _value,
      $Res Function(_$ProductOrderBeneficiaryVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? beneficiaryId = freezed,
    Object? distributionPercentage = freezed,
  }) {
    return _then(_$ProductOrderBeneficiaryVoImpl(
      beneficiaryId: freezed == beneficiaryId
          ? _value.beneficiaryId
          : beneficiaryId // ignore: cast_nullable_to_non_nullable
              as int?,
      distributionPercentage: freezed == distributionPercentage
          ? _value.distributionPercentage
          : distributionPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductOrderBeneficiaryVoImpl extends _ProductOrderBeneficiaryVo {
  _$ProductOrderBeneficiaryVoImpl(
      {this.beneficiaryId, this.distributionPercentage})
      : super._();

  factory _$ProductOrderBeneficiaryVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductOrderBeneficiaryVoImplFromJson(json);

  @override
  int? beneficiaryId;
  @override
  double? distributionPercentage;

  @override
  String toString() {
    return 'ProductOrderBeneficiaryVo(beneficiaryId: $beneficiaryId, distributionPercentage: $distributionPercentage)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductOrderBeneficiaryVoImplCopyWith<_$ProductOrderBeneficiaryVoImpl>
      get copyWith => __$$ProductOrderBeneficiaryVoImplCopyWithImpl<
          _$ProductOrderBeneficiaryVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductOrderBeneficiaryVoImplToJson(
      this,
    );
  }
}

abstract class _ProductOrderBeneficiaryVo extends ProductOrderBeneficiaryVo {
  factory _ProductOrderBeneficiaryVo(
      {int? beneficiaryId,
      double? distributionPercentage}) = _$ProductOrderBeneficiaryVoImpl;
  _ProductOrderBeneficiaryVo._() : super._();

  factory _ProductOrderBeneficiaryVo.fromJson(Map<String, dynamic> json) =
      _$ProductOrderBeneficiaryVoImpl.fromJson;

  @override
  int? get beneficiaryId;
  set beneficiaryId(int? value);
  @override
  double? get distributionPercentage;
  set distributionPercentage(double? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductOrderBeneficiaryVoImplCopyWith<_$ProductOrderBeneficiaryVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
