// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_sign_up_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentSignUpRequestVo _$AgentSignUpRequestVoFromJson(Map<String, dynamic> json) {
  return _AgentSignUpRequestVo.fromJson(json);
}

/// @nodoc
mixin _$AgentSignUpRequestVo {
  SignUpBaseIdentityDetailsVo? get identityDetails =>
      throw _privateConstructorUsedError;
  set identityDetails(SignUpBaseIdentityDetailsVo? value) =>
      throw _privateConstructorUsedError;
  SignUpBaseContactDetailsVo? get contactDetails =>
      throw _privateConstructorUsedError;
  set contactDetails(SignUpBaseContactDetailsVo? value) =>
      throw _privateConstructorUsedError;
  String? get selfieImage => throw _privateConstructorUsedError;
  set selfieImage(String? value) => throw _privateConstructorUsedError;
  SignUpAgentAgencyDetailsRequestVo? get agencyDetails =>
      throw _privateConstructorUsedError;
  set agencyDetails(SignUpAgentAgencyDetailsRequestVo? value) =>
      throw _privateConstructorUsedError;
  BankDetailsRequestVo? get bankDetails => throw _privateConstructorUsedError;
  set bankDetails(BankDetailsRequestVo? value) =>
      throw _privateConstructorUsedError;
  String? get digitalSignature => throw _privateConstructorUsedError;
  set digitalSignature(String? value) => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  set password(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentSignUpRequestVoCopyWith<AgentSignUpRequestVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentSignUpRequestVoCopyWith<$Res> {
  factory $AgentSignUpRequestVoCopyWith(AgentSignUpRequestVo value,
          $Res Function(AgentSignUpRequestVo) then) =
      _$AgentSignUpRequestVoCopyWithImpl<$Res, AgentSignUpRequestVo>;
  @useResult
  $Res call(
      {SignUpBaseIdentityDetailsVo? identityDetails,
      SignUpBaseContactDetailsVo? contactDetails,
      String? selfieImage,
      SignUpAgentAgencyDetailsRequestVo? agencyDetails,
      BankDetailsRequestVo? bankDetails,
      String? digitalSignature,
      String? password});

  $SignUpBaseIdentityDetailsVoCopyWith<$Res>? get identityDetails;
  $SignUpBaseContactDetailsVoCopyWith<$Res>? get contactDetails;
  $SignUpAgentAgencyDetailsRequestVoCopyWith<$Res>? get agencyDetails;
  $BankDetailsRequestVoCopyWith<$Res>? get bankDetails;
}

/// @nodoc
class _$AgentSignUpRequestVoCopyWithImpl<$Res,
        $Val extends AgentSignUpRequestVo>
    implements $AgentSignUpRequestVoCopyWith<$Res> {
  _$AgentSignUpRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityDetails = freezed,
    Object? contactDetails = freezed,
    Object? selfieImage = freezed,
    Object? agencyDetails = freezed,
    Object? bankDetails = freezed,
    Object? digitalSignature = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      identityDetails: freezed == identityDetails
          ? _value.identityDetails
          : identityDetails // ignore: cast_nullable_to_non_nullable
              as SignUpBaseIdentityDetailsVo?,
      contactDetails: freezed == contactDetails
          ? _value.contactDetails
          : contactDetails // ignore: cast_nullable_to_non_nullable
              as SignUpBaseContactDetailsVo?,
      selfieImage: freezed == selfieImage
          ? _value.selfieImage
          : selfieImage // ignore: cast_nullable_to_non_nullable
              as String?,
      agencyDetails: freezed == agencyDetails
          ? _value.agencyDetails
          : agencyDetails // ignore: cast_nullable_to_non_nullable
              as SignUpAgentAgencyDetailsRequestVo?,
      bankDetails: freezed == bankDetails
          ? _value.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as BankDetailsRequestVo?,
      digitalSignature: freezed == digitalSignature
          ? _value.digitalSignature
          : digitalSignature // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SignUpBaseIdentityDetailsVoCopyWith<$Res>? get identityDetails {
    if (_value.identityDetails == null) {
      return null;
    }

    return $SignUpBaseIdentityDetailsVoCopyWith<$Res>(_value.identityDetails!,
        (value) {
      return _then(_value.copyWith(identityDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SignUpBaseContactDetailsVoCopyWith<$Res>? get contactDetails {
    if (_value.contactDetails == null) {
      return null;
    }

    return $SignUpBaseContactDetailsVoCopyWith<$Res>(_value.contactDetails!,
        (value) {
      return _then(_value.copyWith(contactDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SignUpAgentAgencyDetailsRequestVoCopyWith<$Res>? get agencyDetails {
    if (_value.agencyDetails == null) {
      return null;
    }

    return $SignUpAgentAgencyDetailsRequestVoCopyWith<$Res>(
        _value.agencyDetails!, (value) {
      return _then(_value.copyWith(agencyDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BankDetailsRequestVoCopyWith<$Res>? get bankDetails {
    if (_value.bankDetails == null) {
      return null;
    }

    return $BankDetailsRequestVoCopyWith<$Res>(_value.bankDetails!, (value) {
      return _then(_value.copyWith(bankDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AgentSignUpRequestVoImplCopyWith<$Res>
    implements $AgentSignUpRequestVoCopyWith<$Res> {
  factory _$$AgentSignUpRequestVoImplCopyWith(_$AgentSignUpRequestVoImpl value,
          $Res Function(_$AgentSignUpRequestVoImpl) then) =
      __$$AgentSignUpRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SignUpBaseIdentityDetailsVo? identityDetails,
      SignUpBaseContactDetailsVo? contactDetails,
      String? selfieImage,
      SignUpAgentAgencyDetailsRequestVo? agencyDetails,
      BankDetailsRequestVo? bankDetails,
      String? digitalSignature,
      String? password});

  @override
  $SignUpBaseIdentityDetailsVoCopyWith<$Res>? get identityDetails;
  @override
  $SignUpBaseContactDetailsVoCopyWith<$Res>? get contactDetails;
  @override
  $SignUpAgentAgencyDetailsRequestVoCopyWith<$Res>? get agencyDetails;
  @override
  $BankDetailsRequestVoCopyWith<$Res>? get bankDetails;
}

/// @nodoc
class __$$AgentSignUpRequestVoImplCopyWithImpl<$Res>
    extends _$AgentSignUpRequestVoCopyWithImpl<$Res, _$AgentSignUpRequestVoImpl>
    implements _$$AgentSignUpRequestVoImplCopyWith<$Res> {
  __$$AgentSignUpRequestVoImplCopyWithImpl(_$AgentSignUpRequestVoImpl _value,
      $Res Function(_$AgentSignUpRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityDetails = freezed,
    Object? contactDetails = freezed,
    Object? selfieImage = freezed,
    Object? agencyDetails = freezed,
    Object? bankDetails = freezed,
    Object? digitalSignature = freezed,
    Object? password = freezed,
  }) {
    return _then(_$AgentSignUpRequestVoImpl(
      identityDetails: freezed == identityDetails
          ? _value.identityDetails
          : identityDetails // ignore: cast_nullable_to_non_nullable
              as SignUpBaseIdentityDetailsVo?,
      contactDetails: freezed == contactDetails
          ? _value.contactDetails
          : contactDetails // ignore: cast_nullable_to_non_nullable
              as SignUpBaseContactDetailsVo?,
      selfieImage: freezed == selfieImage
          ? _value.selfieImage
          : selfieImage // ignore: cast_nullable_to_non_nullable
              as String?,
      agencyDetails: freezed == agencyDetails
          ? _value.agencyDetails
          : agencyDetails // ignore: cast_nullable_to_non_nullable
              as SignUpAgentAgencyDetailsRequestVo?,
      bankDetails: freezed == bankDetails
          ? _value.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as BankDetailsRequestVo?,
      digitalSignature: freezed == digitalSignature
          ? _value.digitalSignature
          : digitalSignature // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentSignUpRequestVoImpl extends _AgentSignUpRequestVo {
  _$AgentSignUpRequestVoImpl(
      {this.identityDetails,
      this.contactDetails,
      this.selfieImage,
      this.agencyDetails,
      this.bankDetails,
      this.digitalSignature,
      this.password})
      : super._();

  factory _$AgentSignUpRequestVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgentSignUpRequestVoImplFromJson(json);

  @override
  SignUpBaseIdentityDetailsVo? identityDetails;
  @override
  SignUpBaseContactDetailsVo? contactDetails;
  @override
  String? selfieImage;
  @override
  SignUpAgentAgencyDetailsRequestVo? agencyDetails;
  @override
  BankDetailsRequestVo? bankDetails;
  @override
  String? digitalSignature;
  @override
  String? password;

  @override
  String toString() {
    return 'AgentSignUpRequestVo(identityDetails: $identityDetails, contactDetails: $contactDetails, selfieImage: $selfieImage, agencyDetails: $agencyDetails, bankDetails: $bankDetails, digitalSignature: $digitalSignature, password: $password)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentSignUpRequestVoImplCopyWith<_$AgentSignUpRequestVoImpl>
      get copyWith =>
          __$$AgentSignUpRequestVoImplCopyWithImpl<_$AgentSignUpRequestVoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentSignUpRequestVoImplToJson(
      this,
    );
  }
}

abstract class _AgentSignUpRequestVo extends AgentSignUpRequestVo {
  factory _AgentSignUpRequestVo(
      {SignUpBaseIdentityDetailsVo? identityDetails,
      SignUpBaseContactDetailsVo? contactDetails,
      String? selfieImage,
      SignUpAgentAgencyDetailsRequestVo? agencyDetails,
      BankDetailsRequestVo? bankDetails,
      String? digitalSignature,
      String? password}) = _$AgentSignUpRequestVoImpl;
  _AgentSignUpRequestVo._() : super._();

  factory _AgentSignUpRequestVo.fromJson(Map<String, dynamic> json) =
      _$AgentSignUpRequestVoImpl.fromJson;

  @override
  SignUpBaseIdentityDetailsVo? get identityDetails;
  set identityDetails(SignUpBaseIdentityDetailsVo? value);
  @override
  SignUpBaseContactDetailsVo? get contactDetails;
  set contactDetails(SignUpBaseContactDetailsVo? value);
  @override
  String? get selfieImage;
  set selfieImage(String? value);
  @override
  SignUpAgentAgencyDetailsRequestVo? get agencyDetails;
  set agencyDetails(SignUpAgentAgencyDetailsRequestVo? value);
  @override
  BankDetailsRequestVo? get bankDetails;
  set bankDetails(BankDetailsRequestVo? value);
  @override
  String? get digitalSignature;
  set digitalSignature(String? value);
  @override
  String? get password;
  set password(String? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentSignUpRequestVoImplCopyWith<_$AgentSignUpRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
