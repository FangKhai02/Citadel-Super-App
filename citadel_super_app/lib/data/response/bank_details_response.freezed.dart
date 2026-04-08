// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_details_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BankDetailsResponse _$BankDetailsResponseFromJson(Map<String, dynamic> json) {
  return _BankDetailsResponse.fromJson(json);
}

/// @nodoc
mixin _$BankDetailsResponse {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<BankDetailsVo>? get bankDetails => throw _privateConstructorUsedError;
  set bankDetails(List<BankDetailsVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BankDetailsResponseCopyWith<BankDetailsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankDetailsResponseCopyWith<$Res> {
  factory $BankDetailsResponseCopyWith(
          BankDetailsResponse value, $Res Function(BankDetailsResponse) then) =
      _$BankDetailsResponseCopyWithImpl<$Res, BankDetailsResponse>;
  @useResult
  $Res call({String? code, String? message, List<BankDetailsVo>? bankDetails});
}

/// @nodoc
class _$BankDetailsResponseCopyWithImpl<$Res, $Val extends BankDetailsResponse>
    implements $BankDetailsResponseCopyWith<$Res> {
  _$BankDetailsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? bankDetails = freezed,
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
      bankDetails: freezed == bankDetails
          ? _value.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as List<BankDetailsVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BankDetailsResponseImplCopyWith<$Res>
    implements $BankDetailsResponseCopyWith<$Res> {
  factory _$$BankDetailsResponseImplCopyWith(_$BankDetailsResponseImpl value,
          $Res Function(_$BankDetailsResponseImpl) then) =
      __$$BankDetailsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, List<BankDetailsVo>? bankDetails});
}

/// @nodoc
class __$$BankDetailsResponseImplCopyWithImpl<$Res>
    extends _$BankDetailsResponseCopyWithImpl<$Res, _$BankDetailsResponseImpl>
    implements _$$BankDetailsResponseImplCopyWith<$Res> {
  __$$BankDetailsResponseImplCopyWithImpl(_$BankDetailsResponseImpl _value,
      $Res Function(_$BankDetailsResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? bankDetails = freezed,
  }) {
    return _then(_$BankDetailsResponseImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      bankDetails: freezed == bankDetails
          ? _value.bankDetails
          : bankDetails // ignore: cast_nullable_to_non_nullable
              as List<BankDetailsVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BankDetailsResponseImpl extends _BankDetailsResponse {
  _$BankDetailsResponseImpl({this.code, this.message, this.bankDetails})
      : super._();

  factory _$BankDetailsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BankDetailsResponseImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<BankDetailsVo>? bankDetails;

  @override
  String toString() {
    return 'BankDetailsResponse(code: $code, message: $message, bankDetails: $bankDetails)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BankDetailsResponseImplCopyWith<_$BankDetailsResponseImpl> get copyWith =>
      __$$BankDetailsResponseImplCopyWithImpl<_$BankDetailsResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BankDetailsResponseImplToJson(
      this,
    );
  }
}

abstract class _BankDetailsResponse extends BankDetailsResponse {
  factory _BankDetailsResponse(
      {String? code,
      String? message,
      List<BankDetailsVo>? bankDetails}) = _$BankDetailsResponseImpl;
  _BankDetailsResponse._() : super._();

  factory _BankDetailsResponse.fromJson(Map<String, dynamic> json) =
      _$BankDetailsResponseImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<BankDetailsVo>? get bankDetails;
  set bankDetails(List<BankDetailsVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$BankDetailsResponseImplCopyWith<_$BankDetailsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
