// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'client_portfolio_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClientPortfolioResponseVo _$ClientPortfolioResponseVoFromJson(
    Map<String, dynamic> json) {
  return _ClientPortfolioResponseVo.fromJson(json);
}

/// @nodoc
mixin _$ClientPortfolioResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<ClientPortfolioVo>? get portfolio => throw _privateConstructorUsedError;
  set portfolio(List<ClientPortfolioVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientPortfolioResponseVoCopyWith<ClientPortfolioResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientPortfolioResponseVoCopyWith<$Res> {
  factory $ClientPortfolioResponseVoCopyWith(ClientPortfolioResponseVo value,
          $Res Function(ClientPortfolioResponseVo) then) =
      _$ClientPortfolioResponseVoCopyWithImpl<$Res, ClientPortfolioResponseVo>;
  @useResult
  $Res call(
      {String? code, String? message, List<ClientPortfolioVo>? portfolio});
}

/// @nodoc
class _$ClientPortfolioResponseVoCopyWithImpl<$Res,
        $Val extends ClientPortfolioResponseVo>
    implements $ClientPortfolioResponseVoCopyWith<$Res> {
  _$ClientPortfolioResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? portfolio = freezed,
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
      portfolio: freezed == portfolio
          ? _value.portfolio
          : portfolio // ignore: cast_nullable_to_non_nullable
              as List<ClientPortfolioVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClientPortfolioResponseVoImplCopyWith<$Res>
    implements $ClientPortfolioResponseVoCopyWith<$Res> {
  factory _$$ClientPortfolioResponseVoImplCopyWith(
          _$ClientPortfolioResponseVoImpl value,
          $Res Function(_$ClientPortfolioResponseVoImpl) then) =
      __$$ClientPortfolioResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code, String? message, List<ClientPortfolioVo>? portfolio});
}

/// @nodoc
class __$$ClientPortfolioResponseVoImplCopyWithImpl<$Res>
    extends _$ClientPortfolioResponseVoCopyWithImpl<$Res,
        _$ClientPortfolioResponseVoImpl>
    implements _$$ClientPortfolioResponseVoImplCopyWith<$Res> {
  __$$ClientPortfolioResponseVoImplCopyWithImpl(
      _$ClientPortfolioResponseVoImpl _value,
      $Res Function(_$ClientPortfolioResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? portfolio = freezed,
  }) {
    return _then(_$ClientPortfolioResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      portfolio: freezed == portfolio
          ? _value.portfolio
          : portfolio // ignore: cast_nullable_to_non_nullable
              as List<ClientPortfolioVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClientPortfolioResponseVoImpl extends _ClientPortfolioResponseVo {
  _$ClientPortfolioResponseVoImpl({this.code, this.message, this.portfolio})
      : super._();

  factory _$ClientPortfolioResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClientPortfolioResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<ClientPortfolioVo>? portfolio;

  @override
  String toString() {
    return 'ClientPortfolioResponseVo(code: $code, message: $message, portfolio: $portfolio)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClientPortfolioResponseVoImplCopyWith<_$ClientPortfolioResponseVoImpl>
      get copyWith => __$$ClientPortfolioResponseVoImplCopyWithImpl<
          _$ClientPortfolioResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClientPortfolioResponseVoImplToJson(
      this,
    );
  }
}

abstract class _ClientPortfolioResponseVo extends ClientPortfolioResponseVo {
  factory _ClientPortfolioResponseVo(
      {String? code,
      String? message,
      List<ClientPortfolioVo>? portfolio}) = _$ClientPortfolioResponseVoImpl;
  _ClientPortfolioResponseVo._() : super._();

  factory _ClientPortfolioResponseVo.fromJson(Map<String, dynamic> json) =
      _$ClientPortfolioResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<ClientPortfolioVo>? get portfolio;
  set portfolio(List<ClientPortfolioVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$ClientPortfolioResponseVoImplCopyWith<_$ClientPortfolioResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
