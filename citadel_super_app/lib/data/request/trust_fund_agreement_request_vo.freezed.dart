// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trust_fund_agreement_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TrustFundAgreementRequestVo _$TrustFundAgreementRequestVoFromJson(
    Map<String, dynamic> json) {
  return _TrustFundAgreementRequestVo.fromJson(json);
}

/// @nodoc
mixin _$TrustFundAgreementRequestVo {
  String? get digitalSignature => throw _privateConstructorUsedError;
  set digitalSignature(String? value) => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  set fullName(String? value) => throw _privateConstructorUsedError;
  String? get identityCardNumber => throw _privateConstructorUsedError;
  set identityCardNumber(String? value) => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  set role(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrustFundAgreementRequestVoCopyWith<TrustFundAgreementRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrustFundAgreementRequestVoCopyWith<$Res> {
  factory $TrustFundAgreementRequestVoCopyWith(
          TrustFundAgreementRequestVo value,
          $Res Function(TrustFundAgreementRequestVo) then) =
      _$TrustFundAgreementRequestVoCopyWithImpl<$Res,
          TrustFundAgreementRequestVo>;
  @useResult
  $Res call(
      {String? digitalSignature,
      String? fullName,
      String? identityCardNumber,
      String? role});
}

/// @nodoc
class _$TrustFundAgreementRequestVoCopyWithImpl<$Res,
        $Val extends TrustFundAgreementRequestVo>
    implements $TrustFundAgreementRequestVoCopyWith<$Res> {
  _$TrustFundAgreementRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? digitalSignature = freezed,
    Object? fullName = freezed,
    Object? identityCardNumber = freezed,
    Object? role = freezed,
  }) {
    return _then(_value.copyWith(
      digitalSignature: freezed == digitalSignature
          ? _value.digitalSignature
          : digitalSignature // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      identityCardNumber: freezed == identityCardNumber
          ? _value.identityCardNumber
          : identityCardNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TrustFundAgreementRequestVoImplCopyWith<$Res>
    implements $TrustFundAgreementRequestVoCopyWith<$Res> {
  factory _$$TrustFundAgreementRequestVoImplCopyWith(
          _$TrustFundAgreementRequestVoImpl value,
          $Res Function(_$TrustFundAgreementRequestVoImpl) then) =
      __$$TrustFundAgreementRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? digitalSignature,
      String? fullName,
      String? identityCardNumber,
      String? role});
}

/// @nodoc
class __$$TrustFundAgreementRequestVoImplCopyWithImpl<$Res>
    extends _$TrustFundAgreementRequestVoCopyWithImpl<$Res,
        _$TrustFundAgreementRequestVoImpl>
    implements _$$TrustFundAgreementRequestVoImplCopyWith<$Res> {
  __$$TrustFundAgreementRequestVoImplCopyWithImpl(
      _$TrustFundAgreementRequestVoImpl _value,
      $Res Function(_$TrustFundAgreementRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? digitalSignature = freezed,
    Object? fullName = freezed,
    Object? identityCardNumber = freezed,
    Object? role = freezed,
  }) {
    return _then(_$TrustFundAgreementRequestVoImpl(
      digitalSignature: freezed == digitalSignature
          ? _value.digitalSignature
          : digitalSignature // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      identityCardNumber: freezed == identityCardNumber
          ? _value.identityCardNumber
          : identityCardNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TrustFundAgreementRequestVoImpl extends _TrustFundAgreementRequestVo {
  _$TrustFundAgreementRequestVoImpl(
      {this.digitalSignature,
      this.fullName,
      this.identityCardNumber,
      this.role})
      : super._();

  factory _$TrustFundAgreementRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$TrustFundAgreementRequestVoImplFromJson(json);

  @override
  String? digitalSignature;
  @override
  String? fullName;
  @override
  String? identityCardNumber;
  @override
  String? role;

  @override
  String toString() {
    return 'TrustFundAgreementRequestVo(digitalSignature: $digitalSignature, fullName: $fullName, identityCardNumber: $identityCardNumber, role: $role)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TrustFundAgreementRequestVoImplCopyWith<_$TrustFundAgreementRequestVoImpl>
      get copyWith => __$$TrustFundAgreementRequestVoImplCopyWithImpl<
          _$TrustFundAgreementRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TrustFundAgreementRequestVoImplToJson(
      this,
    );
  }
}

abstract class _TrustFundAgreementRequestVo
    extends TrustFundAgreementRequestVo {
  factory _TrustFundAgreementRequestVo(
      {String? digitalSignature,
      String? fullName,
      String? identityCardNumber,
      String? role}) = _$TrustFundAgreementRequestVoImpl;
  _TrustFundAgreementRequestVo._() : super._();

  factory _TrustFundAgreementRequestVo.fromJson(Map<String, dynamic> json) =
      _$TrustFundAgreementRequestVoImpl.fromJson;

  @override
  String? get digitalSignature;
  set digitalSignature(String? value);
  @override
  String? get fullName;
  set fullName(String? value);
  @override
  String? get identityCardNumber;
  set identityCardNumber(String? value);
  @override
  String? get role;
  set role(String? value);
  @override
  @JsonKey(ignore: true)
  _$$TrustFundAgreementRequestVoImplCopyWith<_$TrustFundAgreementRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
