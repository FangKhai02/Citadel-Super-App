// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'existing_agent_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExistingAgentResponseVo _$ExistingAgentResponseVoFromJson(
    Map<String, dynamic> json) {
  return _ExistingAgentResponseVo.fromJson(json);
}

/// @nodoc
mixin _$ExistingAgentResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
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
  String? get agencyCode => throw _privateConstructorUsedError;
  set agencyCode(String? value) => throw _privateConstructorUsedError;
  BankDetailsRequestVo? get bankDetails => throw _privateConstructorUsedError;
  set bankDetails(BankDetailsRequestVo? value) =>
      throw _privateConstructorUsedError;
  String? get digitalSignature => throw _privateConstructorUsedError;
  set digitalSignature(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExistingAgentResponseVoCopyWith<ExistingAgentResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExistingAgentResponseVoCopyWith<$Res> {
  factory $ExistingAgentResponseVoCopyWith(ExistingAgentResponseVo value,
          $Res Function(ExistingAgentResponseVo) then) =
      _$ExistingAgentResponseVoCopyWithImpl<$Res, ExistingAgentResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      SignUpBaseIdentityDetailsVo? identityDetails,
      SignUpBaseContactDetailsVo? contactDetails,
      String? selfieImage,
      SignUpAgentAgencyDetailsRequestVo? agencyDetails,
      String? agencyCode,
      BankDetailsRequestVo? bankDetails,
      String? digitalSignature});

  $SignUpBaseIdentityDetailsVoCopyWith<$Res>? get identityDetails;
  $SignUpBaseContactDetailsVoCopyWith<$Res>? get contactDetails;
  $SignUpAgentAgencyDetailsRequestVoCopyWith<$Res>? get agencyDetails;
  $BankDetailsRequestVoCopyWith<$Res>? get bankDetails;
}

/// @nodoc
class _$ExistingAgentResponseVoCopyWithImpl<$Res,
        $Val extends ExistingAgentResponseVo>
    implements $ExistingAgentResponseVoCopyWith<$Res> {
  _$ExistingAgentResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? identityDetails = freezed,
    Object? contactDetails = freezed,
    Object? selfieImage = freezed,
    Object? agencyDetails = freezed,
    Object? agencyCode = freezed,
    Object? bankDetails = freezed,
    Object? digitalSignature = freezed,
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
      agencyCode: freezed == agencyCode
          ? _value.agencyCode
          : agencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      bankDetails: freezed == bankDetails
          ? _value.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as BankDetailsRequestVo?,
      digitalSignature: freezed == digitalSignature
          ? _value.digitalSignature
          : digitalSignature // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ExistingAgentResponseVoImplCopyWith<$Res>
    implements $ExistingAgentResponseVoCopyWith<$Res> {
  factory _$$ExistingAgentResponseVoImplCopyWith(
          _$ExistingAgentResponseVoImpl value,
          $Res Function(_$ExistingAgentResponseVoImpl) then) =
      __$$ExistingAgentResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      SignUpBaseIdentityDetailsVo? identityDetails,
      SignUpBaseContactDetailsVo? contactDetails,
      String? selfieImage,
      SignUpAgentAgencyDetailsRequestVo? agencyDetails,
      String? agencyCode,
      BankDetailsRequestVo? bankDetails,
      String? digitalSignature});

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
class __$$ExistingAgentResponseVoImplCopyWithImpl<$Res>
    extends _$ExistingAgentResponseVoCopyWithImpl<$Res,
        _$ExistingAgentResponseVoImpl>
    implements _$$ExistingAgentResponseVoImplCopyWith<$Res> {
  __$$ExistingAgentResponseVoImplCopyWithImpl(
      _$ExistingAgentResponseVoImpl _value,
      $Res Function(_$ExistingAgentResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? identityDetails = freezed,
    Object? contactDetails = freezed,
    Object? selfieImage = freezed,
    Object? agencyDetails = freezed,
    Object? agencyCode = freezed,
    Object? bankDetails = freezed,
    Object? digitalSignature = freezed,
  }) {
    return _then(_$ExistingAgentResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
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
      agencyCode: freezed == agencyCode
          ? _value.agencyCode
          : agencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      bankDetails: freezed == bankDetails
          ? _value.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as BankDetailsRequestVo?,
      digitalSignature: freezed == digitalSignature
          ? _value.digitalSignature
          : digitalSignature // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExistingAgentResponseVoImpl extends _ExistingAgentResponseVo {
  _$ExistingAgentResponseVoImpl(
      {this.code,
      this.message,
      this.identityDetails,
      this.contactDetails,
      this.selfieImage,
      this.agencyDetails,
      this.agencyCode,
      this.bankDetails,
      this.digitalSignature})
      : super._();

  factory _$ExistingAgentResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExistingAgentResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  SignUpBaseIdentityDetailsVo? identityDetails;
  @override
  SignUpBaseContactDetailsVo? contactDetails;
  @override
  String? selfieImage;
  @override
  SignUpAgentAgencyDetailsRequestVo? agencyDetails;
  @override
  String? agencyCode;
  @override
  BankDetailsRequestVo? bankDetails;
  @override
  String? digitalSignature;

  @override
  String toString() {
    return 'ExistingAgentResponseVo(code: $code, message: $message, identityDetails: $identityDetails, contactDetails: $contactDetails, selfieImage: $selfieImage, agencyDetails: $agencyDetails, agencyCode: $agencyCode, bankDetails: $bankDetails, digitalSignature: $digitalSignature)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExistingAgentResponseVoImplCopyWith<_$ExistingAgentResponseVoImpl>
      get copyWith => __$$ExistingAgentResponseVoImplCopyWithImpl<
          _$ExistingAgentResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExistingAgentResponseVoImplToJson(
      this,
    );
  }
}

abstract class _ExistingAgentResponseVo extends ExistingAgentResponseVo {
  factory _ExistingAgentResponseVo(
      {String? code,
      String? message,
      SignUpBaseIdentityDetailsVo? identityDetails,
      SignUpBaseContactDetailsVo? contactDetails,
      String? selfieImage,
      SignUpAgentAgencyDetailsRequestVo? agencyDetails,
      String? agencyCode,
      BankDetailsRequestVo? bankDetails,
      String? digitalSignature}) = _$ExistingAgentResponseVoImpl;
  _ExistingAgentResponseVo._() : super._();

  factory _ExistingAgentResponseVo.fromJson(Map<String, dynamic> json) =
      _$ExistingAgentResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
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
  String? get agencyCode;
  set agencyCode(String? value);
  @override
  BankDetailsRequestVo? get bankDetails;
  set bankDetails(BankDetailsRequestVo? value);
  @override
  String? get digitalSignature;
  set digitalSignature(String? value);
  @override
  @JsonKey(ignore: true)
  _$$ExistingAgentResponseVoImplCopyWith<_$ExistingAgentResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
