// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_beneficiary_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductBeneficiaryVo _$ProductBeneficiaryVoFromJson(Map<String, dynamic> json) {
  return _ProductBeneficiaryVo.fromJson(json);
}

/// @nodoc
mixin _$ProductBeneficiaryVo {
  int? get beneficiaryId => throw _privateConstructorUsedError;
  set beneficiaryId(int? value) => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  set name(String? value) => throw _privateConstructorUsedError;
  double? get distributionPercentage => throw _privateConstructorUsedError;
  set distributionPercentage(double? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductBeneficiaryVoCopyWith<ProductBeneficiaryVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductBeneficiaryVoCopyWith<$Res> {
  factory $ProductBeneficiaryVoCopyWith(ProductBeneficiaryVo value,
          $Res Function(ProductBeneficiaryVo) then) =
      _$ProductBeneficiaryVoCopyWithImpl<$Res, ProductBeneficiaryVo>;
  @useResult
  $Res call({int? beneficiaryId, String? name, double? distributionPercentage});
}

/// @nodoc
class _$ProductBeneficiaryVoCopyWithImpl<$Res,
        $Val extends ProductBeneficiaryVo>
    implements $ProductBeneficiaryVoCopyWith<$Res> {
  _$ProductBeneficiaryVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? beneficiaryId = freezed,
    Object? name = freezed,
    Object? distributionPercentage = freezed,
  }) {
    return _then(_value.copyWith(
      beneficiaryId: freezed == beneficiaryId
          ? _value.beneficiaryId
          : beneficiaryId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      distributionPercentage: freezed == distributionPercentage
          ? _value.distributionPercentage
          : distributionPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductBeneficiaryVoImplCopyWith<$Res>
    implements $ProductBeneficiaryVoCopyWith<$Res> {
  factory _$$ProductBeneficiaryVoImplCopyWith(_$ProductBeneficiaryVoImpl value,
          $Res Function(_$ProductBeneficiaryVoImpl) then) =
      __$$ProductBeneficiaryVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? beneficiaryId, String? name, double? distributionPercentage});
}

/// @nodoc
class __$$ProductBeneficiaryVoImplCopyWithImpl<$Res>
    extends _$ProductBeneficiaryVoCopyWithImpl<$Res, _$ProductBeneficiaryVoImpl>
    implements _$$ProductBeneficiaryVoImplCopyWith<$Res> {
  __$$ProductBeneficiaryVoImplCopyWithImpl(_$ProductBeneficiaryVoImpl _value,
      $Res Function(_$ProductBeneficiaryVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? beneficiaryId = freezed,
    Object? name = freezed,
    Object? distributionPercentage = freezed,
  }) {
    return _then(_$ProductBeneficiaryVoImpl(
      beneficiaryId: freezed == beneficiaryId
          ? _value.beneficiaryId
          : beneficiaryId // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      distributionPercentage: freezed == distributionPercentage
          ? _value.distributionPercentage
          : distributionPercentage // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductBeneficiaryVoImpl extends _ProductBeneficiaryVo {
  _$ProductBeneficiaryVoImpl(
      {this.beneficiaryId, this.name, this.distributionPercentage})
      : super._();

  factory _$ProductBeneficiaryVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductBeneficiaryVoImplFromJson(json);

  @override
  int? beneficiaryId;
  @override
  String? name;
  @override
  double? distributionPercentage;

  @override
  String toString() {
    return 'ProductBeneficiaryVo(beneficiaryId: $beneficiaryId, name: $name, distributionPercentage: $distributionPercentage)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductBeneficiaryVoImplCopyWith<_$ProductBeneficiaryVoImpl>
      get copyWith =>
          __$$ProductBeneficiaryVoImplCopyWithImpl<_$ProductBeneficiaryVoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductBeneficiaryVoImplToJson(
      this,
    );
  }
}

abstract class _ProductBeneficiaryVo extends ProductBeneficiaryVo {
  factory _ProductBeneficiaryVo(
      {int? beneficiaryId,
      String? name,
      double? distributionPercentage}) = _$ProductBeneficiaryVoImpl;
  _ProductBeneficiaryVo._() : super._();

  factory _ProductBeneficiaryVo.fromJson(Map<String, dynamic> json) =
      _$ProductBeneficiaryVoImpl.fromJson;

  @override
  int? get beneficiaryId;
  set beneficiaryId(int? value);
  @override
  String? get name;
  set name(String? value);
  @override
  double? get distributionPercentage;
  set distributionPercentage(double? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductBeneficiaryVoImplCopyWith<_$ProductBeneficiaryVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
