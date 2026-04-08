// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agreement_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgreementResponseVo _$AgreementResponseVoFromJson(Map<String, dynamic> json) {
  return _AgreementResponseVo.fromJson(json);
}

/// @nodoc
mixin _$AgreementResponseVo {
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
  $AgreementResponseVoCopyWith<AgreementResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgreementResponseVoCopyWith<$Res> {
  factory $AgreementResponseVoCopyWith(
          AgreementResponseVo value, $Res Function(AgreementResponseVo) then) =
      _$AgreementResponseVoCopyWithImpl<$Res, AgreementResponseVo>;
  @useResult
  $Res call({String? code, String? message, String? link, String? html});
}

/// @nodoc
class _$AgreementResponseVoCopyWithImpl<$Res, $Val extends AgreementResponseVo>
    implements $AgreementResponseVoCopyWith<$Res> {
  _$AgreementResponseVoCopyWithImpl(this._value, this._then);

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
abstract class _$$AgreementResponseVoImplCopyWith<$Res>
    implements $AgreementResponseVoCopyWith<$Res> {
  factory _$$AgreementResponseVoImplCopyWith(_$AgreementResponseVoImpl value,
          $Res Function(_$AgreementResponseVoImpl) then) =
      __$$AgreementResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, String? link, String? html});
}

/// @nodoc
class __$$AgreementResponseVoImplCopyWithImpl<$Res>
    extends _$AgreementResponseVoCopyWithImpl<$Res, _$AgreementResponseVoImpl>
    implements _$$AgreementResponseVoImplCopyWith<$Res> {
  __$$AgreementResponseVoImplCopyWithImpl(_$AgreementResponseVoImpl _value,
      $Res Function(_$AgreementResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? link = freezed,
    Object? html = freezed,
  }) {
    return _then(_$AgreementResponseVoImpl(
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
class _$AgreementResponseVoImpl extends _AgreementResponseVo {
  _$AgreementResponseVoImpl({this.code, this.message, this.link, this.html})
      : super._();

  factory _$AgreementResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgreementResponseVoImplFromJson(json);

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
    return 'AgreementResponseVo(code: $code, message: $message, link: $link, html: $html)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgreementResponseVoImplCopyWith<_$AgreementResponseVoImpl> get copyWith =>
      __$$AgreementResponseVoImplCopyWithImpl<_$AgreementResponseVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgreementResponseVoImplToJson(
      this,
    );
  }
}

abstract class _AgreementResponseVo extends AgreementResponseVo {
  factory _AgreementResponseVo(
      {String? code,
      String? message,
      String? link,
      String? html}) = _$AgreementResponseVoImpl;
  _AgreementResponseVo._() : super._();

  factory _AgreementResponseVo.fromJson(Map<String, dynamic> json) =
      _$AgreementResponseVoImpl.fromJson;

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
  _$$AgreementResponseVoImplCopyWith<_$AgreementResponseVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
