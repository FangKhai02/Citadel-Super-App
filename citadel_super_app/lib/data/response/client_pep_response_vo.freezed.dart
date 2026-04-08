// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_pep_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClientPepResponseVo _$ClientPepResponseVoFromJson(Map<String, dynamic> json) {
  return _ClientPepResponseVo.fromJson(json);
}

/// @nodoc
mixin _$ClientPepResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  PepDeclarationVo? get pepDeclaration => throw _privateConstructorUsedError;
  set pepDeclaration(PepDeclarationVo? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientPepResponseVoCopyWith<ClientPepResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientPepResponseVoCopyWith<$Res> {
  factory $ClientPepResponseVoCopyWith(
          ClientPepResponseVo value, $Res Function(ClientPepResponseVo) then) =
      _$ClientPepResponseVoCopyWithImpl<$Res, ClientPepResponseVo>;
  @useResult
  $Res call({String? code, String? message, PepDeclarationVo? pepDeclaration});

  $PepDeclarationVoCopyWith<$Res>? get pepDeclaration;
}

/// @nodoc
class _$ClientPepResponseVoCopyWithImpl<$Res, $Val extends ClientPepResponseVo>
    implements $ClientPepResponseVoCopyWith<$Res> {
  _$ClientPepResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? pepDeclaration = freezed,
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
      pepDeclaration: freezed == pepDeclaration
          ? _value.pepDeclaration
          : pepDeclaration // ignore: cast_nullable_to_non_nullable
              as PepDeclarationVo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PepDeclarationVoCopyWith<$Res>? get pepDeclaration {
    if (_value.pepDeclaration == null) {
      return null;
    }

    return $PepDeclarationVoCopyWith<$Res>(_value.pepDeclaration!, (value) {
      return _then(_value.copyWith(pepDeclaration: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClientPepResponseVoImplCopyWith<$Res>
    implements $ClientPepResponseVoCopyWith<$Res> {
  factory _$$ClientPepResponseVoImplCopyWith(_$ClientPepResponseVoImpl value,
          $Res Function(_$ClientPepResponseVoImpl) then) =
      __$$ClientPepResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, PepDeclarationVo? pepDeclaration});

  @override
  $PepDeclarationVoCopyWith<$Res>? get pepDeclaration;
}

/// @nodoc
class __$$ClientPepResponseVoImplCopyWithImpl<$Res>
    extends _$ClientPepResponseVoCopyWithImpl<$Res, _$ClientPepResponseVoImpl>
    implements _$$ClientPepResponseVoImplCopyWith<$Res> {
  __$$ClientPepResponseVoImplCopyWithImpl(_$ClientPepResponseVoImpl _value,
      $Res Function(_$ClientPepResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? pepDeclaration = freezed,
  }) {
    return _then(_$ClientPepResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      pepDeclaration: freezed == pepDeclaration
          ? _value.pepDeclaration
          : pepDeclaration // ignore: cast_nullable_to_non_nullable
              as PepDeclarationVo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientPepResponseVoImpl extends _ClientPepResponseVo {
  _$ClientPepResponseVoImpl({this.code, this.message, this.pepDeclaration})
      : super._();

  factory _$ClientPepResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientPepResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  PepDeclarationVo? pepDeclaration;

  @override
  String toString() {
    return 'ClientPepResponseVo(code: $code, message: $message, pepDeclaration: $pepDeclaration)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientPepResponseVoImplCopyWith<_$ClientPepResponseVoImpl> get copyWith =>
      __$$ClientPepResponseVoImplCopyWithImpl<_$ClientPepResponseVoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientPepResponseVoImplToJson(
      this,
    );
  }
}

abstract class _ClientPepResponseVo extends ClientPepResponseVo {
  factory _ClientPepResponseVo(
      {String? code,
      String? message,
      PepDeclarationVo? pepDeclaration}) = _$ClientPepResponseVoImpl;
  _ClientPepResponseVo._() : super._();

  factory _ClientPepResponseVo.fromJson(Map<String, dynamic> json) =
      _$ClientPepResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  PepDeclarationVo? get pepDeclaration;
  set pepDeclaration(PepDeclarationVo? value);
  @override
  @JsonKey(ignore: true)
  _$$ClientPepResponseVoImplCopyWith<_$ClientPepResponseVoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
