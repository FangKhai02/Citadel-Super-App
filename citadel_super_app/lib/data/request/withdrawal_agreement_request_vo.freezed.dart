// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'withdrawal_agreement_request_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WithdrawalAgreementRequestVo _$WithdrawalAgreementRequestVoFromJson(
    Map<String, dynamic> json) {
  return _WithdrawalAgreementRequestVo.fromJson(json);
}

/// @nodoc
mixin _$WithdrawalAgreementRequestVo {
  String? get digitalSignature => throw _privateConstructorUsedError;
  set digitalSignature(String? value) => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  set fullName(String? value) => throw _privateConstructorUsedError;
  String? get identityCardNumber => throw _privateConstructorUsedError;
  set identityCardNumber(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WithdrawalAgreementRequestVoCopyWith<WithdrawalAgreementRequestVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WithdrawalAgreementRequestVoCopyWith<$Res> {
  factory $WithdrawalAgreementRequestVoCopyWith(
          WithdrawalAgreementRequestVo value,
          $Res Function(WithdrawalAgreementRequestVo) then) =
      _$WithdrawalAgreementRequestVoCopyWithImpl<$Res,
          WithdrawalAgreementRequestVo>;
  @useResult
  $Res call(
      {String? digitalSignature, String? fullName, String? identityCardNumber});
}

/// @nodoc
class _$WithdrawalAgreementRequestVoCopyWithImpl<$Res,
        $Val extends WithdrawalAgreementRequestVo>
    implements $WithdrawalAgreementRequestVoCopyWith<$Res> {
  _$WithdrawalAgreementRequestVoCopyWithImpl(this._value, this._then);

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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WithdrawalAgreementRequestVoImplCopyWith<$Res>
    implements $WithdrawalAgreementRequestVoCopyWith<$Res> {
  factory _$$WithdrawalAgreementRequestVoImplCopyWith(
          _$WithdrawalAgreementRequestVoImpl value,
          $Res Function(_$WithdrawalAgreementRequestVoImpl) then) =
      __$$WithdrawalAgreementRequestVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? digitalSignature, String? fullName, String? identityCardNumber});
}

/// @nodoc
class __$$WithdrawalAgreementRequestVoImplCopyWithImpl<$Res>
    extends _$WithdrawalAgreementRequestVoCopyWithImpl<$Res,
        _$WithdrawalAgreementRequestVoImpl>
    implements _$$WithdrawalAgreementRequestVoImplCopyWith<$Res> {
  __$$WithdrawalAgreementRequestVoImplCopyWithImpl(
      _$WithdrawalAgreementRequestVoImpl _value,
      $Res Function(_$WithdrawalAgreementRequestVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? digitalSignature = freezed,
    Object? fullName = freezed,
    Object? identityCardNumber = freezed,
  }) {
    return _then(_$WithdrawalAgreementRequestVoImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WithdrawalAgreementRequestVoImpl extends _WithdrawalAgreementRequestVo {
  _$WithdrawalAgreementRequestVoImpl(
      {this.digitalSignature, this.fullName, this.identityCardNumber})
      : super._();

  factory _$WithdrawalAgreementRequestVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WithdrawalAgreementRequestVoImplFromJson(json);

  @override
  String? digitalSignature;
  @override
  String? fullName;
  @override
  String? identityCardNumber;

  @override
  String toString() {
    return 'WithdrawalAgreementRequestVo(digitalSignature: $digitalSignature, fullName: $fullName, identityCardNumber: $identityCardNumber)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WithdrawalAgreementRequestVoImplCopyWith<
          _$WithdrawalAgreementRequestVoImpl>
      get copyWith => __$$WithdrawalAgreementRequestVoImplCopyWithImpl<
          _$WithdrawalAgreementRequestVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WithdrawalAgreementRequestVoImplToJson(
      this,
    );
  }
}

abstract class _WithdrawalAgreementRequestVo
    extends WithdrawalAgreementRequestVo {
  factory _WithdrawalAgreementRequestVo(
      {String? digitalSignature,
      String? fullName,
      String? identityCardNumber}) = _$WithdrawalAgreementRequestVoImpl;
  _WithdrawalAgreementRequestVo._() : super._();

  factory _WithdrawalAgreementRequestVo.fromJson(Map<String, dynamic> json) =
      _$WithdrawalAgreementRequestVoImpl.fromJson;

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
  @JsonKey(ignore: true)
  _$$WithdrawalAgreementRequestVoImplCopyWith<
          _$WithdrawalAgreementRequestVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
