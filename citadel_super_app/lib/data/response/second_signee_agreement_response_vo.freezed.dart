// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'second_signee_agreement_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SecondSigneeAgreementResponseVo _$SecondSigneeAgreementResponseVoFromJson(
    Map<String, dynamic> json) {
  return _SecondSigneeAgreementResponseVo.fromJson(json);
}

/// @nodoc
mixin _$SecondSigneeAgreementResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;
  set link(String? value) => throw _privateConstructorUsedError;
  String? get html => throw _privateConstructorUsedError;
  set html(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SecondSigneeAgreementResponseVoCopyWith<SecondSigneeAgreementResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecondSigneeAgreementResponseVoCopyWith<$Res> {
  factory $SecondSigneeAgreementResponseVoCopyWith(
          SecondSigneeAgreementResponseVo value,
          $Res Function(SecondSigneeAgreementResponseVo) then) =
      _$SecondSigneeAgreementResponseVoCopyWithImpl<$Res,
          SecondSigneeAgreementResponseVo>;
  @useResult
  $Res call({String? code, String? message, String? link, String? html});
}

/// @nodoc
class _$SecondSigneeAgreementResponseVoCopyWithImpl<$Res,
        $Val extends SecondSigneeAgreementResponseVo>
    implements $SecondSigneeAgreementResponseVoCopyWith<$Res> {
  _$SecondSigneeAgreementResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? link = freezed,
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
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      html: freezed == html
          ? _value.html
          : html // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SecondSigneeAgreementResponseVoImplCopyWith<$Res>
    implements $SecondSigneeAgreementResponseVoCopyWith<$Res> {
  factory _$$SecondSigneeAgreementResponseVoImplCopyWith(
          _$SecondSigneeAgreementResponseVoImpl value,
          $Res Function(_$SecondSigneeAgreementResponseVoImpl) then) =
      __$$SecondSigneeAgreementResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, String? link, String? html});
}

/// @nodoc
class __$$SecondSigneeAgreementResponseVoImplCopyWithImpl<$Res>
    extends _$SecondSigneeAgreementResponseVoCopyWithImpl<$Res,
        _$SecondSigneeAgreementResponseVoImpl>
    implements _$$SecondSigneeAgreementResponseVoImplCopyWith<$Res> {
  __$$SecondSigneeAgreementResponseVoImplCopyWithImpl(
      _$SecondSigneeAgreementResponseVoImpl _value,
      $Res Function(_$SecondSigneeAgreementResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? link = freezed,
    Object? html = freezed,
  }) {
    return _then(_$SecondSigneeAgreementResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
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
class _$SecondSigneeAgreementResponseVoImpl
    extends _SecondSigneeAgreementResponseVo {
  _$SecondSigneeAgreementResponseVoImpl(
      {this.code, this.message, this.link, this.html})
      : super._();

  factory _$SecondSigneeAgreementResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SecondSigneeAgreementResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  String? link;
  @override
  String? html;

  @override
  String toString() {
    return 'SecondSigneeAgreementResponseVo(code: $code, message: $message, link: $link, html: $html)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SecondSigneeAgreementResponseVoImplCopyWith<
          _$SecondSigneeAgreementResponseVoImpl>
      get copyWith => __$$SecondSigneeAgreementResponseVoImplCopyWithImpl<
          _$SecondSigneeAgreementResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SecondSigneeAgreementResponseVoImplToJson(
      this,
    );
  }
}

abstract class _SecondSigneeAgreementResponseVo
    extends SecondSigneeAgreementResponseVo {
  factory _SecondSigneeAgreementResponseVo(
      {String? code,
      String? message,
      String? link,
      String? html}) = _$SecondSigneeAgreementResponseVoImpl;
  _SecondSigneeAgreementResponseVo._() : super._();

  factory _SecondSigneeAgreementResponseVo.fromJson(Map<String, dynamic> json) =
      _$SecondSigneeAgreementResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  String? get link;
  set link(String? value);
  @override
  String? get html;
  set html(String? value);
  @override
  @JsonKey(ignore: true)
  _$$SecondSigneeAgreementResponseVoImplCopyWith<
          _$SecondSigneeAgreementResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
