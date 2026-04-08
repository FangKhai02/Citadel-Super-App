// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rollover_agreeement_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RolloverAgreeementRequestVo _$RolloverAgreeementRequestVoFromJson(
    Map<String, dynamic> json) {
  return _RolloverAgreeementRequestVo.fromJson(json);
}

/// @nodoc
mixin _$RolloverAgreeementRequestVo {
  String? get digitalSignature => throw _privateConstructorUsedError;
  set digitalSignature(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RolloverAgreeementRequestVoCopyWith<RolloverAgreeementRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RolloverAgreeementRequestVoCopyWith<$Res> {
  factory $RolloverAgreeementRequestVoCopyWith(
          RolloverAgreeementRequestVo value,
          $Res Function(RolloverAgreeementRequestVo) then) =
      _$RolloverAgreeementRequestVoCopyWithImpl<$Res,
          RolloverAgreeementRequestVo>;
  @useResult
  $Res call({String? digitalSignature});
}

/// @nodoc
class _$RolloverAgreeementRequestVoCopyWithImpl<$Res,
        $Val extends RolloverAgreeementRequestVo>
    implements $RolloverAgreeementRequestVoCopyWith<$Res> {
  _$RolloverAgreeementRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? digitalSignature = freezed,
  }) {
    return _then(_value.copyWith(
      digitalSignature: freezed == digitalSignature
          ? _value.digitalSignature
          : digitalSignature // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RolloverAgreeementRequestVoImplCopyWith<$Res>
    implements $RolloverAgreeementRequestVoCopyWith<$Res> {
  factory _$$RolloverAgreeementRequestVoImplCopyWith(
          _$RolloverAgreeementRequestVoImpl value,
          $Res Function(_$RolloverAgreeementRequestVoImpl) then) =
      __$$RolloverAgreeementRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? digitalSignature});
}

/// @nodoc
class __$$RolloverAgreeementRequestVoImplCopyWithImpl<$Res>
    extends _$RolloverAgreeementRequestVoCopyWithImpl<$Res,
        _$RolloverAgreeementRequestVoImpl>
    implements _$$RolloverAgreeementRequestVoImplCopyWith<$Res> {
  __$$RolloverAgreeementRequestVoImplCopyWithImpl(
      _$RolloverAgreeementRequestVoImpl _value,
      $Res Function(_$RolloverAgreeementRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? digitalSignature = freezed,
  }) {
    return _then(_$RolloverAgreeementRequestVoImpl(
      digitalSignature: freezed == digitalSignature
          ? _value.digitalSignature
          : digitalSignature // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RolloverAgreeementRequestVoImpl extends _RolloverAgreeementRequestVo {
  _$RolloverAgreeementRequestVoImpl({this.digitalSignature}) : super._();

  factory _$RolloverAgreeementRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$RolloverAgreeementRequestVoImplFromJson(json);

  @override
  String? digitalSignature;

  @override
  String toString() {
    return 'RolloverAgreeementRequestVo(digitalSignature: $digitalSignature)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RolloverAgreeementRequestVoImplCopyWith<_$RolloverAgreeementRequestVoImpl>
      get copyWith => __$$RolloverAgreeementRequestVoImplCopyWithImpl<
          _$RolloverAgreeementRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RolloverAgreeementRequestVoImplToJson(
      this,
    );
  }
}

abstract class _RolloverAgreeementRequestVo
    extends RolloverAgreeementRequestVo {
  factory _RolloverAgreeementRequestVo({String? digitalSignature}) =
      _$RolloverAgreeementRequestVoImpl;
  _RolloverAgreeementRequestVo._() : super._();

  factory _RolloverAgreeementRequestVo.fromJson(Map<String, dynamic> json) =
      _$RolloverAgreeementRequestVoImpl.fromJson;

  @override
  String? get digitalSignature;
  set digitalSignature(String? value);
  @override
  @JsonKey(ignore: true)
  _$$RolloverAgreeementRequestVoImplCopyWith<_$RolloverAgreeementRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
