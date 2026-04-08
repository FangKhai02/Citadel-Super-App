// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BankDetails _$BankDetailsFromJson(Map<String, dynamic> json) {
  return _BankDetails.fromJson(json);
}

/// @nodoc
mixin _$BankDetails {
  AppUser? get appUser => throw _privateConstructorUsedError;
  set appUser(AppUser? value) => throw _privateConstructorUsedError;
  String? get bankName => throw _privateConstructorUsedError;
  set bankName(String? value) => throw _privateConstructorUsedError;
  String? get accountNumber => throw _privateConstructorUsedError;
  set accountNumber(String? value) => throw _privateConstructorUsedError;
  String? get accountHolderName => throw _privateConstructorUsedError;
  set accountHolderName(String? value) => throw _privateConstructorUsedError;
  String? get bankAddress => throw _privateConstructorUsedError;
  set bankAddress(String? value) => throw _privateConstructorUsedError;
  String? get postcode => throw _privateConstructorUsedError;
  set postcode(String? value) => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  set city(String? value) => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  set state(String? value) => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  set country(String? value) => throw _privateConstructorUsedError;
  String? get swiftCode => throw _privateConstructorUsedError;
  set swiftCode(String? value) => throw _privateConstructorUsedError;
  String? get bankAccountProofKey => throw _privateConstructorUsedError;
  set bankAccountProofKey(String? value) => throw _privateConstructorUsedError;
  bool? get isDeleted => throw _privateConstructorUsedError;
  set isDeleted(bool? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BankDetailsCopyWith<BankDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankDetailsCopyWith<$Res> {
  factory $BankDetailsCopyWith(
          BankDetails value, $Res Function(BankDetails) then) =
      _$BankDetailsCopyWithImpl<$Res, BankDetails>;
  @useResult
  $Res call(
      {AppUser? appUser,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? bankAddress,
      String? postcode,
      String? city,
      String? state,
      String? country,
      String? swiftCode,
      String? bankAccountProofKey,
      bool? isDeleted});

  $AppUserCopyWith<$Res>? get appUser;
}

/// @nodoc
class _$BankDetailsCopyWithImpl<$Res, $Val extends BankDetails>
    implements $BankDetailsCopyWith<$Res> {
  _$BankDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appUser = freezed,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? accountHolderName = freezed,
    Object? bankAddress = freezed,
    Object? postcode = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? swiftCode = freezed,
    Object? bankAccountProofKey = freezed,
    Object? isDeleted = freezed,
  }) {
    return _then(_value.copyWith(
      appUser: freezed == appUser
          ? _value.appUser
          : appUser // ignore: cast_nullable_to_non_nullable
              as AppUser?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      accountHolderName: freezed == accountHolderName
          ? _value.accountHolderName
          : accountHolderName // ignore: cast_nullable_to_non_nullable
              as String?,
      bankAddress: freezed == bankAddress
          ? _value.bankAddress
          : bankAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      postcode: freezed == postcode
          ? _value.postcode
          : postcode // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      swiftCode: freezed == swiftCode
          ? _value.swiftCode
          : swiftCode // ignore: cast_nullable_to_non_nullable
              as String?,
      bankAccountProofKey: freezed == bankAccountProofKey
          ? _value.bankAccountProofKey
          : bankAccountProofKey // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: freezed == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AppUserCopyWith<$Res>? get appUser {
    if (_value.appUser == null) {
      return null;
    }

    return $AppUserCopyWith<$Res>(_value.appUser!, (value) {
      return _then(_value.copyWith(appUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BankDetailsImplCopyWith<$Res>
    implements $BankDetailsCopyWith<$Res> {
  factory _$$BankDetailsImplCopyWith(
          _$BankDetailsImpl value, $Res Function(_$BankDetailsImpl) then) =
      __$$BankDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AppUser? appUser,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? bankAddress,
      String? postcode,
      String? city,
      String? state,
      String? country,
      String? swiftCode,
      String? bankAccountProofKey,
      bool? isDeleted});

  @override
  $AppUserCopyWith<$Res>? get appUser;
}

/// @nodoc
class __$$BankDetailsImplCopyWithImpl<$Res>
    extends _$BankDetailsCopyWithImpl<$Res, _$BankDetailsImpl>
    implements _$$BankDetailsImplCopyWith<$Res> {
  __$$BankDetailsImplCopyWithImpl(
      _$BankDetailsImpl _value, $Res Function(_$BankDetailsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? appUser = freezed,
    Object? bankName = freezed,
    Object? accountNumber = freezed,
    Object? accountHolderName = freezed,
    Object? bankAddress = freezed,
    Object? postcode = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? swiftCode = freezed,
    Object? bankAccountProofKey = freezed,
    Object? isDeleted = freezed,
  }) {
    return _then(_$BankDetailsImpl(
      appUser: freezed == appUser
          ? _value.appUser
          : appUser // ignore: cast_nullable_to_non_nullable
              as AppUser?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      accountNumber: freezed == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      accountHolderName: freezed == accountHolderName
          ? _value.accountHolderName
          : accountHolderName // ignore: cast_nullable_to_non_nullable
              as String?,
      bankAddress: freezed == bankAddress
          ? _value.bankAddress
          : bankAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      postcode: freezed == postcode
          ? _value.postcode
          : postcode // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      swiftCode: freezed == swiftCode
          ? _value.swiftCode
          : swiftCode // ignore: cast_nullable_to_non_nullable
              as String?,
      bankAccountProofKey: freezed == bankAccountProofKey
          ? _value.bankAccountProofKey
          : bankAccountProofKey // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: freezed == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BankDetailsImpl extends _BankDetails {
  _$BankDetailsImpl(
      {this.appUser,
      this.bankName,
      this.accountNumber,
      this.accountHolderName,
      this.bankAddress,
      this.postcode,
      this.city,
      this.state,
      this.country,
      this.swiftCode,
      this.bankAccountProofKey,
      this.isDeleted})
      : super._();

  factory _$BankDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BankDetailsImplFromJson(json);

  @override
  AppUser? appUser;
  @override
  String? bankName;
  @override
  String? accountNumber;
  @override
  String? accountHolderName;
  @override
  String? bankAddress;
  @override
  String? postcode;
  @override
  String? city;
  @override
  String? state;
  @override
  String? country;
  @override
  String? swiftCode;
  @override
  String? bankAccountProofKey;
  @override
  bool? isDeleted;

  @override
  String toString() {
    return 'BankDetails(appUser: $appUser, bankName: $bankName, accountNumber: $accountNumber, accountHolderName: $accountHolderName, bankAddress: $bankAddress, postcode: $postcode, city: $city, state: $state, country: $country, swiftCode: $swiftCode, bankAccountProofKey: $bankAccountProofKey, isDeleted: $isDeleted)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BankDetailsImplCopyWith<_$BankDetailsImpl> get copyWith =>
      __$$BankDetailsImplCopyWithImpl<_$BankDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BankDetailsImplToJson(
      this,
    );
  }
}

abstract class _BankDetails extends BankDetails {
  factory _BankDetails(
      {AppUser? appUser,
      String? bankName,
      String? accountNumber,
      String? accountHolderName,
      String? bankAddress,
      String? postcode,
      String? city,
      String? state,
      String? country,
      String? swiftCode,
      String? bankAccountProofKey,
      bool? isDeleted}) = _$BankDetailsImpl;
  _BankDetails._() : super._();

  factory _BankDetails.fromJson(Map<String, dynamic> json) =
      _$BankDetailsImpl.fromJson;

  @override
  AppUser? get appUser;
  set appUser(AppUser? value);
  @override
  String? get bankName;
  set bankName(String? value);
  @override
  String? get accountNumber;
  set accountNumber(String? value);
  @override
  String? get accountHolderName;
  set accountHolderName(String? value);
  @override
  String? get bankAddress;
  set bankAddress(String? value);
  @override
  String? get postcode;
  set postcode(String? value);
  @override
  String? get city;
  set city(String? value);
  @override
  String? get state;
  set state(String? value);
  @override
  String? get country;
  set country(String? value);
  @override
  String? get swiftCode;
  set swiftCode(String? value);
  @override
  String? get bankAccountProofKey;
  set bankAccountProofKey(String? value);
  @override
  bool? get isDeleted;
  set isDeleted(bool? value);
  @override
  @JsonKey(ignore: true)
  _$$BankDetailsImplCopyWith<_$BankDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
