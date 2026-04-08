// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_agreement_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OnboardingAgreementResponseVo _$OnboardingAgreementResponseVoFromJson(
    Map<String, dynamic> json) {
  return _OnboardingAgreementResponseVo.fromJson(json);
}

/// @nodoc
mixin _$OnboardingAgreementResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  String? get html => throw _privateConstructorUsedError;
  set html(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnboardingAgreementResponseVoCopyWith<OnboardingAgreementResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingAgreementResponseVoCopyWith<$Res> {
  factory $OnboardingAgreementResponseVoCopyWith(
          OnboardingAgreementResponseVo value,
          $Res Function(OnboardingAgreementResponseVo) then) =
      _$OnboardingAgreementResponseVoCopyWithImpl<$Res,
          OnboardingAgreementResponseVo>;
  @useResult
  $Res call({String? code, String? message, String? html});
}

/// @nodoc
class _$OnboardingAgreementResponseVoCopyWithImpl<$Res,
        $Val extends OnboardingAgreementResponseVo>
    implements $OnboardingAgreementResponseVoCopyWith<$Res> {
  _$OnboardingAgreementResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? html = freezed,
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
      html: freezed == html
          ? _value.html
          : html // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnboardingAgreementResponseVoImplCopyWith<$Res>
    implements $OnboardingAgreementResponseVoCopyWith<$Res> {
  factory _$$OnboardingAgreementResponseVoImplCopyWith(
          _$OnboardingAgreementResponseVoImpl value,
          $Res Function(_$OnboardingAgreementResponseVoImpl) then) =
      __$$OnboardingAgreementResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, String? html});
}

/// @nodoc
class __$$OnboardingAgreementResponseVoImplCopyWithImpl<$Res>
    extends _$OnboardingAgreementResponseVoCopyWithImpl<$Res,
        _$OnboardingAgreementResponseVoImpl>
    implements _$$OnboardingAgreementResponseVoImplCopyWith<$Res> {
  __$$OnboardingAgreementResponseVoImplCopyWithImpl(
      _$OnboardingAgreementResponseVoImpl _value,
      $Res Function(_$OnboardingAgreementResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? html = freezed,
  }) {
    return _then(_$OnboardingAgreementResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      html: freezed == html
          ? _value.html
          : html // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnboardingAgreementResponseVoImpl
    extends _OnboardingAgreementResponseVo {
  _$OnboardingAgreementResponseVoImpl({this.code, this.message, this.html})
      : super._();

  factory _$OnboardingAgreementResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$OnboardingAgreementResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  String? html;

  @override
  String toString() {
    return 'OnboardingAgreementResponseVo(code: $code, message: $message, html: $html)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingAgreementResponseVoImplCopyWith<
          _$OnboardingAgreementResponseVoImpl>
      get copyWith => __$$OnboardingAgreementResponseVoImplCopyWithImpl<
          _$OnboardingAgreementResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnboardingAgreementResponseVoImplToJson(
      this,
    );
  }
}

abstract class _OnboardingAgreementResponseVo
    extends OnboardingAgreementResponseVo {
  factory _OnboardingAgreementResponseVo(
      {String? code,
      String? message,
      String? html}) = _$OnboardingAgreementResponseVoImpl;
  _OnboardingAgreementResponseVo._() : super._();

  factory _OnboardingAgreementResponseVo.fromJson(Map<String, dynamic> json) =
      _$OnboardingAgreementResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  String? get html;
  set html(String? value);
  @override
  @JsonKey(ignore: true)
  _$$OnboardingAgreementResponseVoImplCopyWith<
          _$OnboardingAgreementResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
