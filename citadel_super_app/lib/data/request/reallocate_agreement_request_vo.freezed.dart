// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reallocate_agreement_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReallocateAgreementRequestVo _$ReallocateAgreementRequestVoFromJson(
    Map<String, dynamic> json) {
  return _ReallocateAgreementRequestVo.fromJson(json);
}

/// @nodoc
mixin _$ReallocateAgreementRequestVo {
  String? get digitalSignature => throw _privateConstructorUsedError;
  set digitalSignature(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReallocateAgreementRequestVoCopyWith<ReallocateAgreementRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReallocateAgreementRequestVoCopyWith<$Res> {
  factory $ReallocateAgreementRequestVoCopyWith(
          ReallocateAgreementRequestVo value,
          $Res Function(ReallocateAgreementRequestVo) then) =
      _$ReallocateAgreementRequestVoCopyWithImpl<$Res,
          ReallocateAgreementRequestVo>;
  @useResult
  $Res call({String? digitalSignature});
}

/// @nodoc
class _$ReallocateAgreementRequestVoCopyWithImpl<$Res,
        $Val extends ReallocateAgreementRequestVo>
    implements $ReallocateAgreementRequestVoCopyWith<$Res> {
  _$ReallocateAgreementRequestVoCopyWithImpl(this._value, this._then);

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
abstract class _$$ReallocateAgreementRequestVoImplCopyWith<$Res>
    implements $ReallocateAgreementRequestVoCopyWith<$Res> {
  factory _$$ReallocateAgreementRequestVoImplCopyWith(
          _$ReallocateAgreementRequestVoImpl value,
          $Res Function(_$ReallocateAgreementRequestVoImpl) then) =
      __$$ReallocateAgreementRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? digitalSignature});
}

/// @nodoc
class __$$ReallocateAgreementRequestVoImplCopyWithImpl<$Res>
    extends _$ReallocateAgreementRequestVoCopyWithImpl<$Res,
        _$ReallocateAgreementRequestVoImpl>
    implements _$$ReallocateAgreementRequestVoImplCopyWith<$Res> {
  __$$ReallocateAgreementRequestVoImplCopyWithImpl(
      _$ReallocateAgreementRequestVoImpl _value,
      $Res Function(_$ReallocateAgreementRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? digitalSignature = freezed,
  }) {
    return _then(_$ReallocateAgreementRequestVoImpl(
      digitalSignature: freezed == digitalSignature
          ? _value.digitalSignature
          : digitalSignature // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReallocateAgreementRequestVoImpl extends _ReallocateAgreementRequestVo {
  _$ReallocateAgreementRequestVoImpl({this.digitalSignature}) : super._();

  factory _$ReallocateAgreementRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ReallocateAgreementRequestVoImplFromJson(json);

  @override
  String? digitalSignature;

  @override
  String toString() {
    return 'ReallocateAgreementRequestVo(digitalSignature: $digitalSignature)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReallocateAgreementRequestVoImplCopyWith<
          _$ReallocateAgreementRequestVoImpl>
      get copyWith => __$$ReallocateAgreementRequestVoImplCopyWithImpl<
          _$ReallocateAgreementRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReallocateAgreementRequestVoImplToJson(
      this,
    );
  }
}

abstract class _ReallocateAgreementRequestVo
    extends ReallocateAgreementRequestVo {
  factory _ReallocateAgreementRequestVo({String? digitalSignature}) =
      _$ReallocateAgreementRequestVoImpl;
  _ReallocateAgreementRequestVo._() : super._();

  factory _ReallocateAgreementRequestVo.fromJson(Map<String, dynamic> json) =
      _$ReallocateAgreementRequestVoImpl.fromJson;

  @override
  String? get digitalSignature;
  set digitalSignature(String? value);
  @override
  @JsonKey(ignore: true)
  _$$ReallocateAgreementRequestVoImplCopyWith<
          _$ReallocateAgreementRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
