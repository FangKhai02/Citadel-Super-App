// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_order_documents_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductOrderDocumentsVo _$ProductOrderDocumentsVoFromJson(
    Map<String, dynamic> json) {
  return _ProductOrderDocumentsVo.fromJson(json);
}

/// @nodoc
mixin _$ProductOrderDocumentsVo {
  String? get profitSharingSchedule => throw _privateConstructorUsedError;
  set profitSharingSchedule(String? value) =>
      throw _privateConstructorUsedError;
  String? get officialReceipt => throw _privateConstructorUsedError;
  set officialReceipt(String? value) => throw _privateConstructorUsedError;
  String? get statementOfAccount => throw _privateConstructorUsedError;
  set statementOfAccount(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductOrderDocumentsVoCopyWith<ProductOrderDocumentsVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductOrderDocumentsVoCopyWith<$Res> {
  factory $ProductOrderDocumentsVoCopyWith(ProductOrderDocumentsVo value,
          $Res Function(ProductOrderDocumentsVo) then) =
      _$ProductOrderDocumentsVoCopyWithImpl<$Res, ProductOrderDocumentsVo>;
  @useResult
  $Res call(
      {String? profitSharingSchedule,
      String? officialReceipt,
      String? statementOfAccount});
}

/// @nodoc
class _$ProductOrderDocumentsVoCopyWithImpl<$Res,
        $Val extends ProductOrderDocumentsVo>
    implements $ProductOrderDocumentsVoCopyWith<$Res> {
  _$ProductOrderDocumentsVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profitSharingSchedule = freezed,
    Object? officialReceipt = freezed,
    Object? statementOfAccount = freezed,
  }) {
    return _then(_value.copyWith(
      profitSharingSchedule: freezed == profitSharingSchedule
          ? _value.profitSharingSchedule
          : profitSharingSchedule // ignore: cast_nullable_to_non_nullable
              as String?,
      officialReceipt: freezed == officialReceipt
          ? _value.officialReceipt
          : officialReceipt // ignore: cast_nullable_to_non_nullable
              as String?,
      statementOfAccount: freezed == statementOfAccount
          ? _value.statementOfAccount
          : statementOfAccount // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductOrderDocumentsVoImplCopyWith<$Res>
    implements $ProductOrderDocumentsVoCopyWith<$Res> {
  factory _$$ProductOrderDocumentsVoImplCopyWith(
          _$ProductOrderDocumentsVoImpl value,
          $Res Function(_$ProductOrderDocumentsVoImpl) then) =
      __$$ProductOrderDocumentsVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? profitSharingSchedule,
      String? officialReceipt,
      String? statementOfAccount});
}

/// @nodoc
class __$$ProductOrderDocumentsVoImplCopyWithImpl<$Res>
    extends _$ProductOrderDocumentsVoCopyWithImpl<$Res,
        _$ProductOrderDocumentsVoImpl>
    implements _$$ProductOrderDocumentsVoImplCopyWith<$Res> {
  __$$ProductOrderDocumentsVoImplCopyWithImpl(
      _$ProductOrderDocumentsVoImpl _value,
      $Res Function(_$ProductOrderDocumentsVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profitSharingSchedule = freezed,
    Object? officialReceipt = freezed,
    Object? statementOfAccount = freezed,
  }) {
    return _then(_$ProductOrderDocumentsVoImpl(
      profitSharingSchedule: freezed == profitSharingSchedule
          ? _value.profitSharingSchedule
          : profitSharingSchedule // ignore: cast_nullable_to_non_nullable
              as String?,
      officialReceipt: freezed == officialReceipt
          ? _value.officialReceipt
          : officialReceipt // ignore: cast_nullable_to_non_nullable
              as String?,
      statementOfAccount: freezed == statementOfAccount
          ? _value.statementOfAccount
          : statementOfAccount // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductOrderDocumentsVoImpl extends _ProductOrderDocumentsVo {
  _$ProductOrderDocumentsVoImpl(
      {this.profitSharingSchedule,
      this.officialReceipt,
      this.statementOfAccount})
      : super._();

  factory _$ProductOrderDocumentsVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductOrderDocumentsVoImplFromJson(json);

  @override
  String? profitSharingSchedule;
  @override
  String? officialReceipt;
  @override
  String? statementOfAccount;

  @override
  String toString() {
    return 'ProductOrderDocumentsVo(profitSharingSchedule: $profitSharingSchedule, officialReceipt: $officialReceipt, statementOfAccount: $statementOfAccount)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductOrderDocumentsVoImplCopyWith<_$ProductOrderDocumentsVoImpl>
      get copyWith => __$$ProductOrderDocumentsVoImplCopyWithImpl<
          _$ProductOrderDocumentsVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductOrderDocumentsVoImplToJson(
      this,
    );
  }
}

abstract class _ProductOrderDocumentsVo extends ProductOrderDocumentsVo {
  factory _ProductOrderDocumentsVo(
      {String? profitSharingSchedule,
      String? officialReceipt,
      String? statementOfAccount}) = _$ProductOrderDocumentsVoImpl;
  _ProductOrderDocumentsVo._() : super._();

  factory _ProductOrderDocumentsVo.fromJson(Map<String, dynamic> json) =
      _$ProductOrderDocumentsVoImpl.fromJson;

  @override
  String? get profitSharingSchedule;
  set profitSharingSchedule(String? value);
  @override
  String? get officialReceipt;
  set officialReceipt(String? value);
  @override
  String? get statementOfAccount;
  set statementOfAccount(String? value);
  @override
  @JsonKey(ignore: true)
  _$$ProductOrderDocumentsVoImplCopyWith<_$ProductOrderDocumentsVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
