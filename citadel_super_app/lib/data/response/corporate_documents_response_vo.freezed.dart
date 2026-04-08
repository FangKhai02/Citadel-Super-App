// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_documents_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateDocumentsResponseVo _$CorporateDocumentsResponseVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateDocumentsResponseVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateDocumentsResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<CorporateDocumentsVo>? get corporateDocuments =>
      throw _privateConstructorUsedError;
  set corporateDocuments(List<CorporateDocumentsVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateDocumentsResponseVoCopyWith<CorporateDocumentsResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateDocumentsResponseVoCopyWith<$Res> {
  factory $CorporateDocumentsResponseVoCopyWith(
          CorporateDocumentsResponseVo value,
          $Res Function(CorporateDocumentsResponseVo) then) =
      _$CorporateDocumentsResponseVoCopyWithImpl<$Res,
          CorporateDocumentsResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<CorporateDocumentsVo>? corporateDocuments});
}

/// @nodoc
class _$CorporateDocumentsResponseVoCopyWithImpl<$Res,
        $Val extends CorporateDocumentsResponseVo>
    implements $CorporateDocumentsResponseVoCopyWith<$Res> {
  _$CorporateDocumentsResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? corporateDocuments = freezed,
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
      corporateDocuments: freezed == corporateDocuments
          ? _value.corporateDocuments
          : corporateDocuments // ignore: cast_nullable_to_non_nullable
              as List<CorporateDocumentsVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorporateDocumentsResponseVoImplCopyWith<$Res>
    implements $CorporateDocumentsResponseVoCopyWith<$Res> {
  factory _$$CorporateDocumentsResponseVoImplCopyWith(
          _$CorporateDocumentsResponseVoImpl value,
          $Res Function(_$CorporateDocumentsResponseVoImpl) then) =
      __$$CorporateDocumentsResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<CorporateDocumentsVo>? corporateDocuments});
}

/// @nodoc
class __$$CorporateDocumentsResponseVoImplCopyWithImpl<$Res>
    extends _$CorporateDocumentsResponseVoCopyWithImpl<$Res,
        _$CorporateDocumentsResponseVoImpl>
    implements _$$CorporateDocumentsResponseVoImplCopyWith<$Res> {
  __$$CorporateDocumentsResponseVoImplCopyWithImpl(
      _$CorporateDocumentsResponseVoImpl _value,
      $Res Function(_$CorporateDocumentsResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? corporateDocuments = freezed,
  }) {
    return _then(_$CorporateDocumentsResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateDocuments: freezed == corporateDocuments
          ? _value.corporateDocuments
          : corporateDocuments // ignore: cast_nullable_to_non_nullable
              as List<CorporateDocumentsVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateDocumentsResponseVoImpl extends _CorporateDocumentsResponseVo {
  _$CorporateDocumentsResponseVoImpl(
      {this.code, this.message, this.corporateDocuments})
      : super._();

  factory _$CorporateDocumentsResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateDocumentsResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<CorporateDocumentsVo>? corporateDocuments;

  @override
  String toString() {
    return 'CorporateDocumentsResponseVo(code: $code, message: $message, corporateDocuments: $corporateDocuments)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateDocumentsResponseVoImplCopyWith<
          _$CorporateDocumentsResponseVoImpl>
      get copyWith => __$$CorporateDocumentsResponseVoImplCopyWithImpl<
          _$CorporateDocumentsResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateDocumentsResponseVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateDocumentsResponseVo
    extends CorporateDocumentsResponseVo {
  factory _CorporateDocumentsResponseVo(
          {String? code,
          String? message,
          List<CorporateDocumentsVo>? corporateDocuments}) =
      _$CorporateDocumentsResponseVoImpl;
  _CorporateDocumentsResponseVo._() : super._();

  factory _CorporateDocumentsResponseVo.fromJson(Map<String, dynamic> json) =
      _$CorporateDocumentsResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<CorporateDocumentsVo>? get corporateDocuments;
  set corporateDocuments(List<CorporateDocumentsVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateDocumentsResponseVoImplCopyWith<
          _$CorporateDocumentsResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
