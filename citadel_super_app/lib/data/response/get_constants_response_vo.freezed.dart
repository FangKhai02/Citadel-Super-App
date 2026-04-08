// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_constants_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetConstantsResponseVo _$GetConstantsResponseVoFromJson(
    Map<String, dynamic> json) {
  return _GetConstantsResponseVo.fromJson(json);
}

/// @nodoc
mixin _$GetConstantsResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<ConstantVo>? get constants => throw _privateConstructorUsedError;
  set constants(List<ConstantVo>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetConstantsResponseVoCopyWith<GetConstantsResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetConstantsResponseVoCopyWith<$Res> {
  factory $GetConstantsResponseVoCopyWith(GetConstantsResponseVo value,
          $Res Function(GetConstantsResponseVo) then) =
      _$GetConstantsResponseVoCopyWithImpl<$Res, GetConstantsResponseVo>;
  @useResult
  $Res call({String? code, String? message, List<ConstantVo>? constants});
}

/// @nodoc
class _$GetConstantsResponseVoCopyWithImpl<$Res,
        $Val extends GetConstantsResponseVo>
    implements $GetConstantsResponseVoCopyWith<$Res> {
  _$GetConstantsResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? constants = freezed,
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
      constants: freezed == constants
          ? _value.constants
          : constants // ignore: cast_nullable_to_non_nullable
              as List<ConstantVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetConstantsResponseVoImplCopyWith<$Res>
    implements $GetConstantsResponseVoCopyWith<$Res> {
  factory _$$GetConstantsResponseVoImplCopyWith(
          _$GetConstantsResponseVoImpl value,
          $Res Function(_$GetConstantsResponseVoImpl) then) =
      __$$GetConstantsResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, List<ConstantVo>? constants});
}

/// @nodoc
class __$$GetConstantsResponseVoImplCopyWithImpl<$Res>
    extends _$GetConstantsResponseVoCopyWithImpl<$Res,
        _$GetConstantsResponseVoImpl>
    implements _$$GetConstantsResponseVoImplCopyWith<$Res> {
  __$$GetConstantsResponseVoImplCopyWithImpl(
      _$GetConstantsResponseVoImpl _value,
      $Res Function(_$GetConstantsResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? constants = freezed,
  }) {
    return _then(_$GetConstantsResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      constants: freezed == constants
          ? _value.constants
          : constants // ignore: cast_nullable_to_non_nullable
              as List<ConstantVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetConstantsResponseVoImpl extends _GetConstantsResponseVo {
  _$GetConstantsResponseVoImpl({this.code, this.message, this.constants})
      : super._();

  factory _$GetConstantsResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetConstantsResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<ConstantVo>? constants;

  @override
  String toString() {
    return 'GetConstantsResponseVo(code: $code, message: $message, constants: $constants)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GetConstantsResponseVoImplCopyWith<_$GetConstantsResponseVoImpl>
      get copyWith => __$$GetConstantsResponseVoImplCopyWithImpl<
          _$GetConstantsResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetConstantsResponseVoImplToJson(
      this,
    );
  }
}

abstract class _GetConstantsResponseVo extends GetConstantsResponseVo {
  factory _GetConstantsResponseVo(
      {String? code,
      String? message,
      List<ConstantVo>? constants}) = _$GetConstantsResponseVoImpl;
  _GetConstantsResponseVo._() : super._();

  factory _GetConstantsResponseVo.fromJson(Map<String, dynamic> json) =
      _$GetConstantsResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<ConstantVo>? get constants;
  set constants(List<ConstantVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$GetConstantsResponseVoImplCopyWith<_$GetConstantsResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
