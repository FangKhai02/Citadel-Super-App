// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_beneficiary_guardian_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClientBeneficiaryGuardianResponseVo
    _$ClientBeneficiaryGuardianResponseVoFromJson(Map<String, dynamic> json) {
  return _ClientBeneficiaryGuardianResponseVo.fromJson(json);
}

/// @nodoc
mixin _$ClientBeneficiaryGuardianResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<IndividualBeneficiaryVo>? get beneficiaries =>
      throw _privateConstructorUsedError;
  set beneficiaries(List<IndividualBeneficiaryVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientBeneficiaryGuardianResponseVoCopyWith<
          ClientBeneficiaryGuardianResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientBeneficiaryGuardianResponseVoCopyWith<$Res> {
  factory $ClientBeneficiaryGuardianResponseVoCopyWith(
          ClientBeneficiaryGuardianResponseVo value,
          $Res Function(ClientBeneficiaryGuardianResponseVo) then) =
      _$ClientBeneficiaryGuardianResponseVoCopyWithImpl<$Res,
          ClientBeneficiaryGuardianResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<IndividualBeneficiaryVo>? beneficiaries});
}

/// @nodoc
class _$ClientBeneficiaryGuardianResponseVoCopyWithImpl<$Res,
        $Val extends ClientBeneficiaryGuardianResponseVo>
    implements $ClientBeneficiaryGuardianResponseVoCopyWith<$Res> {
  _$ClientBeneficiaryGuardianResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? beneficiaries = freezed,
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
      beneficiaries: freezed == beneficiaries
          ? _value.beneficiaries
          : beneficiaries // ignore: cast_nullable_to_non_nullable
              as List<IndividualBeneficiaryVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientBeneficiaryGuardianResponseVoImplCopyWith<$Res>
    implements $ClientBeneficiaryGuardianResponseVoCopyWith<$Res> {
  factory _$$ClientBeneficiaryGuardianResponseVoImplCopyWith(
          _$ClientBeneficiaryGuardianResponseVoImpl value,
          $Res Function(_$ClientBeneficiaryGuardianResponseVoImpl) then) =
      __$$ClientBeneficiaryGuardianResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<IndividualBeneficiaryVo>? beneficiaries});
}

/// @nodoc
class __$$ClientBeneficiaryGuardianResponseVoImplCopyWithImpl<$Res>
    extends _$ClientBeneficiaryGuardianResponseVoCopyWithImpl<$Res,
        _$ClientBeneficiaryGuardianResponseVoImpl>
    implements _$$ClientBeneficiaryGuardianResponseVoImplCopyWith<$Res> {
  __$$ClientBeneficiaryGuardianResponseVoImplCopyWithImpl(
      _$ClientBeneficiaryGuardianResponseVoImpl _value,
      $Res Function(_$ClientBeneficiaryGuardianResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? beneficiaries = freezed,
  }) {
    return _then(_$ClientBeneficiaryGuardianResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      beneficiaries: freezed == beneficiaries
          ? _value.beneficiaries
          : beneficiaries // ignore: cast_nullable_to_non_nullable
              as List<IndividualBeneficiaryVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientBeneficiaryGuardianResponseVoImpl
    extends _ClientBeneficiaryGuardianResponseVo {
  _$ClientBeneficiaryGuardianResponseVoImpl(
      {this.code, this.message, this.beneficiaries})
      : super._();

  factory _$ClientBeneficiaryGuardianResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ClientBeneficiaryGuardianResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<IndividualBeneficiaryVo>? beneficiaries;

  @override
  String toString() {
    return 'ClientBeneficiaryGuardianResponseVo(code: $code, message: $message, beneficiaries: $beneficiaries)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientBeneficiaryGuardianResponseVoImplCopyWith<
          _$ClientBeneficiaryGuardianResponseVoImpl>
      get copyWith => __$$ClientBeneficiaryGuardianResponseVoImplCopyWithImpl<
          _$ClientBeneficiaryGuardianResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientBeneficiaryGuardianResponseVoImplToJson(
      this,
    );
  }
}

abstract class _ClientBeneficiaryGuardianResponseVo
    extends ClientBeneficiaryGuardianResponseVo {
  factory _ClientBeneficiaryGuardianResponseVo(
          {String? code,
          String? message,
          List<IndividualBeneficiaryVo>? beneficiaries}) =
      _$ClientBeneficiaryGuardianResponseVoImpl;
  _ClientBeneficiaryGuardianResponseVo._() : super._();

  factory _ClientBeneficiaryGuardianResponseVo.fromJson(
          Map<String, dynamic> json) =
      _$ClientBeneficiaryGuardianResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<IndividualBeneficiaryVo>? get beneficiaries;
  set beneficiaries(List<IndividualBeneficiaryVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$ClientBeneficiaryGuardianResponseVoImplCopyWith<
          _$ClientBeneficiaryGuardianResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
