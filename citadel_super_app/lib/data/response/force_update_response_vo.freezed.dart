// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'force_update_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ForceUpdateResponseVo _$ForceUpdateResponseVoFromJson(
    Map<String, dynamic> json) {
  return _ForceUpdateResponseVo.fromJson(json);
}

/// @nodoc
mixin _$ForceUpdateResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  bool? get updateRequired => throw _privateConstructorUsedError;
  set updateRequired(bool? value) => throw _privateConstructorUsedError;
  String? get updateLink => throw _privateConstructorUsedError;
  set updateLink(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ForceUpdateResponseVoCopyWith<ForceUpdateResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForceUpdateResponseVoCopyWith<$Res> {
  factory $ForceUpdateResponseVoCopyWith(ForceUpdateResponseVo value,
          $Res Function(ForceUpdateResponseVo) then) =
      _$ForceUpdateResponseVoCopyWithImpl<$Res, ForceUpdateResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      bool? updateRequired,
      String? updateLink});
}

/// @nodoc
class _$ForceUpdateResponseVoCopyWithImpl<$Res,
        $Val extends ForceUpdateResponseVo>
    implements $ForceUpdateResponseVoCopyWith<$Res> {
  _$ForceUpdateResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? updateRequired = freezed,
    Object? updateLink = freezed,
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
      updateRequired: freezed == updateRequired
          ? _value.updateRequired
          : updateRequired // ignore: cast_nullable_to_non_nullable
              as bool?,
      updateLink: freezed == updateLink
          ? _value.updateLink
          : updateLink // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForceUpdateResponseVoImplCopyWith<$Res>
    implements $ForceUpdateResponseVoCopyWith<$Res> {
  factory _$$ForceUpdateResponseVoImplCopyWith(
          _$ForceUpdateResponseVoImpl value,
          $Res Function(_$ForceUpdateResponseVoImpl) then) =
      __$$ForceUpdateResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      bool? updateRequired,
      String? updateLink});
}

/// @nodoc
class __$$ForceUpdateResponseVoImplCopyWithImpl<$Res>
    extends _$ForceUpdateResponseVoCopyWithImpl<$Res,
        _$ForceUpdateResponseVoImpl>
    implements _$$ForceUpdateResponseVoImplCopyWith<$Res> {
  __$$ForceUpdateResponseVoImplCopyWithImpl(_$ForceUpdateResponseVoImpl _value,
      $Res Function(_$ForceUpdateResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? updateRequired = freezed,
    Object? updateLink = freezed,
  }) {
    return _then(_$ForceUpdateResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      updateRequired: freezed == updateRequired
          ? _value.updateRequired
          : updateRequired // ignore: cast_nullable_to_non_nullable
              as bool?,
      updateLink: freezed == updateLink
          ? _value.updateLink
          : updateLink // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ForceUpdateResponseVoImpl extends _ForceUpdateResponseVo {
  _$ForceUpdateResponseVoImpl(
      {this.code, this.message, this.updateRequired, this.updateLink})
      : super._();

  factory _$ForceUpdateResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForceUpdateResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  bool? updateRequired;
  @override
  String? updateLink;

  @override
  String toString() {
    return 'ForceUpdateResponseVo(code: $code, message: $message, updateRequired: $updateRequired, updateLink: $updateLink)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ForceUpdateResponseVoImplCopyWith<_$ForceUpdateResponseVoImpl>
      get copyWith => __$$ForceUpdateResponseVoImplCopyWithImpl<
          _$ForceUpdateResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForceUpdateResponseVoImplToJson(
      this,
    );
  }
}

abstract class _ForceUpdateResponseVo extends ForceUpdateResponseVo {
  factory _ForceUpdateResponseVo(
      {String? code,
      String? message,
      bool? updateRequired,
      String? updateLink}) = _$ForceUpdateResponseVoImpl;
  _ForceUpdateResponseVo._() : super._();

  factory _ForceUpdateResponseVo.fromJson(Map<String, dynamic> json) =
      _$ForceUpdateResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  bool? get updateRequired;
  set updateRequired(bool? value);
  @override
  String? get updateLink;
  set updateLink(String? value);
  @override
  @JsonKey(ignore: true)
  _$$ForceUpdateResponseVoImplCopyWith<_$ForceUpdateResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
