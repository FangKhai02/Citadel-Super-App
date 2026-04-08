// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_sign_up_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClientSignUpRequestVo _$ClientSignUpRequestVoFromJson(
    Map<String, dynamic> json) {
  return _ClientSignUpRequestVo.fromJson(json);
}

/// @nodoc
mixin _$ClientSignUpRequestVo {
  ClientIdentityDetailsRequestVo? get identityDetails =>
      throw _privateConstructorUsedError;
  set identityDetails(ClientIdentityDetailsRequestVo? value) =>
      throw _privateConstructorUsedError;
  ClientPersonalDetailsRequestVo? get personalDetails =>
      throw _privateConstructorUsedError;
  set personalDetails(ClientPersonalDetailsRequestVo? value) =>
      throw _privateConstructorUsedError;
  String? get selfieImage => throw _privateConstructorUsedError;
  set selfieImage(String? value) => throw _privateConstructorUsedError;
  PepDeclarationVo? get pepDeclaration => throw _privateConstructorUsedError;
  set pepDeclaration(PepDeclarationVo? value) =>
      throw _privateConstructorUsedError;
  EmploymentDetailsVo? get employmentDetails =>
      throw _privateConstructorUsedError;
  set employmentDetails(EmploymentDetailsVo? value) =>
      throw _privateConstructorUsedError;
  String? get digitalSignature => throw _privateConstructorUsedError;
  set digitalSignature(String? value) => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  set password(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientSignUpRequestVoCopyWith<ClientSignUpRequestVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientSignUpRequestVoCopyWith<$Res> {
  factory $ClientSignUpRequestVoCopyWith(ClientSignUpRequestVo value,
          $Res Function(ClientSignUpRequestVo) then) =
      _$ClientSignUpRequestVoCopyWithImpl<$Res, ClientSignUpRequestVo>;
  @useResult
  $Res call(
      {ClientIdentityDetailsRequestVo? identityDetails,
      ClientPersonalDetailsRequestVo? personalDetails,
      String? selfieImage,
      PepDeclarationVo? pepDeclaration,
      EmploymentDetailsVo? employmentDetails,
      String? digitalSignature,
      String? password});

  $ClientIdentityDetailsRequestVoCopyWith<$Res>? get identityDetails;
  $ClientPersonalDetailsRequestVoCopyWith<$Res>? get personalDetails;
  $PepDeclarationVoCopyWith<$Res>? get pepDeclaration;
  $EmploymentDetailsVoCopyWith<$Res>? get employmentDetails;
}

/// @nodoc
class _$ClientSignUpRequestVoCopyWithImpl<$Res,
        $Val extends ClientSignUpRequestVo>
    implements $ClientSignUpRequestVoCopyWith<$Res> {
  _$ClientSignUpRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityDetails = freezed,
    Object? personalDetails = freezed,
    Object? selfieImage = freezed,
    Object? pepDeclaration = freezed,
    Object? employmentDetails = freezed,
    Object? digitalSignature = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      identityDetails: freezed == identityDetails
          ? _value.identityDetails
          : identityDetails // ignore: cast_nullable_to_non_nullable
              as ClientIdentityDetailsRequestVo?,
      personalDetails: freezed == personalDetails
          ? _value.personalDetails
          : personalDetails // ignore: cast_nullable_to_non_nullable
              as ClientPersonalDetailsRequestVo?,
      selfieImage: freezed == selfieImage
          ? _value.selfieImage
          : selfieImage // ignore: cast_nullable_to_non_nullable
              as String?,
      pepDeclaration: freezed == pepDeclaration
          ? _value.pepDeclaration
          : pepDeclaration // ignore: cast_nullable_to_non_nullable
              as PepDeclarationVo?,
      employmentDetails: freezed == employmentDetails
          ? _value.employmentDetails
          : employmentDetails // ignore: cast_nullable_to_non_nullable
              as EmploymentDetailsVo?,
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
  $ClientIdentityDetailsRequestVoCopyWith<$Res>? get identityDetails {
    if (_value.identityDetails == null) {
      return null;
    }

    return $ClientIdentityDetailsRequestVoCopyWith<$Res>(
        _value.identityDetails!, (value) {
      return _then(_value.copyWith(identityDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientPersonalDetailsRequestVoCopyWith<$Res>? get personalDetails {
    if (_value.personalDetails == null) {
      return null;
    }

    return $ClientPersonalDetailsRequestVoCopyWith<$Res>(
        _value.personalDetails!, (value) {
      return _then(_value.copyWith(personalDetails: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PepDeclarationVoCopyWith<$Res>? get pepDeclaration {
    if (_value.pepDeclaration == null) {
      return null;
    }

    return $PepDeclarationVoCopyWith<$Res>(_value.pepDeclaration!, (value) {
      return _then(_value.copyWith(pepDeclaration: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EmploymentDetailsVoCopyWith<$Res>? get employmentDetails {
    if (_value.employmentDetails == null) {
      return null;
    }

    return $EmploymentDetailsVoCopyWith<$Res>(_value.employmentDetails!,
        (value) {
      return _then(_value.copyWith(employmentDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClientSignUpRequestVoImplCopyWith<$Res>
    implements $ClientSignUpRequestVoCopyWith<$Res> {
  factory _$$ClientSignUpRequestVoImplCopyWith(
          _$ClientSignUpRequestVoImpl value,
          $Res Function(_$ClientSignUpRequestVoImpl) then) =
      __$$ClientSignUpRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ClientIdentityDetailsRequestVo? identityDetails,
      ClientPersonalDetailsRequestVo? personalDetails,
      String? selfieImage,
      PepDeclarationVo? pepDeclaration,
      EmploymentDetailsVo? employmentDetails,
      String? digitalSignature,
      String? password});

  @override
  $ClientIdentityDetailsRequestVoCopyWith<$Res>? get identityDetails;
  @override
  $ClientPersonalDetailsRequestVoCopyWith<$Res>? get personalDetails;
  @override
  $PepDeclarationVoCopyWith<$Res>? get pepDeclaration;
  @override
  $EmploymentDetailsVoCopyWith<$Res>? get employmentDetails;
}

/// @nodoc
class __$$ClientSignUpRequestVoImplCopyWithImpl<$Res>
    extends _$ClientSignUpRequestVoCopyWithImpl<$Res,
        _$ClientSignUpRequestVoImpl>
    implements _$$ClientSignUpRequestVoImplCopyWith<$Res> {
  __$$ClientSignUpRequestVoImplCopyWithImpl(_$ClientSignUpRequestVoImpl _value,
      $Res Function(_$ClientSignUpRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? identityDetails = freezed,
    Object? personalDetails = freezed,
    Object? selfieImage = freezed,
    Object? pepDeclaration = freezed,
    Object? employmentDetails = freezed,
    Object? digitalSignature = freezed,
    Object? password = freezed,
  }) {
    return _then(_$ClientSignUpRequestVoImpl(
      identityDetails: freezed == identityDetails
          ? _value.identityDetails
          : identityDetails // ignore: cast_nullable_to_non_nullable
              as ClientIdentityDetailsRequestVo?,
      personalDetails: freezed == personalDetails
          ? _value.personalDetails
          : personalDetails // ignore: cast_nullable_to_non_nullable
              as ClientPersonalDetailsRequestVo?,
      selfieImage: freezed == selfieImage
          ? _value.selfieImage
          : selfieImage // ignore: cast_nullable_to_non_nullable
              as String?,
      pepDeclaration: freezed == pepDeclaration
          ? _value.pepDeclaration
          : pepDeclaration // ignore: cast_nullable_to_non_nullable
              as PepDeclarationVo?,
      employmentDetails: freezed == employmentDetails
          ? _value.employmentDetails
          : employmentDetails // ignore: cast_nullable_to_non_nullable
              as EmploymentDetailsVo?,
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
class _$ClientSignUpRequestVoImpl extends _ClientSignUpRequestVo {
  _$ClientSignUpRequestVoImpl(
      {this.identityDetails,
      this.personalDetails,
      this.selfieImage,
      this.pepDeclaration,
      this.employmentDetails,
      this.digitalSignature,
      this.password})
      : super._();

  factory _$ClientSignUpRequestVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientSignUpRequestVoImplFromJson(json);

  @override
  ClientIdentityDetailsRequestVo? identityDetails;
  @override
  ClientPersonalDetailsRequestVo? personalDetails;
  @override
  String? selfieImage;
  @override
  PepDeclarationVo? pepDeclaration;
  @override
  EmploymentDetailsVo? employmentDetails;
  @override
  String? digitalSignature;
  @override
  String? password;

  @override
  String toString() {
    return 'ClientSignUpRequestVo(identityDetails: $identityDetails, personalDetails: $personalDetails, selfieImage: $selfieImage, pepDeclaration: $pepDeclaration, employmentDetails: $employmentDetails, digitalSignature: $digitalSignature, password: $password)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientSignUpRequestVoImplCopyWith<_$ClientSignUpRequestVoImpl>
      get copyWith => __$$ClientSignUpRequestVoImplCopyWithImpl<
          _$ClientSignUpRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientSignUpRequestVoImplToJson(
      this,
    );
  }
}

abstract class _ClientSignUpRequestVo extends ClientSignUpRequestVo {
  factory _ClientSignUpRequestVo(
      {ClientIdentityDetailsRequestVo? identityDetails,
      ClientPersonalDetailsRequestVo? personalDetails,
      String? selfieImage,
      PepDeclarationVo? pepDeclaration,
      EmploymentDetailsVo? employmentDetails,
      String? digitalSignature,
      String? password}) = _$ClientSignUpRequestVoImpl;
  _ClientSignUpRequestVo._() : super._();

  factory _ClientSignUpRequestVo.fromJson(Map<String, dynamic> json) =
      _$ClientSignUpRequestVoImpl.fromJson;

  @override
  ClientIdentityDetailsRequestVo? get identityDetails;
  set identityDetails(ClientIdentityDetailsRequestVo? value);
  @override
  ClientPersonalDetailsRequestVo? get personalDetails;
  set personalDetails(ClientPersonalDetailsRequestVo? value);
  @override
  String? get selfieImage;
  set selfieImage(String? value);
  @override
  PepDeclarationVo? get pepDeclaration;
  set pepDeclaration(PepDeclarationVo? value);
  @override
  EmploymentDetailsVo? get employmentDetails;
  set employmentDetails(EmploymentDetailsVo? value);
  @override
  String? get digitalSignature;
  set digitalSignature(String? value);
  @override
  String? get password;
  set password(String? value);
  @override
  @JsonKey(ignore: true)
  _$$ClientSignUpRequestVoImplCopyWith<_$ClientSignUpRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
