// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_client_details_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentClientDetailsResponseVo _$AgentClientDetailsResponseVoFromJson(
    Map<String, dynamic> json) {
  return _AgentClientDetailsResponseVo.fromJson(json);
}

/// @nodoc
mixin _$AgentClientDetailsResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<ClientPortfolioVo>? get clientPortfolio =>
      throw _privateConstructorUsedError;
  set clientPortfolio(List<ClientPortfolioVo>? value) =>
      throw _privateConstructorUsedError;
  List<AgentDividendPayoutVo>? get dividendPayouts =>
      throw _privateConstructorUsedError;
  set dividendPayouts(List<AgentDividendPayoutVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentClientDetailsResponseVoCopyWith<AgentClientDetailsResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentClientDetailsResponseVoCopyWith<$Res> {
  factory $AgentClientDetailsResponseVoCopyWith(
          AgentClientDetailsResponseVo value,
          $Res Function(AgentClientDetailsResponseVo) then) =
      _$AgentClientDetailsResponseVoCopyWithImpl<$Res,
          AgentClientDetailsResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<ClientPortfolioVo>? clientPortfolio,
      List<AgentDividendPayoutVo>? dividendPayouts});
}

/// @nodoc
class _$AgentClientDetailsResponseVoCopyWithImpl<$Res,
        $Val extends AgentClientDetailsResponseVo>
    implements $AgentClientDetailsResponseVoCopyWith<$Res> {
  _$AgentClientDetailsResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? clientPortfolio = freezed,
    Object? dividendPayouts = freezed,
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
      clientPortfolio: freezed == clientPortfolio
          ? _value.clientPortfolio
          : clientPortfolio // ignore: cast_nullable_to_non_nullable
              as List<ClientPortfolioVo>?,
      dividendPayouts: freezed == dividendPayouts
          ? _value.dividendPayouts
          : dividendPayouts // ignore: cast_nullable_to_non_nullable
              as List<AgentDividendPayoutVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentClientDetailsResponseVoImplCopyWith<$Res>
    implements $AgentClientDetailsResponseVoCopyWith<$Res> {
  factory _$$AgentClientDetailsResponseVoImplCopyWith(
          _$AgentClientDetailsResponseVoImpl value,
          $Res Function(_$AgentClientDetailsResponseVoImpl) then) =
      __$$AgentClientDetailsResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<ClientPortfolioVo>? clientPortfolio,
      List<AgentDividendPayoutVo>? dividendPayouts});
}

/// @nodoc
class __$$AgentClientDetailsResponseVoImplCopyWithImpl<$Res>
    extends _$AgentClientDetailsResponseVoCopyWithImpl<$Res,
        _$AgentClientDetailsResponseVoImpl>
    implements _$$AgentClientDetailsResponseVoImplCopyWith<$Res> {
  __$$AgentClientDetailsResponseVoImplCopyWithImpl(
      _$AgentClientDetailsResponseVoImpl _value,
      $Res Function(_$AgentClientDetailsResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? clientPortfolio = freezed,
    Object? dividendPayouts = freezed,
  }) {
    return _then(_$AgentClientDetailsResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      clientPortfolio: freezed == clientPortfolio
          ? _value.clientPortfolio
          : clientPortfolio // ignore: cast_nullable_to_non_nullable
              as List<ClientPortfolioVo>?,
      dividendPayouts: freezed == dividendPayouts
          ? _value.dividendPayouts
          : dividendPayouts // ignore: cast_nullable_to_non_nullable
              as List<AgentDividendPayoutVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentClientDetailsResponseVoImpl extends _AgentClientDetailsResponseVo {
  _$AgentClientDetailsResponseVoImpl(
      {this.code, this.message, this.clientPortfolio, this.dividendPayouts})
      : super._();

  factory _$AgentClientDetailsResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AgentClientDetailsResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<ClientPortfolioVo>? clientPortfolio;
  @override
  List<AgentDividendPayoutVo>? dividendPayouts;

  @override
  String toString() {
    return 'AgentClientDetailsResponseVo(code: $code, message: $message, clientPortfolio: $clientPortfolio, dividendPayouts: $dividendPayouts)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentClientDetailsResponseVoImplCopyWith<
          _$AgentClientDetailsResponseVoImpl>
      get copyWith => __$$AgentClientDetailsResponseVoImplCopyWithImpl<
          _$AgentClientDetailsResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentClientDetailsResponseVoImplToJson(
      this,
    );
  }
}

abstract class _AgentClientDetailsResponseVo
    extends AgentClientDetailsResponseVo {
  factory _AgentClientDetailsResponseVo(
          {String? code,
          String? message,
          List<ClientPortfolioVo>? clientPortfolio,
          List<AgentDividendPayoutVo>? dividendPayouts}) =
      _$AgentClientDetailsResponseVoImpl;
  _AgentClientDetailsResponseVo._() : super._();

  factory _AgentClientDetailsResponseVo.fromJson(Map<String, dynamic> json) =
      _$AgentClientDetailsResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<ClientPortfolioVo>? get clientPortfolio;
  set clientPortfolio(List<ClientPortfolioVo>? value);
  @override
  List<AgentDividendPayoutVo>? get dividendPayouts;
  set dividendPayouts(List<AgentDividendPayoutVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentClientDetailsResponseVoImplCopyWith<
          _$AgentClientDetailsResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
