// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_secure_tag_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClientSecureTagResponseVo _$ClientSecureTagResponseVoFromJson(
    Map<String, dynamic> json) {
  return _ClientSecureTagResponseVo.fromJson(json);
}

/// @nodoc
mixin _$ClientSecureTagResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  ClientSecureTagVo? get secureTag => throw _privateConstructorUsedError;
  set secureTag(ClientSecureTagVo? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientSecureTagResponseVoCopyWith<ClientSecureTagResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientSecureTagResponseVoCopyWith<$Res> {
  factory $ClientSecureTagResponseVoCopyWith(ClientSecureTagResponseVo value,
          $Res Function(ClientSecureTagResponseVo) then) =
      _$ClientSecureTagResponseVoCopyWithImpl<$Res, ClientSecureTagResponseVo>;
  @useResult
  $Res call({String? code, String? message, ClientSecureTagVo? secureTag});

  $ClientSecureTagVoCopyWith<$Res>? get secureTag;
}

/// @nodoc
class _$ClientSecureTagResponseVoCopyWithImpl<$Res,
        $Val extends ClientSecureTagResponseVo>
    implements $ClientSecureTagResponseVoCopyWith<$Res> {
  _$ClientSecureTagResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? secureTag = freezed,
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
      secureTag: freezed == secureTag
          ? _value.secureTag
          : secureTag // ignore: cast_nullable_to_non_nullable
              as ClientSecureTagVo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientSecureTagVoCopyWith<$Res>? get secureTag {
    if (_value.secureTag == null) {
      return null;
    }

    return $ClientSecureTagVoCopyWith<$Res>(_value.secureTag!, (value) {
      return _then(_value.copyWith(secureTag: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClientSecureTagResponseVoImplCopyWith<$Res>
    implements $ClientSecureTagResponseVoCopyWith<$Res> {
  factory _$$ClientSecureTagResponseVoImplCopyWith(
          _$ClientSecureTagResponseVoImpl value,
          $Res Function(_$ClientSecureTagResponseVoImpl) then) =
      __$$ClientSecureTagResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, ClientSecureTagVo? secureTag});

  @override
  $ClientSecureTagVoCopyWith<$Res>? get secureTag;
}

/// @nodoc
class __$$ClientSecureTagResponseVoImplCopyWithImpl<$Res>
    extends _$ClientSecureTagResponseVoCopyWithImpl<$Res,
        _$ClientSecureTagResponseVoImpl>
    implements _$$ClientSecureTagResponseVoImplCopyWith<$Res> {
  __$$ClientSecureTagResponseVoImplCopyWithImpl(
      _$ClientSecureTagResponseVoImpl _value,
      $Res Function(_$ClientSecureTagResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? secureTag = freezed,
  }) {
    return _then(_$ClientSecureTagResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      secureTag: freezed == secureTag
          ? _value.secureTag
          : secureTag // ignore: cast_nullable_to_non_nullable
              as ClientSecureTagVo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientSecureTagResponseVoImpl extends _ClientSecureTagResponseVo {
  _$ClientSecureTagResponseVoImpl({this.code, this.message, this.secureTag})
      : super._();

  factory _$ClientSecureTagResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientSecureTagResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  ClientSecureTagVo? secureTag;

  @override
  String toString() {
    return 'ClientSecureTagResponseVo(code: $code, message: $message, secureTag: $secureTag)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientSecureTagResponseVoImplCopyWith<_$ClientSecureTagResponseVoImpl>
      get copyWith => __$$ClientSecureTagResponseVoImplCopyWithImpl<
          _$ClientSecureTagResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientSecureTagResponseVoImplToJson(
      this,
    );
  }
}

abstract class _ClientSecureTagResponseVo extends ClientSecureTagResponseVo {
  factory _ClientSecureTagResponseVo(
      {String? code,
      String? message,
      ClientSecureTagVo? secureTag}) = _$ClientSecureTagResponseVoImpl;
  _ClientSecureTagResponseVo._() : super._();

  factory _ClientSecureTagResponseVo.fromJson(Map<String, dynamic> json) =
      _$ClientSecureTagResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  ClientSecureTagVo? get secureTag;
  set secureTag(ClientSecureTagVo? value);
  @override
  @JsonKey(ignore: true)
  _$$ClientSecureTagResponseVoImplCopyWith<_$ClientSecureTagResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
