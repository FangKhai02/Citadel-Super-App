// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agency_list_response_vo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AgencyListResponseVo _$AgencyListResponseVoFromJson(Map<String, dynamic> json) {
  return _AgencyListResponseVo.fromJson(json);
}

/// @nodoc
mixin _$AgencyListResponseVo {
  String? get code => throw _privateConstructorUsedError;
  set code(String? value) => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  set message(String? value) => throw _privateConstructorUsedError;
  List<AgencyVo>? get agencyList => throw _privateConstructorUsedError;
  set agencyList(List<AgencyVo>? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgencyListResponseVoCopyWith<AgencyListResponseVo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgencyListResponseVoCopyWith<$Res> {
  factory $AgencyListResponseVoCopyWith(AgencyListResponseVo value,
          $Res Function(AgencyListResponseVo) then) =
      _$AgencyListResponseVoCopyWithImpl<$Res, AgencyListResponseVo>;
  @useResult
  $Res call({String? code, String? message, List<AgencyVo>? agencyList});
}

/// @nodoc
class _$AgencyListResponseVoCopyWithImpl<$Res,
        $Val extends AgencyListResponseVo>
    implements $AgencyListResponseVoCopyWith<$Res> {
  _$AgencyListResponseVoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? agencyList = freezed,
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
      agencyList: freezed == agencyList
          ? _value.agencyList
          : agencyList // ignore: cast_nullable_to_non_nullable
              as List<AgencyVo>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgencyListResponseVoImplCopyWith<$Res>
    implements $AgencyListResponseVoCopyWith<$Res> {
  factory _$$AgencyListResponseVoImplCopyWith(_$AgencyListResponseVoImpl value,
          $Res Function(_$AgencyListResponseVoImpl) then) =
      __$$AgencyListResponseVoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? message, List<AgencyVo>? agencyList});
}

/// @nodoc
class __$$AgencyListResponseVoImplCopyWithImpl<$Res>
    extends _$AgencyListResponseVoCopyWithImpl<$Res, _$AgencyListResponseVoImpl>
    implements _$$AgencyListResponseVoImplCopyWith<$Res> {
  __$$AgencyListResponseVoImplCopyWithImpl(_$AgencyListResponseVoImpl _value,
      $Res Function(_$AgencyListResponseVoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? agencyList = freezed,
  }) {
    return _then(_$AgencyListResponseVoImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      agencyList: freezed == agencyList
          ? _value.agencyList
          : agencyList // ignore: cast_nullable_to_non_nullable
              as List<AgencyVo>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgencyListResponseVoImpl extends _AgencyListResponseVo {
  _$AgencyListResponseVoImpl({this.code, this.message, this.agencyList})
      : super._();

  factory _$AgencyListResponseVoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgencyListResponseVoImplFromJson(json);

  @override
  String? code;
  @override
  String? message;
  @override
  List<AgencyVo>? agencyList;

  @override
  String toString() {
    return 'AgencyListResponseVo(code: $code, message: $message, agencyList: $agencyList)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgencyListResponseVoImplCopyWith<_$AgencyListResponseVoImpl>
      get copyWith =>
          __$$AgencyListResponseVoImplCopyWithImpl<_$AgencyListResponseVoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgencyListResponseVoImplToJson(
      this,
    );
  }
}

abstract class _AgencyListResponseVo extends AgencyListResponseVo {
  factory _AgencyListResponseVo(
      {String? code,
      String? message,
      List<AgencyVo>? agencyList}) = _$AgencyListResponseVoImpl;
  _AgencyListResponseVo._() : super._();

  factory _AgencyListResponseVo.fromJson(Map<String, dynamic> json) =
      _$AgencyListResponseVoImpl.fromJson;

  @override
  String? get code;
  set code(String? value);
  @override
  String? get message;
  set message(String? value);
  @override
  List<AgencyVo>? get agencyList;
  set agencyList(List<AgencyVo>? value);
  @override
  @JsonKey(ignore: true)
  _$$AgencyListResponseVoImplCopyWith<_$AgencyListResponseVoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
