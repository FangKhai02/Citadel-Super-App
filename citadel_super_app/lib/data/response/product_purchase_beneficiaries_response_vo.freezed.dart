// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_purchase_beneficiaries_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductPurchaseBeneficiariesResponseVo
    _$ProductPurchaseBeneficiariesResponseVoFromJson(
        Map<String, dynamic> json) {
  return _ProductPurchaseBeneficiariesResponseVo.fromJson(json);
}

/// @nodoc
mixin _$ProductPurchaseBeneficiariesResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<FundBeneficiaryDetailsVo>? get productBeneficiaries =>
      throw _privateConstructorUsedError;
  set productBeneficiaries(List<FundBeneficiaryDetailsVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductPurchaseBeneficiariesResponseVoCopyWith<
          ProductPurchaseBeneficiariesResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductPurchaseBeneficiariesResponseVoCopyWith<$Res> {
  factory $ProductPurchaseBeneficiariesResponseVoCopyWith(
          ProductPurchaseBeneficiariesResponseVo value,
          $Res Function(ProductPurchaseBeneficiariesResponseVo) then) =
      _$ProductPurchaseBeneficiariesResponseVoCopyWithImpl<$Res,
          ProductPurchaseBeneficiariesResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<FundBeneficiaryDetailsVo>? productBeneficiaries});
}

/// @nodoc
class _$ProductPurchaseBeneficiariesResponseVoCopyWithImpl<$Res,
        $Val extends ProductPurchaseBeneficiariesResponseVo>
    implements $ProductPurchaseBeneficiariesResponseVoCopyWith<$Res> {
  _$ProductPurchaseBeneficiariesResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? productBeneficiaries = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      productBeneficiaries: freezed == productBeneficiaries
          ? _value.productBeneficiaries
          : productBeneficiaries // ignore: cast_nullable_to_non_nullable
              as List<FundBeneficiaryDetailsVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductPurchaseBeneficiariesResponseVoImplCopyWith<$Res>
    implements $ProductPurchaseBeneficiariesResponseVoCopyWith<$Res> {
  factory _$$ProductPurchaseBeneficiariesResponseVoImplCopyWith(
          _$ProductPurchaseBeneficiariesResponseVoImpl value,
          $Res Function(_$ProductPurchaseBeneficiariesResponseVoImpl) then) =
      __$$ProductPurchaseBeneficiariesResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<FundBeneficiaryDetailsVo>? productBeneficiaries});
}

/// @nodoc
class __$$ProductPurchaseBeneficiariesResponseVoImplCopyWithImpl<$Res>
    extends _$ProductPurchaseBeneficiariesResponseVoCopyWithImpl<$Res,
        _$ProductPurchaseBeneficiariesResponseVoImpl>
    implements _$$ProductPurchaseBeneficiariesResponseVoImplCopyWith<$Res> {
  __$$ProductPurchaseBeneficiariesResponseVoImplCopyWithImpl(
      _$ProductPurchaseBeneficiariesResponseVoImpl _value,
      $Res Function(_$ProductPurchaseBeneficiariesResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? productBeneficiaries = freezed,
  }) {
    return _then(_$ProductPurchaseBeneficiariesResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      productBeneficiaries: freezed == productBeneficiaries
          ? _value.productBeneficiaries
          : productBeneficiaries // ignore: cast_nullable_to_non_nullable
              as List<FundBeneficiaryDetailsVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductPurchaseBeneficiariesResponseVoImpl
    extends _ProductPurchaseBeneficiariesResponseVo {
  _$ProductPurchaseBeneficiariesResponseVoImpl(
      {this.code, this.message, this.productBeneficiaries})
      : super._();

  factory _$ProductPurchaseBeneficiariesResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ProductPurchaseBeneficiariesResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<FundBeneficiaryDetailsVo>? productBeneficiaries;

  @override
  String toString() {
    return 'ProductPurchaseBeneficiariesResponseVo(code: $code, message: $message, productBeneficiaries: $productBeneficiaries)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductPurchaseBeneficiariesResponseVoImplCopyWith<
          _$ProductPurchaseBeneficiariesResponseVoImpl>
      get copyWith =>
          __$$ProductPurchaseBeneficiariesResponseVoImplCopyWithImpl<
              _$ProductPurchaseBeneficiariesResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductPurchaseBeneficiariesResponseVoImplToJson(
      this,
    );
  }
}

abstract class _ProductPurchaseBeneficiariesResponseVo
    extends ProductPurchaseBeneficiariesResponseVo {
  factory _ProductPurchaseBeneficiariesResponseVo(
          {String? code,
          String? message,
          List<FundBeneficiaryDetailsVo>? productBeneficiaries}) =
      _$ProductPurchaseBeneficiariesResponseVoImpl;
  _ProductPurchaseBeneficiariesResponseVo._() : super._();

  factory _ProductPurchaseBeneficiariesResponseVo.fromJson(
          Map<String, dynamic> json) =
      _$ProductPurchaseBeneficiariesResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<FundBeneficiaryDetailsVo>? get productBeneficiaries;
  set productBeneficiaries(List<FundBeneficiaryDetailsVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductPurchaseBeneficiariesResponseVoImplCopyWith<
          _$ProductPurchaseBeneficiariesResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
