// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_order_beneficiary_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductOrderBeneficiaryRequestVo _$ProductOrderBeneficiaryRequestVoFromJson(
    Map<String, dynamic> json) {
  return _ProductOrderBeneficiaryRequestVo.fromJson(json);
}

/// @nodoc
mixin _$ProductOrderBeneficiaryRequestVo {
  int? get beneficiaryId => throw _privateConstructorUsedError;
  set beneficiaryId(int? value) => throw _privateConstructorUsedError;
  double? get distributionPercentage => throw _privateConstructorUsedError;
  set distributionPercentage(double? value) =>
      throw _privateConstructorUsedError;
  List<ProductOrderBeneficiaryRequestVo>? get subBeneficiaries =>
      throw _privateConstructorUsedError;
  set subBeneficiaries(List<ProductOrderBeneficiaryRequestVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductOrderBeneficiaryRequestVoCopyWith<ProductOrderBeneficiaryRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductOrderBeneficiaryRequestVoCopyWith<$Res> {
  factory $ProductOrderBeneficiaryRequestVoCopyWith(
          ProductOrderBeneficiaryRequestVo value,
          $Res Function(ProductOrderBeneficiaryRequestVo) then) =
      _$ProductOrderBeneficiaryRequestVoCopyWithImpl<$Res,
          ProductOrderBeneficiaryRequestVo>;
  @useResult
  $Res call(
      {int? beneficiaryId,
      double? distributionPercentage,
      List<ProductOrderBeneficiaryRequestVo>? subBeneficiaries});
}

/// @nodoc
class _$ProductOrderBeneficiaryRequestVoCopyWithImpl<$Res,
        $Val extends ProductOrderBeneficiaryRequestVo>
    implements $ProductOrderBeneficiaryRequestVoCopyWith<$Res> {
  _$ProductOrderBeneficiaryRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? beneficiaryId = freezed,
    Object? distributionPercentage = freezed,
    Object? subBeneficiaries = freezed,
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
      subBeneficiaries: freezed == subBeneficiaries
          ? _value.subBeneficiaries
          : subBeneficiaries // ignore: cast_nullable_to_non_nullable
              as List<ProductOrderBeneficiaryRequestVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductOrderBeneficiaryRequestVoImplCopyWith<$Res>
    implements $ProductOrderBeneficiaryRequestVoCopyWith<$Res> {
  factory _$$ProductOrderBeneficiaryRequestVoImplCopyWith(
          _$ProductOrderBeneficiaryRequestVoImpl value,
          $Res Function(_$ProductOrderBeneficiaryRequestVoImpl) then) =
      __$$ProductOrderBeneficiaryRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? beneficiaryId,
      double? distributionPercentage,
      List<ProductOrderBeneficiaryRequestVo>? subBeneficiaries});
}

/// @nodoc
class __$$ProductOrderBeneficiaryRequestVoImplCopyWithImpl<$Res>
    extends _$ProductOrderBeneficiaryRequestVoCopyWithImpl<$Res,
        _$ProductOrderBeneficiaryRequestVoImpl>
    implements _$$ProductOrderBeneficiaryRequestVoImplCopyWith<$Res> {
  __$$ProductOrderBeneficiaryRequestVoImplCopyWithImpl(
      _$ProductOrderBeneficiaryRequestVoImpl _value,
      $Res Function(_$ProductOrderBeneficiaryRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? beneficiaryId = freezed,
    Object? distributionPercentage = freezed,
    Object? subBeneficiaries = freezed,
  }) {
    return _then(_$ProductOrderBeneficiaryRequestVoImpl(
      beneficiaryId: freezed == beneficiaryId
          ? _value.beneficiaryId
          : beneficiaryId // ignore: cast_nullable_to_non_nullable
              as int?,
      distributionPercentage: freezed == distributionPercentage
          ? _value.distributionPercentage
          : distributionPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
      subBeneficiaries: freezed == subBeneficiaries
          ? _value.subBeneficiaries
          : subBeneficiaries // ignore: cast_nullable_to_non_nullable
              as List<ProductOrderBeneficiaryRequestVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductOrderBeneficiaryRequestVoImpl
    extends _ProductOrderBeneficiaryRequestVo {
  _$ProductOrderBeneficiaryRequestVoImpl(
      {this.beneficiaryId, this.distributionPercentage, this.subBeneficiaries})
      : super._();

  factory _$ProductOrderBeneficiaryRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ProductOrderBeneficiaryRequestVoImplFromJson(json);

  @override
  int? beneficiaryId;
  @override
  double? distributionPercentage;
  @override
  List<ProductOrderBeneficiaryRequestVo>? subBeneficiaries;

  @override
  String toString() {
    return 'ProductOrderBeneficiaryRequestVo(beneficiaryId: $beneficiaryId, distributionPercentage: $distributionPercentage, subBeneficiaries: $subBeneficiaries)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductOrderBeneficiaryRequestVoImplCopyWith<
          _$ProductOrderBeneficiaryRequestVoImpl>
      get copyWith => __$$ProductOrderBeneficiaryRequestVoImplCopyWithImpl<
          _$ProductOrderBeneficiaryRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductOrderBeneficiaryRequestVoImplToJson(
      this,
    );
  }
}

abstract class _ProductOrderBeneficiaryRequestVo
    extends ProductOrderBeneficiaryRequestVo {
  factory _ProductOrderBeneficiaryRequestVo(
          {int? beneficiaryId,
          double? distributionPercentage,
          List<ProductOrderBeneficiaryRequestVo>? subBeneficiaries}) =
      _$ProductOrderBeneficiaryRequestVoImpl;
  _ProductOrderBeneficiaryRequestVo._() : super._();

  factory _ProductOrderBeneficiaryRequestVo.fromJson(
          Map<String, dynamic> json) =
      _$ProductOrderBeneficiaryRequestVoImpl.fromJson;

  @override
  int? get beneficiaryId;
  set beneficiaryId(int? value);
  @override
  double? get distributionPercentage;
  set distributionPercentage(double? value);
  @override
  List<ProductOrderBeneficiaryRequestVo>? get subBeneficiaries;
  set subBeneficiaries(List<ProductOrderBeneficiaryRequestVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductOrderBeneficiaryRequestVoImplCopyWith<
          _$ProductOrderBeneficiaryRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
