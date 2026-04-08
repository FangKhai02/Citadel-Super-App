// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_shareholders_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateShareholdersResponseVo _$CorporateShareholdersResponseVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateShareholdersResponseVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateShareholdersResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<CorporateShareholderBaseVo>? get draftShareholders =>
      throw _privateConstructorUsedError;
  set draftShareholders(List<CorporateShareholderBaseVo>? value) =>
      throw _privateConstructorUsedError;
  List<CorporateShareholderBaseVo>? get mappedShareholders =>
      throw _privateConstructorUsedError;
  set mappedShareholders(List<CorporateShareholderBaseVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateShareholdersResponseVoCopyWith<CorporateShareholdersResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateShareholdersResponseVoCopyWith<$Res> {
  factory $CorporateShareholdersResponseVoCopyWith(
          CorporateShareholdersResponseVo value,
          $Res Function(CorporateShareholdersResponseVo) then) =
      _$CorporateShareholdersResponseVoCopyWithImpl<$Res,
          CorporateShareholdersResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<CorporateShareholderBaseVo>? draftShareholders,
      List<CorporateShareholderBaseVo>? mappedShareholders});
}

/// @nodoc
class _$CorporateShareholdersResponseVoCopyWithImpl<$Res,
        $Val extends CorporateShareholdersResponseVo>
    implements $CorporateShareholdersResponseVoCopyWith<$Res> {
  _$CorporateShareholdersResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? draftShareholders = freezed,
    Object? mappedShareholders = freezed,
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
      draftShareholders: freezed == draftShareholders
          ? _value.draftShareholders
          : draftShareholders // ignore: cast_nullable_to_non_nullable
              as List<CorporateShareholderBaseVo>?,
      mappedShareholders: freezed == mappedShareholders
          ? _value.mappedShareholders
          : mappedShareholders // ignore: cast_nullable_to_non_nullable
              as List<CorporateShareholderBaseVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CorporateShareholdersResponseVoImplCopyWith<$Res>
    implements $CorporateShareholdersResponseVoCopyWith<$Res> {
  factory _$$CorporateShareholdersResponseVoImplCopyWith(
          _$CorporateShareholdersResponseVoImpl value,
          $Res Function(_$CorporateShareholdersResponseVoImpl) then) =
      __$$CorporateShareholdersResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<CorporateShareholderBaseVo>? draftShareholders,
      List<CorporateShareholderBaseVo>? mappedShareholders});
}

/// @nodoc
class __$$CorporateShareholdersResponseVoImplCopyWithImpl<$Res>
    extends _$CorporateShareholdersResponseVoCopyWithImpl<$Res,
        _$CorporateShareholdersResponseVoImpl>
    implements _$$CorporateShareholdersResponseVoImplCopyWith<$Res> {
  __$$CorporateShareholdersResponseVoImplCopyWithImpl(
      _$CorporateShareholdersResponseVoImpl _value,
      $Res Function(_$CorporateShareholdersResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? draftShareholders = freezed,
    Object? mappedShareholders = freezed,
  }) {
    return _then(_$CorporateShareholdersResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      draftShareholders: freezed == draftShareholders
          ? _value.draftShareholders
          : draftShareholders // ignore: cast_nullable_to_non_nullable
              as List<CorporateShareholderBaseVo>?,
      mappedShareholders: freezed == mappedShareholders
          ? _value.mappedShareholders
          : mappedShareholders // ignore: cast_nullable_to_non_nullable
              as List<CorporateShareholderBaseVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateShareholdersResponseVoImpl
    extends _CorporateShareholdersResponseVo {
  _$CorporateShareholdersResponseVoImpl(
      {this.code,
      this.message,
      this.draftShareholders,
      this.mappedShareholders})
      : super._();

  factory _$CorporateShareholdersResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateShareholdersResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<CorporateShareholderBaseVo>? draftShareholders;
  @override
  List<CorporateShareholderBaseVo>? mappedShareholders;

  @override
  String toString() {
    return 'CorporateShareholdersResponseVo(code: $code, message: $message, draftShareholders: $draftShareholders, mappedShareholders: $mappedShareholders)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateShareholdersResponseVoImplCopyWith<
          _$CorporateShareholdersResponseVoImpl>
      get copyWith => __$$CorporateShareholdersResponseVoImplCopyWithImpl<
          _$CorporateShareholdersResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateShareholdersResponseVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateShareholdersResponseVo
    extends CorporateShareholdersResponseVo {
  factory _CorporateShareholdersResponseVo(
          {String? code,
          String? message,
          List<CorporateShareholderBaseVo>? draftShareholders,
          List<CorporateShareholderBaseVo>? mappedShareholders}) =
      _$CorporateShareholdersResponseVoImpl;
  _CorporateShareholdersResponseVo._() : super._();

  factory _CorporateShareholdersResponseVo.fromJson(Map<String, dynamic> json) =
      _$CorporateShareholdersResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<CorporateShareholderBaseVo>? get draftShareholders;
  set draftShareholders(List<CorporateShareholderBaseVo>? value);
  @override
  List<CorporateShareholderBaseVo>? get mappedShareholders;
  set mappedShareholders(List<CorporateShareholderBaseVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateShareholdersResponseVoImplCopyWith<
          _$CorporateShareholdersResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
