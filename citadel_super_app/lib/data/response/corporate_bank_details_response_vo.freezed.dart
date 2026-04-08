// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'corporate_bank_details_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CorporateBankDetailsResponseVo _$CorporateBankDetailsResponseVoFromJson(
    Map<String, dynamic> json) {
  return _CorporateBankDetailsResponseVo.fromJson(json);
}

/// @nodoc
mixin _$CorporateBankDetailsResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  BankDetailsVo? get corporateBankDetailsVo =>
      throw _privateConstructorUsedError;
  set corporateBankDetailsVo(BankDetailsVo? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CorporateBankDetailsResponseVoCopyWith<CorporateBankDetailsResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CorporateBankDetailsResponseVoCopyWith<$Res> {
  factory $CorporateBankDetailsResponseVoCopyWith(
          CorporateBankDetailsResponseVo value,
          $Res Function(CorporateBankDetailsResponseVo) then) =
      _$CorporateBankDetailsResponseVoCopyWithImpl<$Res,
          CorporateBankDetailsResponseVo>;
  @useResult
  $Res call(
      {String? code, String? message, BankDetailsVo? corporateBankDetailsVo});

  $BankDetailsVoCopyWith<$Res>? get corporateBankDetailsVo;
}

/// @nodoc
class _$CorporateBankDetailsResponseVoCopyWithImpl<$Res,
        $Val extends CorporateBankDetailsResponseVo>
    implements $CorporateBankDetailsResponseVoCopyWith<$Res> {
  _$CorporateBankDetailsResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? corporateBankDetailsVo = freezed,
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
      corporateBankDetailsVo: freezed == corporateBankDetailsVo
          ? _value.corporateBankDetailsVo
          : corporateBankDetailsVo // ignore: cast_nullable_to_non_nullable
              as BankDetailsVo?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BankDetailsVoCopyWith<$Res>? get corporateBankDetailsVo {
    if (_value.corporateBankDetailsVo == null) {
      return null;
    }

    return $BankDetailsVoCopyWith<$Res>(_value.corporateBankDetailsVo!,
        (value) {
      return _then(_value.copyWith(corporateBankDetailsVo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CorporateBankDetailsResponseVoImplCopyWith<$Res>
    implements $CorporateBankDetailsResponseVoCopyWith<$Res> {
  factory _$$CorporateBankDetailsResponseVoImplCopyWith(
          _$CorporateBankDetailsResponseVoImpl value,
          $Res Function(_$CorporateBankDetailsResponseVoImpl) then) =
      __$$CorporateBankDetailsResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code, String? message, BankDetailsVo? corporateBankDetailsVo});

  @override
  $BankDetailsVoCopyWith<$Res>? get corporateBankDetailsVo;
}

/// @nodoc
class __$$CorporateBankDetailsResponseVoImplCopyWithImpl<$Res>
    extends _$CorporateBankDetailsResponseVoCopyWithImpl<$Res,
        _$CorporateBankDetailsResponseVoImpl>
    implements _$$CorporateBankDetailsResponseVoImplCopyWith<$Res> {
  __$$CorporateBankDetailsResponseVoImplCopyWithImpl(
      _$CorporateBankDetailsResponseVoImpl _value,
      $Res Function(_$CorporateBankDetailsResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? corporateBankDetailsVo = freezed,
  }) {
    return _then(_$CorporateBankDetailsResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      corporateBankDetailsVo: freezed == corporateBankDetailsVo
          ? _value.corporateBankDetailsVo
          : corporateBankDetailsVo // ignore: cast_nullable_to_non_nullable
              as BankDetailsVo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CorporateBankDetailsResponseVoImpl
    extends _CorporateBankDetailsResponseVo {
  _$CorporateBankDetailsResponseVoImpl(
      {this.code, this.message, this.corporateBankDetailsVo})
      : super._();

  factory _$CorporateBankDetailsResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$CorporateBankDetailsResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  BankDetailsVo? corporateBankDetailsVo;

  @override
  String toString() {
    return 'CorporateBankDetailsResponseVo(code: $code, message: $message, corporateBankDetailsVo: $corporateBankDetailsVo)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CorporateBankDetailsResponseVoImplCopyWith<
          _$CorporateBankDetailsResponseVoImpl>
      get copyWith => __$$CorporateBankDetailsResponseVoImplCopyWithImpl<
          _$CorporateBankDetailsResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CorporateBankDetailsResponseVoImplToJson(
      this,
    );
  }
}

abstract class _CorporateBankDetailsResponseVo
    extends CorporateBankDetailsResponseVo {
  factory _CorporateBankDetailsResponseVo(
          {String? code,
          String? message,
          BankDetailsVo? corporateBankDetailsVo}) =
      _$CorporateBankDetailsResponseVoImpl;
  _CorporateBankDetailsResponseVo._() : super._();

  factory _CorporateBankDetailsResponseVo.fromJson(Map<String, dynamic> json) =
      _$CorporateBankDetailsResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  BankDetailsVo? get corporateBankDetailsVo;
  set corporateBankDetailsVo(BankDetailsVo? value);
  @override
  @JsonKey(ignore: true)
  _$$CorporateBankDetailsResponseVoImplCopyWith<
          _$CorporateBankDetailsResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
