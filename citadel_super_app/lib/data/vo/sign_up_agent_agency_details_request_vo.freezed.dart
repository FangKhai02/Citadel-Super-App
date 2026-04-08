// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_agent_agency_details_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SignUpAgentAgencyDetailsRequestVo _$SignUpAgentAgencyDetailsRequestVoFromJson(
    Map<String, dynamic> json) {
  return _SignUpAgentAgencyDetailsRequestVo.fromJson(json);
}

/// @nodoc
mixin _$SignUpAgentAgencyDetailsRequestVo {
  String? get agencyId => throw _privateConstructorUsedError;
  set agencyId(String? value) => throw _privateConstructorUsedError;
  String? get recruitManagerCode => throw _privateConstructorUsedError;
  set recruitManagerCode(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignUpAgentAgencyDetailsRequestVoCopyWith<SignUpAgentAgencyDetailsRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpAgentAgencyDetailsRequestVoCopyWith<$Res> {
  factory $SignUpAgentAgencyDetailsRequestVoCopyWith(
          SignUpAgentAgencyDetailsRequestVo value,
          $Res Function(SignUpAgentAgencyDetailsRequestVo) then) =
      _$SignUpAgentAgencyDetailsRequestVoCopyWithImpl<$Res,
          SignUpAgentAgencyDetailsRequestVo>;
  @useResult
  $Res call({String? agencyId, String? recruitManagerCode});
}

/// @nodoc
class _$SignUpAgentAgencyDetailsRequestVoCopyWithImpl<$Res,
        $Val extends SignUpAgentAgencyDetailsRequestVo>
    implements $SignUpAgentAgencyDetailsRequestVoCopyWith<$Res> {
  _$SignUpAgentAgencyDetailsRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? agencyId = freezed,
    Object? recruitManagerCode = freezed,
  }) {
    return _then(_value.copyWith(
      agencyId: freezed == agencyId
          ? _value.agencyId
          : agencyId // ignore: cast_nullable_to_non_nullable
              as String?,
      recruitManagerCode: freezed == recruitManagerCode
          ? _value.recruitManagerCode
          : recruitManagerCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignUpAgentAgencyDetailsRequestVoImplCopyWith<$Res>
    implements $SignUpAgentAgencyDetailsRequestVoCopyWith<$Res> {
  factory _$$SignUpAgentAgencyDetailsRequestVoImplCopyWith(
          _$SignUpAgentAgencyDetailsRequestVoImpl value,
          $Res Function(_$SignUpAgentAgencyDetailsRequestVoImpl) then) =
      __$$SignUpAgentAgencyDetailsRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? agencyId, String? recruitManagerCode});
}

/// @nodoc
class __$$SignUpAgentAgencyDetailsRequestVoImplCopyWithImpl<$Res>
    extends _$SignUpAgentAgencyDetailsRequestVoCopyWithImpl<$Res,
        _$SignUpAgentAgencyDetailsRequestVoImpl>
    implements _$$SignUpAgentAgencyDetailsRequestVoImplCopyWith<$Res> {
  __$$SignUpAgentAgencyDetailsRequestVoImplCopyWithImpl(
      _$SignUpAgentAgencyDetailsRequestVoImpl _value,
      $Res Function(_$SignUpAgentAgencyDetailsRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? agencyId = freezed,
    Object? recruitManagerCode = freezed,
  }) {
    return _then(_$SignUpAgentAgencyDetailsRequestVoImpl(
      agencyId: freezed == agencyId
          ? _value.agencyId
          : agencyId // ignore: cast_nullable_to_non_nullable
              as String?,
      recruitManagerCode: freezed == recruitManagerCode
          ? _value.recruitManagerCode
          : recruitManagerCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignUpAgentAgencyDetailsRequestVoImpl
    extends _SignUpAgentAgencyDetailsRequestVo {
  _$SignUpAgentAgencyDetailsRequestVoImpl(
      {this.agencyId, this.recruitManagerCode})
      : super._();

  factory _$SignUpAgentAgencyDetailsRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SignUpAgentAgencyDetailsRequestVoImplFromJson(json);

  @override
  String? agencyId;
  @override
  String? recruitManagerCode;

  @override
  String toString() {
    return 'SignUpAgentAgencyDetailsRequestVo(agencyId: $agencyId, recruitManagerCode: $recruitManagerCode)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpAgentAgencyDetailsRequestVoImplCopyWith<
          _$SignUpAgentAgencyDetailsRequestVoImpl>
      get copyWith => __$$SignUpAgentAgencyDetailsRequestVoImplCopyWithImpl<
          _$SignUpAgentAgencyDetailsRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignUpAgentAgencyDetailsRequestVoImplToJson(
      this,
    );
  }
}

abstract class _SignUpAgentAgencyDetailsRequestVo
    extends SignUpAgentAgencyDetailsRequestVo {
  factory _SignUpAgentAgencyDetailsRequestVo(
      {String? agencyId,
      String? recruitManagerCode}) = _$SignUpAgentAgencyDetailsRequestVoImpl;
  _SignUpAgentAgencyDetailsRequestVo._() : super._();

  factory _SignUpAgentAgencyDetailsRequestVo.fromJson(
          Map<String, dynamic> json) =
      _$SignUpAgentAgencyDetailsRequestVoImpl.fromJson;

  @override
  String? get agencyId;
  set agencyId(String? value);
  @override
  String? get recruitManagerCode;
  set recruitManagerCode(String? value);
  @override
  @JsonKey(ignore: true)
  _$$SignUpAgentAgencyDetailsRequestVoImplCopyWith<
          _$SignUpAgentAgencyDetailsRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
