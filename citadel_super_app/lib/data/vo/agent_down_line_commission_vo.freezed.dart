// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agent_down_line_commission_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgentDownLineCommissionVo _$AgentDownLineCommissionVoFromJson(
    Map<String, dynamic> json) {
  return _AgentDownLineCommissionVo.fromJson(json);
}

/// @nodoc
mixin _$AgentDownLineCommissionVo {
  String? get productCode => throw _privateConstructorUsedError;
  set productCode(String? value) => throw _privateConstructorUsedError;
  List<AgentDownLineProductOrderCommissionDetailsVo>? get commissionList =>
      throw _privateConstructorUsedError;
  set commissionList(
          List<AgentDownLineProductOrderCommissionDetailsVo>? value) =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgentDownLineCommissionVoCopyWith<AgentDownLineCommissionVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgentDownLineCommissionVoCopyWith<$Res> {
  factory $AgentDownLineCommissionVoCopyWith(AgentDownLineCommissionVo value,
          $Res Function(AgentDownLineCommissionVo) then) =
      _$AgentDownLineCommissionVoCopyWithImpl<$Res, AgentDownLineCommissionVo>;
  @useResult
  $Res call(
      {String? productCode,
      List<AgentDownLineProductOrderCommissionDetailsVo>? commissionList});
}

/// @nodoc
class _$AgentDownLineCommissionVoCopyWithImpl<$Res,
        $Val extends AgentDownLineCommissionVo>
    implements $AgentDownLineCommissionVoCopyWith<$Res> {
  _$AgentDownLineCommissionVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productCode = freezed,
    Object? commissionList = freezed,
  }) {
    return _then(_value.copyWith(
      productCode: freezed == productCode
          ? _value.productCode
          : productCode // ignore: cast_nullable_to_non_nullable
              as String?,
      commissionList: freezed == commissionList
          ? _value.commissionList
          : commissionList // ignore: cast_nullable_to_non_nullable
              as List<AgentDownLineProductOrderCommissionDetailsVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgentDownLineCommissionVoImplCopyWith<$Res>
    implements $AgentDownLineCommissionVoCopyWith<$Res> {
  factory _$$AgentDownLineCommissionVoImplCopyWith(
          _$AgentDownLineCommissionVoImpl value,
          $Res Function(_$AgentDownLineCommissionVoImpl) then) =
      __$$AgentDownLineCommissionVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? productCode,
      List<AgentDownLineProductOrderCommissionDetailsVo>? commissionList});
}

/// @nodoc
class __$$AgentDownLineCommissionVoImplCopyWithImpl<$Res>
    extends _$AgentDownLineCommissionVoCopyWithImpl<$Res,
        _$AgentDownLineCommissionVoImpl>
    implements _$$AgentDownLineCommissionVoImplCopyWith<$Res> {
  __$$AgentDownLineCommissionVoImplCopyWithImpl(
      _$AgentDownLineCommissionVoImpl _value,
      $Res Function(_$AgentDownLineCommissionVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productCode = freezed,
    Object? commissionList = freezed,
  }) {
    return _then(_$AgentDownLineCommissionVoImpl(
      productCode: freezed == productCode
          ? _value.productCode
          : productCode // ignore: cast_nullable_to_non_nullable
              as String?,
      commissionList: freezed == commissionList
          ? _value.commissionList
          : commissionList // ignore: cast_nullable_to_non_nullable
              as List<AgentDownLineProductOrderCommissionDetailsVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgentDownLineCommissionVoImpl extends _AgentDownLineCommissionVo {
  _$AgentDownLineCommissionVoImpl({this.productCode, this.commissionList})
      : super._();

  factory _$AgentDownLineCommissionVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgentDownLineCommissionVoImplFromJson(json);

  @override
  String? productCode;
  @override
  List<AgentDownLineProductOrderCommissionDetailsVo>? commissionList;

  @override
  String toString() {
    return 'AgentDownLineCommissionVo(productCode: $productCode, commissionList: $commissionList)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgentDownLineCommissionVoImplCopyWith<_$AgentDownLineCommissionVoImpl>
      get copyWith => __$$AgentDownLineCommissionVoImplCopyWithImpl<
          _$AgentDownLineCommissionVoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgentDownLineCommissionVoImplToJson(
      this,
    );
  }
}

abstract class _AgentDownLineCommissionVo extends AgentDownLineCommissionVo {
  factory _AgentDownLineCommissionVo(
          {String? productCode,
          List<AgentDownLineProductOrderCommissionDetailsVo>? commissionList}) =
      _$AgentDownLineCommissionVoImpl;
  _AgentDownLineCommissionVo._() : super._();

  factory _AgentDownLineCommissionVo.fromJson(Map<String, dynamic> json) =
      _$AgentDownLineCommissionVoImpl.fromJson;

  @override
  String? get productCode;
  set productCode(String? value);
  @override
  List<AgentDownLineProductOrderCommissionDetailsVo>? get commissionList;
  set commissionList(List<AgentDownLineProductOrderCommissionDetailsVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$AgentDownLineCommissionVoImplCopyWith<_$AgentDownLineCommissionVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
