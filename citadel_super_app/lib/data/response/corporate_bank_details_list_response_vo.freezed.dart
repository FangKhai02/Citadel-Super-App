// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_bank_details_list_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateBankDetailsListResponseVo _$CorporateBankDetailsListResponseVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateBankDetailsListResponseVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateBankDetailsListResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<BankDetailsVo>? get corporateBankDetails =>
      throw _privateConstructorUsedError;
  set corporateBankDetails(List<BankDetailsVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateBankDetailsListResponseVoCopyWith<
          CorporateBankDetailsListResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateBankDetailsListResponseVoCopyWith<$Res> {
  factory $CorporateBankDetailsListResponseVoCopyWith(
          CorporateBankDetailsListResponseVo value,
          $Res Function(CorporateBankDetailsListResponseVo) then) =
      _$CorporateBankDetailsListResponseVoCopyWithImpl<$Res,
          CorporateBankDetailsListResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<BankDetailsVo>? corporateBankDetails});
}

/// @nodoc
class _$CorporateBankDetailsListResponseVoCopyWithImpl<$Res,
        $Val extends CorporateBankDetailsListResponseVo>
    implements $CorporateBankDetailsListResponseVoCopyWith<$Res> {
  _$CorporateBankDetailsListResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? corporateBankDetails = freezed,
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
      corporateBankDetails: freezed == corporateBankDetails
          ? _value.corporateBankDetails
          : corporateBankDetails // ignore: cast_nullable_to_non_nullable
              as List<BankDetailsVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorporateBankDetailsListResponseVoImplCopyWith<$Res>
    implements $CorporateBankDetailsListResponseVoCopyWith<$Res> {
  factory _$$CorporateBankDetailsListResponseVoImplCopyWith(
          _$CorporateBankDetailsListResponseVoImpl value,
          $Res Function(_$CorporateBankDetailsListResponseVoImpl) then) =
      __$$CorporateBankDetailsListResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<BankDetailsVo>? corporateBankDetails});
}

/// @nodoc
class __$$CorporateBankDetailsListResponseVoImplCopyWithImpl<$Res>
    extends _$CorporateBankDetailsListResponseVoCopyWithImpl<$Res,
        _$CorporateBankDetailsListResponseVoImpl>
    implements _$$CorporateBankDetailsListResponseVoImplCopyWith<$Res> {
  __$$CorporateBankDetailsListResponseVoImplCopyWithImpl(
      _$CorporateBankDetailsListResponseVoImpl _value,
      $Res Function(_$CorporateBankDetailsListResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? corporateBankDetails = freezed,
  }) {
    return _then(_$CorporateBankDetailsListResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateBankDetails: freezed == corporateBankDetails
          ? _value.corporateBankDetails
          : corporateBankDetails // ignore: cast_nullable_to_non_nullable
              as List<BankDetailsVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateBankDetailsListResponseVoImpl
    extends _CorporateBankDetailsListResponseVo {
  _$CorporateBankDetailsListResponseVoImpl(
      {this.code, this.message, this.corporateBankDetails})
      : super._();

  factory _$CorporateBankDetailsListResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateBankDetailsListResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<BankDetailsVo>? corporateBankDetails;

  @override
  String toString() {
    return 'CorporateBankDetailsListResponseVo(code: $code, message: $message, corporateBankDetails: $corporateBankDetails)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateBankDetailsListResponseVoImplCopyWith<
          _$CorporateBankDetailsListResponseVoImpl>
      get copyWith => __$$CorporateBankDetailsListResponseVoImplCopyWithImpl<
          _$CorporateBankDetailsListResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateBankDetailsListResponseVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateBankDetailsListResponseVo
    extends CorporateBankDetailsListResponseVo {
  factory _CorporateBankDetailsListResponseVo(
          {String? code,
          String? message,
          List<BankDetailsVo>? corporateBankDetails}) =
      _$CorporateBankDetailsListResponseVoImpl;
  _CorporateBankDetailsListResponseVo._() : super._();

  factory _CorporateBankDetailsListResponseVo.fromJson(
          Map<String, dynamic> json) =
      _$CorporateBankDetailsListResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<BankDetailsVo>? get corporateBankDetails;
  set corporateBankDetails(List<BankDetailsVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateBankDetailsListResponseVoImplCopyWith<
          _$CorporateBankDetailsListResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
