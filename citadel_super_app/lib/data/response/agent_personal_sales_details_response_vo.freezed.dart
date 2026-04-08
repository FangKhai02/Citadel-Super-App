// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_personal_sales_details_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentPersonalSalesDetailsResponseVo
    _$AgentPersonalSalesDetailsResponseVoFromJson(Map<String, dynamic> json) {
  return _AgentPersonalSalesDetailsResponseVo.fromJson(json);
}

/// @nodoc
mixin _$AgentPersonalSalesDetailsResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<AgentPersonalSalesDetailsVo>? get salesDetails =>
      throw _privateConstructorUsedError;
  set salesDetails(List<AgentPersonalSalesDetailsVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentPersonalSalesDetailsResponseVoCopyWith<
          AgentPersonalSalesDetailsResponseVo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentPersonalSalesDetailsResponseVoCopyWith<$Res> {
  factory $AgentPersonalSalesDetailsResponseVoCopyWith(
          AgentPersonalSalesDetailsResponseVo value,
          $Res Function(AgentPersonalSalesDetailsResponseVo) then) =
      _$AgentPersonalSalesDetailsResponseVoCopyWithImpl<$Res,
          AgentPersonalSalesDetailsResponseVo>;
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<AgentPersonalSalesDetailsVo>? salesDetails});
}

/// @nodoc
class _$AgentPersonalSalesDetailsResponseVoCopyWithImpl<$Res,
        $Val extends AgentPersonalSalesDetailsResponseVo>
    implements $AgentPersonalSalesDetailsResponseVoCopyWith<$Res> {
  _$AgentPersonalSalesDetailsResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? salesDetails = freezed,
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
      salesDetails: freezed == salesDetails
          ? _value.salesDetails
          : salesDetails // ignore: cast_nullable_to_non_nullable
              as List<AgentPersonalSalesDetailsVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentPersonalSalesDetailsResponseVoImplCopyWith<$Res>
    implements $AgentPersonalSalesDetailsResponseVoCopyWith<$Res> {
  factory _$$AgentPersonalSalesDetailsResponseVoImplCopyWith(
          _$AgentPersonalSalesDetailsResponseVoImpl value,
          $Res Function(_$AgentPersonalSalesDetailsResponseVoImpl) then) =
      __$$AgentPersonalSalesDetailsResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? code,
      String? message,
      List<AgentPersonalSalesDetailsVo>? salesDetails});
}

/// @nodoc
class __$$AgentPersonalSalesDetailsResponseVoImplCopyWithImpl<$Res>
    extends _$AgentPersonalSalesDetailsResponseVoCopyWithImpl<$Res,
        _$AgentPersonalSalesDetailsResponseVoImpl>
    implements _$$AgentPersonalSalesDetailsResponseVoImplCopyWith<$Res> {
  __$$AgentPersonalSalesDetailsResponseVoImplCopyWithImpl(
      _$AgentPersonalSalesDetailsResponseVoImpl _value,
      $Res Function(_$AgentPersonalSalesDetailsResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? salesDetails = freezed,
  }) {
    return _then(_$AgentPersonalSalesDetailsResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      salesDetails: freezed == salesDetails
          ? _value.salesDetails
          : salesDetails // ignore: cast_nullable_to_non_nullable
              as List<AgentPersonalSalesDetailsVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentPersonalSalesDetailsResponseVoImpl
    extends _AgentPersonalSalesDetailsResponseVo {
  _$AgentPersonalSalesDetailsResponseVoImpl(
      {this.code, this.message, this.salesDetails})
      : super._();

  factory _$AgentPersonalSalesDetailsResponseVoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$AgentPersonalSalesDetailsResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<AgentPersonalSalesDetailsVo>? salesDetails;

  @override
  String toString() {
    return 'AgentPersonalSalesDetailsResponseVo(code: $code, message: $message, salesDetails: $salesDetails)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentPersonalSalesDetailsResponseVoImplCopyWith<
          _$AgentPersonalSalesDetailsResponseVoImpl>
      get copyWith => __$$AgentPersonalSalesDetailsResponseVoImplCopyWithImpl<
          _$AgentPersonalSalesDetailsResponseVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentPersonalSalesDetailsResponseVoImplToJson(
      this,
    );
  }
}

abstract class _AgentPersonalSalesDetailsResponseVo
    extends AgentPersonalSalesDetailsResponseVo {
  factory _AgentPersonalSalesDetailsResponseVo(
          {String? code,
          String? message,
          List<AgentPersonalSalesDetailsVo>? salesDetails}) =
      _$AgentPersonalSalesDetailsResponseVoImpl;
  _AgentPersonalSalesDetailsResponseVo._() : super._();

  factory _AgentPersonalSalesDetailsResponseVo.fromJson(
          Map<String, dynamic> json) =
      _$AgentPersonalSalesDetailsResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<AgentPersonalSalesDetailsVo>? get salesDetails;
  set salesDetails(List<AgentPersonalSalesDetailsVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentPersonalSalesDetailsResponseVoImplCopyWith<
          _$AgentPersonalSalesDetailsResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
