// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_verification_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OtpVerificationRequest _$OtpVerificationRequestFromJson(
    Map<String, dynamic> json) {
  return _OtpVerificationRequest.fromJson(json);
}

/// @nodoc
mixin _$OtpVerificationRequest {
  String? get otp => throw _privateConstructorUsedError;
  set otp(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OtpVerificationRequestCopyWith<OtpVerificationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpVerificationRequestCopyWith<$Res> {
  factory $OtpVerificationRequestCopyWith(OtpVerificationRequest value,
          $Res Function(OtpVerificationRequest) then) =
      _$OtpVerificationRequestCopyWithImpl<$Res, OtpVerificationRequest>;
  @useResult
  $Res call({String? otp});
}

/// @nodoc
class _$OtpVerificationRequestCopyWithImpl<$Res,
        $Val extends OtpVerificationRequest>
    implements $OtpVerificationRequestCopyWith<$Res> {
  _$OtpVerificationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otp = freezed,
  }) {
    return _then(_value.copyWith(
      otp: freezed == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OtpVerificationRequestImplCopyWith<$Res>
    implements $OtpVerificationRequestCopyWith<$Res> {
  factory _$$OtpVerificationRequestImplCopyWith(
          _$OtpVerificationRequestImpl value,
          $Res Function(_$OtpVerificationRequestImpl) then) =
      __$$OtpVerificationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? otp});
}

/// @nodoc
class __$$OtpVerificationRequestImplCopyWithImpl<$Res>
    extends _$OtpVerificationRequestCopyWithImpl<$Res,
        _$OtpVerificationRequestImpl>
    implements _$$OtpVerificationRequestImplCopyWith<$Res> {
  __$$OtpVerificationRequestImplCopyWithImpl(
      _$OtpVerificationRequestImpl _value,
      $Res Function(_$OtpVerificationRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otp = freezed,
  }) {
    return _then(_$OtpVerificationRequestImpl(
      otp: freezed == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OtpVerificationRequestImpl extends _OtpVerificationRequest {
  _$OtpVerificationRequestImpl({this.otp}) : super._();

  factory _$OtpVerificationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$OtpVerificationRequestImplFromJson(json);

  @override
  String? otp;

  @override
  String toString() {
    return 'OtpVerificationRequest(otp: $otp)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OtpVerificationRequestImplCopyWith<_$OtpVerificationRequestImpl>
      get copyWith => __$$OtpVerificationRequestImplCopyWithImpl<
          _$OtpVerificationRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OtpVerificationRequestImplToJson(
      this,
    );
  }
}

abstract class _OtpVerificationRequest extends OtpVerificationRequest {
  factory _OtpVerificationRequest({String? otp}) = _$OtpVerificationRequestImpl;
  _OtpVerificationRequest._() : super._();

  factory _OtpVerificationRequest.fromJson(Map<String, dynamic> json) =
      _$OtpVerificationRequestImpl.fromJson;

  @override
  String? get otp;
  set otp(String? value);
  @override
  @JsonKey(ignore: true)
  _$$OtpVerificationRequestImplCopyWith<_$OtpVerificationRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
