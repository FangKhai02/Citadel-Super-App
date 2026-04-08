// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_pending_signature_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentPendingSignatureResponseVo _$AgentPendingSignatureResponseVoFromJson(
    Map<String, dynamic> json) {
  return _AgentPendingSignatureResponseVo.fromJson(json);
}

/// @nodoc
mixin _$AgentPendingSignatureResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<ClientPortfolioVo>? get productOrders =>
      throw _privateConstructorUsedError;
  set productOrders(List<ClientPortfolioVo>? value) =>
      throw _privateConstructorUsedError;
  List<ClientPortfolioVo>? get earlyRedemptions =>
      throw _privateConstructorUsedError;
  set earlyRedemptions(List<ClientPortfolioVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentPendingSignatureResponseVoCopyWith<AgentPendingSignatureResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentPendingSignatureResponseVoCopyWith<$Res> {
  factory $AgentPendingSignatureResponseVoCopyWith(
          AgentPendingSignatureResponseVo value,
          $Res Function(AgentPendingSignatureResponseVo) then) =
      _$AgentPendingSignatureResponseVoCopyWithImpl<$Res,
          AgentPendingSignatureResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<ClientPortfolioVo>? productOrders,
      List<ClientPortfolioVo>? earlyRedemptions});
}

/// @nodoc
class _$AgentPendingSignatureResponseVoCopyWithImpl<$Res,
        $Val extends AgentPendingSignatureResponseVo>
    implements $AgentPendingSignatureResponseVoCopyWith<$Res> {
  _$AgentPendingSignatureResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? productOrders = freezed,
    Object? earlyRedemptions = freezed,
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
      productOrders: freezed == productOrders
          ? _value.productOrders
          : productOrders // ignore: cast_nullable_to_non_nullable
              as List<ClientPortfolioVo>?,
      earlyRedemptions: freezed == earlyRedemptions
          ? _value.earlyRedemptions
          : earlyRedemptions // ignore: cast_nullable_to_non_nullable
              as List<ClientPortfolioVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentPendingSignatureResponseVoImplCopyWith<$Res>
    implements $AgentPendingSignatureResponseVoCopyWith<$Res> {
  factory _$$AgentPendingSignatureResponseVoImplCopyWith(
          _$AgentPendingSignatureResponseVoImpl value,
          $Res Function(_$AgentPendingSignatureResponseVoImpl) then) =
      __$$AgentPendingSignatureResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<ClientPortfolioVo>? productOrders,
      List<ClientPortfolioVo>? earlyRedemptions});
}

/// @nodoc
class __$$AgentPendingSignatureResponseVoImplCopyWithImpl<$Res>
    extends _$AgentPendingSignatureResponseVoCopyWithImpl<$Res,
        _$AgentPendingSignatureResponseVoImpl>
    implements _$$AgentPendingSignatureResponseVoImplCopyWith<$Res> {
  __$$AgentPendingSignatureResponseVoImplCopyWithImpl(
      _$AgentPendingSignatureResponseVoImpl _value,
      $Res Function(_$AgentPendingSignatureResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? productOrders = freezed,
    Object? earlyRedemptions = freezed,
  }) {
    return _then(_$AgentPendingSignatureResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      productOrders: freezed == productOrders
          ? _value.productOrders
          : productOrders // ignore: cast_nullable_to_non_nullable
              as List<ClientPortfolioVo>?,
      earlyRedemptions: freezed == earlyRedemptions
          ? _value.earlyRedemptions
          : earlyRedemptions // ignore: cast_nullable_to_non_nullable
              as List<ClientPortfolioVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentPendingSignatureResponseVoImpl
    extends _AgentPendingSignatureResponseVo {
  _$AgentPendingSignatureResponseVoImpl(
      {this.code, this.message, this.productOrders, this.earlyRedemptions})
      : super._();

  factory _$AgentPendingSignatureResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AgentPendingSignatureResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<ClientPortfolioVo>? productOrders;
  @override
  List<ClientPortfolioVo>? earlyRedemptions;

  @override
  String toString() {
    return 'AgentPendingSignatureResponseVo(code: $code, message: $message, productOrders: $productOrders, earlyRedemptions: $earlyRedemptions)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentPendingSignatureResponseVoImplCopyWith<
          _$AgentPendingSignatureResponseVoImpl>
      get copyWith => __$$AgentPendingSignatureResponseVoImplCopyWithImpl<
          _$AgentPendingSignatureResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentPendingSignatureResponseVoImplToJson(
      this,
    );
  }
}

abstract class _AgentPendingSignatureResponseVo
    extends AgentPendingSignatureResponseVo {
  factory _AgentPendingSignatureResponseVo(
          {String? code,
          String? message,
          List<ClientPortfolioVo>? productOrders,
          List<ClientPortfolioVo>? earlyRedemptions}) =
      _$AgentPendingSignatureResponseVoImpl;
  _AgentPendingSignatureResponseVo._() : super._();

  factory _AgentPendingSignatureResponseVo.fromJson(Map<String, dynamic> json) =
      _$AgentPendingSignatureResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<ClientPortfolioVo>? get productOrders;
  set productOrders(List<ClientPortfolioVo>? value);
  @override
  List<ClientPortfolioVo>? get earlyRedemptions;
  set earlyRedemptions(List<ClientPortfolioVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentPendingSignatureResponseVoImplCopyWith<
          _$AgentPendingSignatureResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
