// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_director_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateDirectorResponseVo _$CorporateDirectorResponseVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateDirectorResponseVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateDirectorResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  ClientPersonalDetailsVo? get personalDetails =>
      throw _privateConstructorUsedError;
  set personalDetails(ClientPersonalDetailsVo? value) =>
      throw _privateConstructorUsedError;
  PepDeclarationVo? get pepInfo => throw _privateConstructorUsedError;
  set pepInfo(PepDeclarationVo? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateDirectorResponseVoCopyWith<CorporateDirectorResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateDirectorResponseVoCopyWith<$Res> {
  factory $CorporateDirectorResponseVoCopyWith(
          CorporateDirectorResponseVo value,
          $Res Function(CorporateDirectorResponseVo) then) =
      _$CorporateDirectorResponseVoCopyWithImpl<$Res,
          CorporateDirectorResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      ClientPersonalDetailsVo? personalDetails,
      PepDeclarationVo? pepInfo});

  $ClientPersonalDetailsVoCopyWith<$Res>? get personalDetails;
  $PepDeclarationVoCopyWith<$Res>? get pepInfo;
}

/// @nodoc
class _$CorporateDirectorResponseVoCopyWithImpl<$Res,
        $Val extends CorporateDirectorResponseVo>
    implements $CorporateDirectorResponseVoCopyWith<$Res> {
  _$CorporateDirectorResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? personalDetails = freezed,
    Object? pepInfo = freezed,
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
      personalDetails: freezed == personalDetails
          ? _value.personalDetails
          : personalDetails // ignore: cast_nullable_to_non_nullable
              as ClientPersonalDetailsVo?,
      pepInfo: freezed == pepInfo
          ? _value.pepInfo
          : pepInfo // ignore: cast_nullable_to_non_nullable
              as PepDeclarationVo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientPersonalDetailsVoCopyWith<$Res>? get personalDetails {
    if (_value.personalDetails == null) {
      return null;
    }

    return $ClientPersonalDetailsVoCopyWith<$Res>(_value.personalDetails!,
        (value) {
      return _then(_value.copyWith(personalDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PepDeclarationVoCopyWith<$Res>? get pepInfo {
    if (_value.pepInfo == null) {
      return null;
    }

    return $PepDeclarationVoCopyWith<$Res>(_value.pepInfo!, (value) {
      return _then(_value.copyWith(pepInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CorporateDirectorResponseVoImplCopyWith<$Res>
    implements $CorporateDirectorResponseVoCopyWith<$Res> {
  factory _$$CorporateDirectorResponseVoImplCopyWith(
          _$CorporateDirectorResponseVoImpl value,
          $Res Function(_$CorporateDirectorResponseVoImpl) then) =
      __$$CorporateDirectorResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      ClientPersonalDetailsVo? personalDetails,
      PepDeclarationVo? pepInfo});

  @override
  $ClientPersonalDetailsVoCopyWith<$Res>? get personalDetails;
  @override
  $PepDeclarationVoCopyWith<$Res>? get pepInfo;
}

/// @nodoc
class __$$CorporateDirectorResponseVoImplCopyWithImpl<$Res>
    extends _$CorporateDirectorResponseVoCopyWithImpl<$Res,
        _$CorporateDirectorResponseVoImpl>
    implements _$$CorporateDirectorResponseVoImplCopyWith<$Res> {
  __$$CorporateDirectorResponseVoImplCopyWithImpl(
      _$CorporateDirectorResponseVoImpl _value,
      $Res Function(_$CorporateDirectorResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? personalDetails = freezed,
    Object? pepInfo = freezed,
  }) {
    return _then(_$CorporateDirectorResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      personalDetails: freezed == personalDetails
          ? _value.personalDetails
          : personalDetails // ignore: cast_nullable_to_non_nullable
              as ClientPersonalDetailsVo?,
      pepInfo: freezed == pepInfo
          ? _value.pepInfo
          : pepInfo // ignore: cast_nullable_to_non_nullable
              as PepDeclarationVo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateDirectorResponseVoImpl extends _CorporateDirectorResponseVo {
  _$CorporateDirectorResponseVoImpl(
      {this.code, this.message, this.personalDetails, this.pepInfo})
      : super._();

  factory _$CorporateDirectorResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateDirectorResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  ClientPersonalDetailsVo? personalDetails;
  @override
  PepDeclarationVo? pepInfo;

  @override
  String toString() {
    return 'CorporateDirectorResponseVo(code: $code, message: $message, personalDetails: $personalDetails, pepInfo: $pepInfo)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateDirectorResponseVoImplCopyWith<_$CorporateDirectorResponseVoImpl>
      get copyWith => __$$CorporateDirectorResponseVoImplCopyWithImpl<
          _$CorporateDirectorResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateDirectorResponseVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateDirectorResponseVo
    extends CorporateDirectorResponseVo {
  factory _CorporateDirectorResponseVo(
      {String? code,
      String? message,
      ClientPersonalDetailsVo? personalDetails,
      PepDeclarationVo? pepInfo}) = _$CorporateDirectorResponseVoImpl;
  _CorporateDirectorResponseVo._() : super._();

  factory _CorporateDirectorResponseVo.fromJson(Map<String, dynamic> json) =
      _$CorporateDirectorResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  ClientPersonalDetailsVo? get personalDetails;
  set personalDetails(ClientPersonalDetailsVo? value);
  @override
  PepDeclarationVo? get pepInfo;
  set pepInfo(PepDeclarationVo? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateDirectorResponseVoImplCopyWith<_$CorporateDirectorResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
