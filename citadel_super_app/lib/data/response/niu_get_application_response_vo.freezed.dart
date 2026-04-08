// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'niu_get_application_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NiuGetApplicationResponseVo _$NiuGetApplicationResponseVoFromJson(
    Map<String, dynamic> json) {
  return _NiuGetApplicationResponseVo.fromJson(json);
}

/// @nodoc
mixin _$NiuGetApplicationResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<NiuGetApplicationDetailsVo>? get applications =>
      throw _privateConstructorUsedError;
  set applications(List<NiuGetApplicationDetailsVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NiuGetApplicationResponseVoCopyWith<NiuGetApplicationResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NiuGetApplicationResponseVoCopyWith<$Res> {
  factory $NiuGetApplicationResponseVoCopyWith(
          NiuGetApplicationResponseVo value,
          $Res Function(NiuGetApplicationResponseVo) then) =
      _$NiuGetApplicationResponseVoCopyWithImpl<$Res,
          NiuGetApplicationResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<NiuGetApplicationDetailsVo>? applications});
}

/// @nodoc
class _$NiuGetApplicationResponseVoCopyWithImpl<$Res,
        $Val extends NiuGetApplicationResponseVo>
    implements $NiuGetApplicationResponseVoCopyWith<$Res> {
  _$NiuGetApplicationResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? applications = freezed,
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
      applications: freezed == applications
          ? _value.applications
          : applications // ignore: cast_nullable_to_non_nullable
              as List<NiuGetApplicationDetailsVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NiuGetApplicationResponseVoImplCopyWith<$Res>
    implements $NiuGetApplicationResponseVoCopyWith<$Res> {
  factory _$$NiuGetApplicationResponseVoImplCopyWith(
          _$NiuGetApplicationResponseVoImpl value,
          $Res Function(_$NiuGetApplicationResponseVoImpl) then) =
      __$$NiuGetApplicationResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<NiuGetApplicationDetailsVo>? applications});
}

/// @nodoc
class __$$NiuGetApplicationResponseVoImplCopyWithImpl<$Res>
    extends _$NiuGetApplicationResponseVoCopyWithImpl<$Res,
        _$NiuGetApplicationResponseVoImpl>
    implements _$$NiuGetApplicationResponseVoImplCopyWith<$Res> {
  __$$NiuGetApplicationResponseVoImplCopyWithImpl(
      _$NiuGetApplicationResponseVoImpl _value,
      $Res Function(_$NiuGetApplicationResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? applications = freezed,
  }) {
    return _then(_$NiuGetApplicationResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      applications: freezed == applications
          ? _value.applications
          : applications // ignore: cast_nullable_to_non_nullable
              as List<NiuGetApplicationDetailsVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NiuGetApplicationResponseVoImpl extends _NiuGetApplicationResponseVo {
  _$NiuGetApplicationResponseVoImpl(
      {this.code, this.message, this.applications})
      : super._();

  factory _$NiuGetApplicationResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NiuGetApplicationResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<NiuGetApplicationDetailsVo>? applications;

  @override
  String toString() {
    return 'NiuGetApplicationResponseVo(code: $code, message: $message, applications: $applications)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NiuGetApplicationResponseVoImplCopyWith<_$NiuGetApplicationResponseVoImpl>
      get copyWith => __$$NiuGetApplicationResponseVoImplCopyWithImpl<
          _$NiuGetApplicationResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NiuGetApplicationResponseVoImplToJson(
      this,
    );
  }
}

abstract class _NiuGetApplicationResponseVo
    extends NiuGetApplicationResponseVo {
  factory _NiuGetApplicationResponseVo(
          {String? code,
          String? message,
          List<NiuGetApplicationDetailsVo>? applications}) =
      _$NiuGetApplicationResponseVoImpl;
  _NiuGetApplicationResponseVo._() : super._();

  factory _NiuGetApplicationResponseVo.fromJson(Map<String, dynamic> json) =
      _$NiuGetApplicationResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<NiuGetApplicationDetailsVo>? get applications;
  set applications(List<NiuGetApplicationDetailsVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$NiuGetApplicationResponseVoImplCopyWith<_$NiuGetApplicationResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
