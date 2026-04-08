// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_secure_tag_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentSecureTagResponseVo _$AgentSecureTagResponseVoFromJson(
    Map<String, dynamic> json) {
  return _AgentSecureTagResponseVo.fromJson(json);
}

/// @nodoc
mixin _$AgentSecureTagResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  AgentSecureTagVo? get secureTag => throw _privateConstructorUsedError;
  set secureTag(AgentSecureTagVo? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentSecureTagResponseVoCopyWith<AgentSecureTagResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentSecureTagResponseVoCopyWith<$Res> {
  factory $AgentSecureTagResponseVoCopyWith(AgentSecureTagResponseVo value,
          $Res Function(AgentSecureTagResponseVo) then) =
      _$AgentSecureTagResponseVoCopyWithImpl<$Res, AgentSecureTagResponseVo>;
  @useResult
  $Res call({String? code, String? message, AgentSecureTagVo? secureTag});

  $AgentSecureTagVoCopyWith<$Res>? get secureTag;
}

/// @nodoc
class _$AgentSecureTagResponseVoCopyWithImpl<$Res,
        $Val extends AgentSecureTagResponseVo>
    implements $AgentSecureTagResponseVoCopyWith<$Res> {
  _$AgentSecureTagResponseVoCopyWithImpl(this._value, this._then);

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
              as AgentSecureTagVo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AgentSecureTagVoCopyWith<$Res>? get secureTag {
    if (_value.secureTag == null) {
      return null;
    }

    return $AgentSecureTagVoCopyWith<$Res>(_value.secureTag!, (value) {
      return _then(_value.copyWith(secureTag: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AgentSecureTagResponseVoImplCopyWith<$Res>
    implements $AgentSecureTagResponseVoCopyWith<$Res> {
  factory _$$AgentSecureTagResponseVoImplCopyWith(
          _$AgentSecureTagResponseVoImpl value,
          $Res Function(_$AgentSecureTagResponseVoImpl) then) =
      __$$AgentSecureTagResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, AgentSecureTagVo? secureTag});

  @override
  $AgentSecureTagVoCopyWith<$Res>? get secureTag;
}

/// @nodoc
class __$$AgentSecureTagResponseVoImplCopyWithImpl<$Res>
    extends _$AgentSecureTagResponseVoCopyWithImpl<$Res,
        _$AgentSecureTagResponseVoImpl>
    implements _$$AgentSecureTagResponseVoImplCopyWith<$Res> {
  __$$AgentSecureTagResponseVoImplCopyWithImpl(
      _$AgentSecureTagResponseVoImpl _value,
      $Res Function(_$AgentSecureTagResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? secureTag = freezed,
  }) {
    return _then(_$AgentSecureTagResponseVoImpl(
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
              as AgentSecureTagVo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentSecureTagResponseVoImpl extends _AgentSecureTagResponseVo {
  _$AgentSecureTagResponseVoImpl({this.code, this.message, this.secureTag})
      : super._();

  factory _$AgentSecureTagResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgentSecureTagResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  AgentSecureTagVo? secureTag;

  @override
  String toString() {
    return 'AgentSecureTagResponseVo(code: $code, message: $message, secureTag: $secureTag)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentSecureTagResponseVoImplCopyWith<_$AgentSecureTagResponseVoImpl>
      get copyWith => __$$AgentSecureTagResponseVoImplCopyWithImpl<
          _$AgentSecureTagResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentSecureTagResponseVoImplToJson(
      this,
    );
  }
}

abstract class _AgentSecureTagResponseVo extends AgentSecureTagResponseVo {
  factory _AgentSecureTagResponseVo(
      {String? code,
      String? message,
      AgentSecureTagVo? secureTag}) = _$AgentSecureTagResponseVoImpl;
  _AgentSecureTagResponseVo._() : super._();

  factory _AgentSecureTagResponseVo.fromJson(Map<String, dynamic> json) =
      _$AgentSecureTagResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  AgentSecureTagVo? get secureTag;
  set secureTag(AgentSecureTagVo? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentSecureTagResponseVoImplCopyWith<_$AgentSecureTagResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
