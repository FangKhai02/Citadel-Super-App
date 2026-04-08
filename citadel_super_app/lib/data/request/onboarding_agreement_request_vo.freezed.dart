// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_agreement_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OnboardingAgreementRequestVo _$OnboardingAgreementRequestVoFromJson(
    Map<String, dynamic> json) {
  return _OnboardingAgreementRequestVo.fromJson(json);
}

/// @nodoc
mixin _$OnboardingAgreementRequestVo {
  String? get name => throw _privateConstructorUsedError;
  set name(String? value) => throw _privateConstructorUsedError;
  String? get identityCardNumber => throw _privateConstructorUsedError;
  set identityCardNumber(String? value) => throw _privateConstructorUsedError;
  String? get corporateClientId => throw _privateConstructorUsedError;
  set corporateClientId(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnboardingAgreementRequestVoCopyWith<OnboardingAgreementRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingAgreementRequestVoCopyWith<$Res> {
  factory $OnboardingAgreementRequestVoCopyWith(
          OnboardingAgreementRequestVo value,
          $Res Function(OnboardingAgreementRequestVo) then) =
      _$OnboardingAgreementRequestVoCopyWithImpl<$Res,
          OnboardingAgreementRequestVo>;
  @useResult
  $Res call(
      {String? name, String? identityCardNumber, String? corporateClientId});
}

/// @nodoc
class _$OnboardingAgreementRequestVoCopyWithImpl<$Res,
        $Val extends OnboardingAgreementRequestVo>
    implements $OnboardingAgreementRequestVoCopyWith<$Res> {
  _$OnboardingAgreementRequestVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? identityCardNumber = freezed,
    Object? corporateClientId = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      identityCardNumber: freezed == identityCardNumber
          ? _value.identityCardNumber
          : identityCardNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateClientId: freezed == corporateClientId
          ? _value.corporateClientId
          : corporateClientId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnboardingAgreementRequestVoImplCopyWith<$Res>
    implements $OnboardingAgreementRequestVoCopyWith<$Res> {
  factory _$$OnboardingAgreementRequestVoImplCopyWith(
          _$OnboardingAgreementRequestVoImpl value,
          $Res Function(_$OnboardingAgreementRequestVoImpl) then) =
      __$$OnboardingAgreementRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name, String? identityCardNumber, String? corporateClientId});
}

/// @nodoc
class __$$OnboardingAgreementRequestVoImplCopyWithImpl<$Res>
    extends _$OnboardingAgreementRequestVoCopyWithImpl<$Res,
        _$OnboardingAgreementRequestVoImpl>
    implements _$$OnboardingAgreementRequestVoImplCopyWith<$Res> {
  __$$OnboardingAgreementRequestVoImplCopyWithImpl(
      _$OnboardingAgreementRequestVoImpl _value,
      $Res Function(_$OnboardingAgreementRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? identityCardNumber = freezed,
    Object? corporateClientId = freezed,
  }) {
    return _then(_$OnboardingAgreementRequestVoImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      identityCardNumber: freezed == identityCardNumber
          ? _value.identityCardNumber
          : identityCardNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateClientId: freezed == corporateClientId
          ? _value.corporateClientId
          : corporateClientId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnboardingAgreementRequestVoImpl extends _OnboardingAgreementRequestVo {
  _$OnboardingAgreementRequestVoImpl(
      {this.name, this.identityCardNumber, this.corporateClientId})
      : super._();

  factory _$OnboardingAgreementRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$OnboardingAgreementRequestVoImplFromJson(json);

  @override
  String? name;
  @override
  String? identityCardNumber;
  @override
  String? corporateClientId;

  @override
  String toString() {
    return 'OnboardingAgreementRequestVo(name: $name, identityCardNumber: $identityCardNumber, corporateClientId: $corporateClientId)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingAgreementRequestVoImplCopyWith<
          _$OnboardingAgreementRequestVoImpl>
      get copyWith => __$$OnboardingAgreementRequestVoImplCopyWithImpl<
          _$OnboardingAgreementRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnboardingAgreementRequestVoImplToJson(
      this,
    );
  }
}

abstract class _OnboardingAgreementRequestVo
    extends OnboardingAgreementRequestVo {
  factory _OnboardingAgreementRequestVo(
      {String? name,
      String? identityCardNumber,
      String? corporateClientId}) = _$OnboardingAgreementRequestVoImpl;
  _OnboardingAgreementRequestVo._() : super._();

  factory _OnboardingAgreementRequestVo.fromJson(Map<String, dynamic> json) =
      _$OnboardingAgreementRequestVoImpl.fromJson;

  @override
  String? get name;
  set name(String? value);
  @override
  String? get identityCardNumber;
  set identityCardNumber(String? value);
  @override
  String? get corporateClientId;
  set corporateClientId(String? value);
  @override
  @JsonKey(ignore: true)
  _$$OnboardingAgreementRequestVoImplCopyWith<
          _$OnboardingAgreementRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
