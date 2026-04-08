// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_share_holder_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateShareHolderResponseVo _$CorporateShareHolderResponseVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateShareHolderResponseVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateShareHolderResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  CorporateShareholderVo? get corporateShareholder =>
      throw _privateConstructorUsedError;
  set corporateShareholder(CorporateShareholderVo? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateShareHolderResponseVoCopyWith<CorporateShareHolderResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateShareHolderResponseVoCopyWith<$Res> {
  factory $CorporateShareHolderResponseVoCopyWith(
          CorporateShareHolderResponseVo value,
          $Res Function(CorporateShareHolderResponseVo) then) =
      _$CorporateShareHolderResponseVoCopyWithImpl<$Res,
          CorporateShareHolderResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      CorporateShareholderVo? corporateShareholder});

  $CorporateShareholderVoCopyWith<$Res>? get corporateShareholder;
}

/// @nodoc
class _$CorporateShareHolderResponseVoCopyWithImpl<$Res,
        $Val extends CorporateShareHolderResponseVo>
    implements $CorporateShareHolderResponseVoCopyWith<$Res> {
  _$CorporateShareHolderResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? corporateShareholder = freezed,
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
      corporateShareholder: freezed == corporateShareholder
          ? _value.corporateShareholder
          : corporateShareholder // ignore: cast_nullable_to_non_nullable
              as CorporateShareholderVo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CorporateShareholderVoCopyWith<$Res>? get corporateShareholder {
    if (_value.corporateShareholder == null) {
      return null;
    }

    return $CorporateShareholderVoCopyWith<$Res>(_value.corporateShareholder!,
        (value) {
      return _then(_value.copyWith(corporateShareholder: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CorporateShareHolderResponseVoImplCopyWith<$Res>
    implements $CorporateShareHolderResponseVoCopyWith<$Res> {
  factory _$$CorporateShareHolderResponseVoImplCopyWith(
          _$CorporateShareHolderResponseVoImpl value,
          $Res Function(_$CorporateShareHolderResponseVoImpl) then) =
      __$$CorporateShareHolderResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      CorporateShareholderVo? corporateShareholder});

  @override
  $CorporateShareholderVoCopyWith<$Res>? get corporateShareholder;
}

/// @nodoc
class __$$CorporateShareHolderResponseVoImplCopyWithImpl<$Res>
    extends _$CorporateShareHolderResponseVoCopyWithImpl<$Res,
        _$CorporateShareHolderResponseVoImpl>
    implements _$$CorporateShareHolderResponseVoImplCopyWith<$Res> {
  __$$CorporateShareHolderResponseVoImplCopyWithImpl(
      _$CorporateShareHolderResponseVoImpl _value,
      $Res Function(_$CorporateShareHolderResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? corporateShareholder = freezed,
  }) {
    return _then(_$CorporateShareHolderResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateShareholder: freezed == corporateShareholder
          ? _value.corporateShareholder
          : corporateShareholder // ignore: cast_nullable_to_non_nullable
              as CorporateShareholderVo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateShareHolderResponseVoImpl
    extends _CorporateShareHolderResponseVo {
  _$CorporateShareHolderResponseVoImpl(
      {this.code, this.message, this.corporateShareholder})
      : super._();

  factory _$CorporateShareHolderResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateShareHolderResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  CorporateShareholderVo? corporateShareholder;

  @override
  String toString() {
    return 'CorporateShareHolderResponseVo(code: $code, message: $message, corporateShareholder: $corporateShareholder)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateShareHolderResponseVoImplCopyWith<
          _$CorporateShareHolderResponseVoImpl>
      get copyWith => __$$CorporateShareHolderResponseVoImplCopyWithImpl<
          _$CorporateShareHolderResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateShareHolderResponseVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateShareHolderResponseVo
    extends CorporateShareHolderResponseVo {
  factory _CorporateShareHolderResponseVo(
          {String? code,
          String? message,
          CorporateShareholderVo? corporateShareholder}) =
      _$CorporateShareHolderResponseVoImpl;
  _CorporateShareHolderResponseVo._() : super._();

  factory _CorporateShareHolderResponseVo.fromJson(Map<String, dynamic> json) =
      _$CorporateShareHolderResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  CorporateShareholderVo? get corporateShareholder;
  set corporateShareholder(CorporateShareholderVo? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateShareHolderResponseVoImplCopyWith<
          _$CorporateShareHolderResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
