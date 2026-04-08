// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_profile_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateProfileResponseVo _$CorporateProfileResponseVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateProfileResponseVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateProfileResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  CorporateClientVo? get corporateClient => throw _privateConstructorUsedError;
  set corporateClient(CorporateClientVo? value) =>
      throw _privateConstructorUsedError;
  CorporateDetailsVo? get corporateDetails =>
      throw _privateConstructorUsedError;
  set corporateDetails(CorporateDetailsVo? value) =>
      throw _privateConstructorUsedError;
  List<CorporateDocumentsVo>? get corporateDocuments =>
      throw _privateConstructorUsedError;
  set corporateDocuments(List<CorporateDocumentsVo>? value) =>
      throw _privateConstructorUsedError;
  List<CorporateShareholderBaseVo>? get bindedCorporateShareholders =>
      throw _privateConstructorUsedError;
  set bindedCorporateShareholders(List<CorporateShareholderBaseVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateProfileResponseVoCopyWith<CorporateProfileResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateProfileResponseVoCopyWith<$Res> {
  factory $CorporateProfileResponseVoCopyWith(CorporateProfileResponseVo value,
          $Res Function(CorporateProfileResponseVo) then) =
      _$CorporateProfileResponseVoCopyWithImpl<$Res,
          CorporateProfileResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      CorporateClientVo? corporateClient,
      CorporateDetailsVo? corporateDetails,
      List<CorporateDocumentsVo>? corporateDocuments,
      List<CorporateShareholderBaseVo>? bindedCorporateShareholders});

  $CorporateClientVoCopyWith<$Res>? get corporateClient;
  $CorporateDetailsVoCopyWith<$Res>? get corporateDetails;
}

/// @nodoc
class _$CorporateProfileResponseVoCopyWithImpl<$Res,
        $Val extends CorporateProfileResponseVo>
    implements $CorporateProfileResponseVoCopyWith<$Res> {
  _$CorporateProfileResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? corporateClient = freezed,
    Object? corporateDetails = freezed,
    Object? corporateDocuments = freezed,
    Object? bindedCorporateShareholders = freezed,
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
      corporateClient: freezed == corporateClient
          ? _value.corporateClient
          : corporateClient // ignore: cast_nullable_to_non_nullable
              as CorporateClientVo?,
      corporateDetails: freezed == corporateDetails
          ? _value.corporateDetails
          : corporateDetails // ignore: cast_nullable_to_non_nullable
              as CorporateDetailsVo?,
      corporateDocuments: freezed == corporateDocuments
          ? _value.corporateDocuments
          : corporateDocuments // ignore: cast_nullable_to_non_nullable
              as List<CorporateDocumentsVo>?,
      bindedCorporateShareholders: freezed == bindedCorporateShareholders
          ? _value.bindedCorporateShareholders
          : bindedCorporateShareholders // ignore: cast_nullable_to_non_nullable
              as List<CorporateShareholderBaseVo>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CorporateClientVoCopyWith<$Res>? get corporateClient {
    if (_value.corporateClient == null) {
      return null;
    }

    return $CorporateClientVoCopyWith<$Res>(_value.corporateClient!, (value) {
      return _then(_value.copyWith(corporateClient: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CorporateDetailsVoCopyWith<$Res>? get corporateDetails {
    if (_value.corporateDetails == null) {
      return null;
    }

    return $CorporateDetailsVoCopyWith<$Res>(_value.corporateDetails!, (value) {
      return _then(_value.copyWith(corporateDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CorporateProfileResponseVoImplCopyWith<$Res>
    implements $CorporateProfileResponseVoCopyWith<$Res> {
  factory _$$CorporateProfileResponseVoImplCopyWith(
          _$CorporateProfileResponseVoImpl value,
          $Res Function(_$CorporateProfileResponseVoImpl) then) =
      __$$CorporateProfileResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      CorporateClientVo? corporateClient,
      CorporateDetailsVo? corporateDetails,
      List<CorporateDocumentsVo>? corporateDocuments,
      List<CorporateShareholderBaseVo>? bindedCorporateShareholders});

  @override
  $CorporateClientVoCopyWith<$Res>? get corporateClient;
  @override
  $CorporateDetailsVoCopyWith<$Res>? get corporateDetails;
}

/// @nodoc
class __$$CorporateProfileResponseVoImplCopyWithImpl<$Res>
    extends _$CorporateProfileResponseVoCopyWithImpl<$Res,
        _$CorporateProfileResponseVoImpl>
    implements _$$CorporateProfileResponseVoImplCopyWith<$Res> {
  __$$CorporateProfileResponseVoImplCopyWithImpl(
      _$CorporateProfileResponseVoImpl _value,
      $Res Function(_$CorporateProfileResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? corporateClient = freezed,
    Object? corporateDetails = freezed,
    Object? corporateDocuments = freezed,
    Object? bindedCorporateShareholders = freezed,
  }) {
    return _then(_$CorporateProfileResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateClient: freezed == corporateClient
          ? _value.corporateClient
          : corporateClient // ignore: cast_nullable_to_non_nullable
              as CorporateClientVo?,
      corporateDetails: freezed == corporateDetails
          ? _value.corporateDetails
          : corporateDetails // ignore: cast_nullable_to_non_nullable
              as CorporateDetailsVo?,
      corporateDocuments: freezed == corporateDocuments
          ? _value.corporateDocuments
          : corporateDocuments // ignore: cast_nullable_to_non_nullable
              as List<CorporateDocumentsVo>?,
      bindedCorporateShareholders: freezed == bindedCorporateShareholders
          ? _value.bindedCorporateShareholders
          : bindedCorporateShareholders // ignore: cast_nullable_to_non_nullable
              as List<CorporateShareholderBaseVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateProfileResponseVoImpl extends _CorporateProfileResponseVo {
  _$CorporateProfileResponseVoImpl(
      {this.code,
      this.message,
      this.corporateClient,
      this.corporateDetails,
      this.corporateDocuments,
      this.bindedCorporateShareholders})
      : super._();

  factory _$CorporateProfileResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateProfileResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  CorporateClientVo? corporateClient;
  @override
  CorporateDetailsVo? corporateDetails;
  @override
  List<CorporateDocumentsVo>? corporateDocuments;
  @override
  List<CorporateShareholderBaseVo>? bindedCorporateShareholders;

  @override
  String toString() {
    return 'CorporateProfileResponseVo(code: $code, message: $message, corporateClient: $corporateClient, corporateDetails: $corporateDetails, corporateDocuments: $corporateDocuments, bindedCorporateShareholders: $bindedCorporateShareholders)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateProfileResponseVoImplCopyWith<_$CorporateProfileResponseVoImpl>
      get copyWith => __$$CorporateProfileResponseVoImplCopyWithImpl<
          _$CorporateProfileResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateProfileResponseVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateProfileResponseVo extends CorporateProfileResponseVo {
  factory _CorporateProfileResponseVo(
          {String? code,
          String? message,
          CorporateClientVo? corporateClient,
          CorporateDetailsVo? corporateDetails,
          List<CorporateDocumentsVo>? corporateDocuments,
          List<CorporateShareholderBaseVo>? bindedCorporateShareholders}) =
      _$CorporateProfileResponseVoImpl;
  _CorporateProfileResponseVo._() : super._();

  factory _CorporateProfileResponseVo.fromJson(Map<String, dynamic> json) =
      _$CorporateProfileResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  CorporateClientVo? get corporateClient;
  set corporateClient(CorporateClientVo? value);
  @override
  CorporateDetailsVo? get corporateDetails;
  set corporateDetails(CorporateDetailsVo? value);
  @override
  List<CorporateDocumentsVo>? get corporateDocuments;
  set corporateDocuments(List<CorporateDocumentsVo>? value);
  @override
  List<CorporateShareholderBaseVo>? get bindedCorporateShareholders;
  set bindedCorporateShareholders(List<CorporateShareholderBaseVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateProfileResponseVoImplCopyWith<_$CorporateProfileResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
